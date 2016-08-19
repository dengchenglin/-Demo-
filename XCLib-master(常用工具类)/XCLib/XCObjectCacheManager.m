

#import "XCObjectCacheManager.h"
#import "XCSecurityUtil.h"
#import <UIKit/UIApplication.h>
//本地缓存7天
static const int CacheMaxAgeSeconds = 7 * 24 * 60 * 60;
//每项的最大内存存储大小16kb
static const int MaxMemoryCacheSize = 1024 * 16;

static NSUInteger CacheItemSize(id item) {
    return [[NSKeyedArchiver archivedDataWithRootObject:item] length];
}

@interface XCObjectCacheItem : NSObject<NSCoding,NSCopying>
@property (nonatomic, assign) NSTimeInterval expired;
@property (nonatomic, strong) id data;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger xc_size;

+ (instancetype)itemWithName:(NSString *)name expired:(NSTimeInterval)expired data:(id)data;
@end

@implementation XCObjectCacheItem

+ (instancetype)itemWithName:(NSString *)name expired:(NSTimeInterval)expired data:(id)data
{
    if (!name) {
        return nil;
    }
    XCObjectCacheItem *item = [[XCObjectCacheItem alloc] init];
    item.name = name;
    item.expired = expired;
    item.data = data;
    item.xc_size = CacheItemSize(item);
    return item;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.expired = [aDecoder decodeDoubleForKey:@"expired"];
        self.data = [aDecoder decodeObjectForKey:@"data"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.xc_size = [aDecoder decodeIntegerForKey:@"size"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeDouble:self.expired forKey:@"expired"];
    [aCoder encodeObject:self.data forKey:@"data"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.xc_size forKey:@"size"];
}

- (id)copyWithZone:(NSZone *)zone
{
    id copySelf = [[self class] allocWithZone:zone];
    [copySelf setExpired:self.expired];
    [copySelf setData:self.data];
    [copySelf setName:[self.name copy]];
    [copySelf setXc_size:self.xc_size];
    return copySelf;
}

@end

@interface XCObjectCacheManager ()
@property (nonatomic, strong) dispatch_queue_t cacheIOQueue;
@property (nonatomic, copy) NSString *savaDiskRootPath;
@property (nonatomic, strong) NSCache *memoryCache;
@property (nonatomic, strong) NSMutableArray *memoryCacheKeys;
@end

@implementation XCObjectCacheManager

- (id)init
{
    if (self = [super init]) {
        _cacheIOQueue = dispatch_queue_create("cn.sinsmin.ObjectCacheQueue", DISPATCH_QUEUE_CONCURRENT);
        _savaDiskRootPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"cn.sinsmin.ObjectCache"];
        _memoryCache = [[NSCache alloc] init];
        _memoryCache.name = @"cn.sinsmin.ObjectCache.MemoryCache";
        _memoryCache.countLimit = 1000;
        _memoryCache.totalCostLimit = 1024 * 1000;
        _memoryCacheKeys = [NSMutableArray arrayWithCapacity:0];
        NSFileManager *fm = [NSFileManager defaultManager];
        BOOL isDir = NO;
        BOOL isDirExist = [fm fileExistsAtPath:_savaDiskRootPath isDirectory:&isDir];
        if (!(isDirExist && isDir)) {
            [fm createDirectoryAtPath:_savaDiskRootPath withIntermediateDirectories:YES attributes:nil error:NULL];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)saveWithItem:(XCObjectCacheItem *)item
{
    if (!item || !item.data || !item.name) {
        return;
    }
    dispatch_async(_cacheIOQueue, ^{
        [self validateDataSize:item];
        [self archive:item name:item.name];
    });
}

- (void)validateDataSize:(XCObjectCacheItem *)item
{
    if (CacheItemSize(item) <= MaxMemoryCacheSize) {
        [self.memoryCacheKeys addObject:item.name];
        [self.memoryCache setObject:item forKey:item.name];
    }
}

- (void)archive:(id)object name:(NSString *)name
{
    [NSKeyedArchiver archiveRootObject:object toFile:[_savaDiskRootPath stringByAppendingPathComponent:[XCSecurityUtil md5:name]]];
}

- (id)unarchive:(NSString *)name
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[_savaDiskRootPath stringByAppendingPathComponent:[XCSecurityUtil md5:name]]];
}

