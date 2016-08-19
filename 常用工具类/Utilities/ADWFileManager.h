//
//  ADWFileCache.h
//  AdwaysAppFrame
//
//  Created by song duan on 12-6-7.
//  Copyright (c) 2012年 adways. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kUserNameKey @"kUserNameKey"
#define kPasswordKey @"kPasswordKey"
#define kSessionKey  @"kSessionKey"

@interface ADWFileManager : NSObject

#pragma mark - 文件基本操作

// 设置是否评价
+ (void)setEvaluate:(BOOL)aEvaluate;

// 判断用户是否评价
+ (NSInteger)getEvaluate;

// 获得指定文件的绝对路径。
+ (NSString *)getPathWithDirectory:(NSSearchPathDirectory)aSearchPathDirectory filePath:(NSString *)aFilePath;

// 判断指定文件是否存在。
+ (BOOL)isFileExist:(NSString *)aFilePath;

// 判断指定文件是否过期，依据是指定的modifyTime参数。
+ (BOOL)isExpired:(NSString *)aFilePath modifyTime:(NSDate *)aModifyTime;

// 创建指定的目录。
+ (BOOL)createDirectory:(NSString *)aDirectoryPath lastComponentIsDirectory:(BOOL)isDirectory;

// 删除指定的文件。
+ (BOOL)removeFile:(NSString *)aFilePath;

// 做序列化对象保存到文件中时，将指定的对象转换成NSData。
+ (NSData *)archiverObject:(NSObject *)anObject forKey:(NSString *)aKey;

// 做反序列化指定数据成相应对象时，将指定的NSData转换成NSObject。
+ (NSObject *)unarchiverObject:(NSData *)anArchivedData withKey:(NSString *)aKey;

#pragma mark - 图片缓存相关

// 获得图片的缓存基本的通用绝对路径。
+ (NSString *)getImageCacheBasePath;

// 生成图片下载时的临时文件缓存绝对路径。
+ (NSString *)generateImageTemporaryFileDownloadPath:(NSString *)aFileName;

// 生成图片下载完成后缓存的绝对路径。
+ (NSString *)generateImageDownloadPath:(NSString *)aFileName;

// 依据特定的URL地址获得缓存图片。
+ (UIImage *)getCacheImageWithURL:(NSString *)aURL;

// 清楚缓存的图片数据
+ (void)removeCachedImages;

#pragma mark - 数据缓存相关

// 保存用户登录信息到本地
+ (void)saveUserLoginInfo:(NSString *)userName password:(NSString *)password sessionKey:(NSString *)sessionKey;

// 读取记录的当前登录用户的信息
+ (NSDictionary *)readCurrentUserLoginInfo;

// 删除保存的当前用户数据
+ (void)removeCachedCurrentUserInfo;

// 保存搜索关键字到历史记录
+ (void)saveSearchKey:(NSString *)searchKey;

// 读取记录中的搜索历史记录
+ (NSMutableArray *)readHistorySearchKey;

// 清除搜索历史记录
+ (void)clearHistorySearchKey;

@end
