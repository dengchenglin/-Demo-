

#import <Foundation/Foundation.h>

typedef enum {
    IOManagerSavePathTypeDocument, //沙盒
    IOManagerSavePathTypeCache, //缓存
    IOManagerSavePathTypeTemp //临时
}IOManagerSavePathType;

@interface XCIOManager : NSObject
/**
 *  保存根路径
 */
@property (nonatomic, copy, readonly) NSString *saveRootPath;
/**
 *  保存路径类型
 */
@property (nonatomic, assign) IOManagerSavePathType pathType;

/**
 *  根据类型获取根路径
 *
 *  @param pathType 根路径类型
 *
 *  @return 根路径
 */
+ (NSString *)getRootPath:(IOManagerSavePathType)pathType;
/**
 *  初始化默认实例。使用IOManagerSavePathTypeDocument初始化
 *
 *  @return 默认实例
 */
+ (instancetype)defaultManager;
/**
 *  使用指定类型初始化
 *
 *  @param pathType 类型
 *
 *  @return 初始化实例
 */
- (instancetype)initWithPathType:(IOManagerSavePathType)pathType;
/**
 *  创建目录
 *
 *  @param dirName 目录名称
 *
 *  @return 操作结果
 */
- (BOOL)createDirectoryWithName:(NSString *)dirName;
/**
 *  写入文件到磁盘
 *
 *  @param fileName 文件名称
 *  @param fileData 写入的数据
 *
 *  @return 操作结果
 */
- (BOOL)writeToFile:(NSString *)fileName data:(NSData *)fileData;
/**
 *  从文件读入数据
 *
 *  @param fileName 文件名称
 *
 *  @return 读入的数据
 */
- (NSData *)readFromFile:(NSString *)fileName;
/**
 *  删除目录
 *
 *  @param dirName 目录名称
 */
- (void)removeDirectoryWithName:(NSString *)dirName;
/**
 *  删除文件
 *
 *  @param fileName 文件名称
 */
- (void)removeFileWithName:(NSString *)fileName;
@end

@interface XCIOManager (NSUserDefaultsManager)
/**
 *  获取NSUserDefaults的值
 *
 *  @param key key
 *
 *  @return value
 */
- (id)getNSUserDefaultsValueWithKey:(NSString *)key;
/**
 *  写入值到NSUserDefaults
 *
 *  @param key   key
 *  @param value value
 */
- (void)setNSUserDefaultsValueWithKey:(NSString *)key forValue:(id)value;
/**
 *  删除NSUserDefaults的值
 *
 *  @param key key
 */
- (void)removeNSUserDefaultsValueWithKey:(NSString *)key;
@end

@interface XCIOManager (ArchiveObjectManager)
/**
 *  获取解档的对象
 *
 *  @param fileName 文件名称
 *
 *  @return 解档的对象
 */
- (id)getArchiveObjectWithFileName:(NSString *)fileName;
/**
 *  归档对象
 *
 *  @param fileName 保存的文件名称
 *  @param object   归档对象
 */
- (void)setArchiveObjectWithFileName:(NSString *)fileName forObject:(id)object;
/**
 *  删除归档对象
 *
 *  @param fileName 文件名称
 */
- (void)removeArchiveObjectWithFileName:(NSString *)fileName;
@end