- (void)didReceiveMemoryWarning
{
    dispatch_async(self.cacheIOQueue, ^{
        for (NSString *key in self.memoryCacheKeys) {
            XCObjectCacheItem *item = [self.memoryCache objectForKey:key];
            [self archive:item name:item.name];
        }
        [self.memoryCache removeAllObjects];
        [self.memoryCacheKeys removeAllObjects];
    });
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public Method
+ (instancetype)sharedCacheManager
{
    static XCObjectCacheManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[XCObjectCacheManager alloc] init];
    });
    return _sharedClient;
}

- (void)queryCacheForKey:(NSString *)name completion:(void (^)(id))completion
{
    if (!completion || name.length < 1) {
        return;
    }
    dispatch_async(_cacheIOQueue, ^{
        id obj = [self syncQueryCacheForKey:name];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(obj);
            });
        }
    });
}

- (id)syncQueryCacheForKey:(NSString *)name
{
    if (!name) {
        return nil;
    }
    if ([self.memoryCacheKeys containsObject:name]) {
        XCObjectCacheItem *item = [self.memoryCache objectForKey:name];
        if (item) {
            return item.data;
        }
    }
    NSString *filePath = [_savaDiskRootPath stringByAppendingPathComponent:[XCSecurityUtil md5:name]];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath]) {
        NSDate *mdate = [fm attributesOfItemAtPath:filePath error:NULL][NSFileModificationDate];
        XCObjectCacheItem *item = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        NSTimeInterval detal = [[NSDate date] timeIntervalSinceDate:mdate];
        if (detal >= item.expired) {
            [self removeCacheForKey:name completion:nil];
        } else {
            [self validateDataSize:item];
            return item.data;
        }
    }
    return nil;
}

- (void)saveForKey:(NSString *)name object:(id<NSCoding>)data
{
    [self saveWithItem:[XCObjectCacheItem itemWithName:name expired:CacheMaxAgeSeconds data:data]];
}

- (void)saveForKey:(NSString *)name object:(id<NSCoding>)data expired:(NSTimeInterval)expired
{
    [self saveWithItem:[XCObjectCacheItem itemWithName:name expired:expired data:data]];
}

- (void)removeCacheForKey:(NSString *)name completion:(dispatch_block_t)completion
{
    if (!name) {
        return;
    }
    dispatch_async(_cacheIOQueue, ^{
        [self.memoryCacheKeys removeObject:name];
        [self.memoryCache removeObjectForKey:name];
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm removeItemAtPath:[_savaDiskRootPath stringByAppendingPathComponent:[XCSecurityUtil md5:name]] error:NULL];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), completion);
        }
    });
}

- (unsigned long long)getAllCacheSize
{
    unsigned long long totalSize = 0;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDirectoryEnumerator *fileEnumerator = [fm enumeratorAtPath:_savaDiskRootPath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [_savaDiskRootPath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [fm attributesOfItemAtPath:filePath error:NULL];
        totalSize += [attrs fileSize];
    }
    for (NSString *key in self.memoryCacheKeys) {
        XCObjectCacheItem *item = [self.memoryCache objectForKey:key];
        if (item) {
            totalSize += item.xc_size;
        }
    }
    return totalSize;
}

- (void)clearAllCacheWithCompletionHandler:(dispatch_block_t)completion
{
    dispatch_async(_cacheIOQueue, ^{
        [self.memoryCacheKeys removeAllObjects];
        [self.memoryCache removeAllObjects];
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm removeItemAtPath:_savaDiskRootPath error:NULL];
        [fm createDirectoryAtPath:_savaDiskRootPath  withIntermediateDirectories:YES attributes:nil error:NULL];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), completion);
        }
    });
}
@end
