
#import <Foundation/Foundation.h>

@interface XCObjectCacheManager : NSObject

+ (instancetype)sharedCacheManager;
/**
 *  查询缓存的内容（异步）
 *
 *  @param name       缓存key
 *  @param completion 完成后回调
 */
- (void)queryCacheForKey:(NSString *)name completion:(void(^)(id cacheObject))completion;
/**
 *  同步查询缓存的内容
 *
 *  @param name 缓存key
 *
 *  @return 缓存内容
 */
- (id)syncQueryCacheForKey:(NSString *)name;
/**
 *  保存缓存内容(默认缓存过期时间7天)
 *
 *  @param name 缓存key
 *  @param data 缓存内容
 */
- (void)saveForKey:(NSString *)name object:(id<NSCoding>)data;
/**
 *  保存缓存内容
 *
 *  @param name 缓存key
 *  @param data 缓存内容
 *  @param expired 缓存时间
 */
- (void)saveForKey:(NSString *)name object:(id<NSCoding>)data expired:(NSTimeInterval)expired;
/**
 *  删除缓存
 *
 *  @param name       缓存key
 *  @param completion 完成后回调
 */
- (void)removeCacheForKey:(NSString *)name completion:(dispatch_block_t)completion;
/**
 *  获取本地缓存大小
 *
 *  @return 缓存大小（字节）
 */
- (unsigned long long)getAllCacheSize;
/**
 *  清除本地缓存
 *
 *  @param completion 完成后回调
 */
- (void)clearAllCacheWithCompletionHandler:(dispatch_block_t)completion;
@end
