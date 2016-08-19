
#import "XCIOManager.h"

@implementation XCIOManager

static NSString* GetDocumentDirectoryFilePath()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

static NSString* GetCacheDirectoryFilePath()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (instancetype)defaultManager
{
    static XCIOManager *_defaultInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultInstance = [[XCIOManager alloc] initWithPathType:IOManagerSavePathTypeDocument];
    });
    return _defaultInstance;
}

+ (NSString *)getRootPath:(IOManagerSavePathType)pathType
{
    if (pathType == IOManagerSavePathTypeDocument) {
        return GetDocumentDirectoryFilePath();
    } else if (pathType == IOManagerSavePathTypeCache) {
        return GetCacheDirectoryFilePath();
    }
    return NSTemporaryDirectory();
}

- (NSString *)getFullFilePathWithName:(NSString *)name
{
    return [_saveRootPath stringByAppendingPathComponent:name];
}

- (instancetype)initWithPathType:(IOManagerSavePathType)pathType
{
    if (self = [super init]) {
        [self setPathType:pathType];
    }
    return self;
}

- (void)setPathType:(IOManagerSavePathType)pathType
{
    _pathType = pathType;
    if (pathType == IOManagerSavePathTypeDocument) {
        _saveRootPath = GetDocumentDirectoryFilePath();
    } else if (pathType == IOManagerSavePathTypeCache) {
        _saveRootPath = GetCacheDirectoryFilePath();
    } else {
        _saveRootPath =  NSTemporaryDirectory();
    }
}

- (BOOL)createDirectoryWithName:(NSString *)dirName
{
    if (!dirName) {
        return NO;
    }
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = YES;
    NSString *dirPath = [self getFullFilePathWithName:dirName];
    BOOL isExists = [fm fileExistsAtPath:[self getFullFilePathWithName:dirName] isDirectory:&isDir];
    if (!isExists && isDir) {
        return [fm createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return NO;
}

- (BOOL)writeToFile:(NSString *)fileName data:(NSData *)fileData
{
    if (!fileName || !fileData) {
        return NO;
    }
    return [fileData writeToFile:[self getFullFilePathWithName:fileName] atomically:YES];
}

- (NSData *)readFromFile:(NSString *)fileName
{
    if (!fileName) {
        return nil;
    }
    return [NSData dataWithContentsOfFile:[self getFullFilePathWithName:fileName]];
}

- (void)removeDirectoryWithName:(NSString *)dirName
{
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:[self getFullFilePathWithName:dirName] error:NULL];
}

- (void)removeFileWithName:(NSString *)fileName
{
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:[self getFullFilePathWithName:fileName] error:NULL];
}
@end

@implementation XCIOManager (NSUserDefaultsManager)

- (id)getNSUserDefaultsValueWithKey:(NSString *)key
{
    if (!key) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
- (void)setNSUserDefaultsValueWithKey:(NSString *)key forValue:(id)value
{
    if (!key || !value) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

- (void)removeNSUserDefaultsValueWithKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}
@end

@implementation XCIOManager (ArchiveObjectManager)

- (id)getArchiveObjectWithFileName:(NSString *)fileName
{
    if (!fileName) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFullFilePathWithName:fileName]];
}

- (void)setArchiveObjectWithFileName:(NSString *)fileName forObject:(id)object
{
    if (!fileName || !object) {
        return;
    }
    [NSKeyedArchiver archiveRootObject:object toFile:[self getFullFilePathWithName:fileName]];
}

- (void)removeArchiveObjectWithFileName:(NSString *)fileName
{
    [self removeFileWithName:fileName];
}
@end