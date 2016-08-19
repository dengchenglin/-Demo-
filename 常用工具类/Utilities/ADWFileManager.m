//
//  ADWFileCache.m
//  AdwaysAppFrame
//
//  Created by song duan on 12-6-7.
//  Copyright (c) 2012年 adways. All rights reserved.
//

#import "ADWFileManager.h"
#import "ADWUtil.h"
#import "ADWFoundation.h"

@implementation ADWFileManager

#pragma mark - 文件基本操作

// 设置是否评价

+ (void)setEvaluate:(BOOL)aEvaluate;
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:aEvaluate forKey:@"isEvaluate"];
    [user synchronize];
}

// 判断用户是否评价
+ (NSInteger)getEvaluate
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user boolForKey:@"isEvaluate"];
}

// 获得指定文件的绝对路径。
+ (NSString *)getPathWithDirectory:(NSSearchPathDirectory)aSearchPathDirectory filePath:(NSString *)aFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(aSearchPathDirectory, NSUserDomainMask, YES);
    NSString *directory = [paths objectAtIndex:0];
    NSString *path = [directory stringByAppendingPathComponent:aFilePath];
    
	NSFileManager* fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:path]) {
        NSError **error = NULL;
		BOOL result = [fileManager createDirectoryAtPath:path
                             withIntermediateDirectories:YES
                                              attributes:nil
                                                   error:error];
        if (!result) {
            ADWLog(@"\n{\nCreate directory failed:%@\n}\n", path);
        }
	}
    return path;
}

// 判断指定文件是否存在。
+ (BOOL)isFileExist:(NSString *)aFilePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:aFilePath]) {
        return YES;
    }
    return NO;
}

// 判断指定文件是否过期，依据是指定的modifyTime参数。
+ (BOOL)isExpired:(NSString *)aFilePath modifyTime:(NSDate *)aModifyTime
{
    NSDictionary *fileAttribs = [[NSFileManager defaultManager] attributesOfItemAtPath:aFilePath error:nil];
    NSDate *cacheFilesModifyTime = [fileAttribs valueForKey:NSFileModificationDate];
    NSTimeInterval cacheFilesModifyTimeInterval = [cacheFilesModifyTime timeIntervalSince1970];
    NSTimeInterval modifyTimeInterval = [aModifyTime timeIntervalSince1970];
    if (cacheFilesModifyTimeInterval != modifyTimeInterval) {
        return YES;
    }
    return NO;
}

// 创建指定的目录。
+ (BOOL)createDirectory:(NSString *)aDirectoryPath lastComponentIsDirectory:(BOOL)isDirectory
{
    NSString *path = nil;
    if (isDirectory) {
        path = aDirectoryPath;
    }else {
        path = [aDirectoryPath stringByDeletingLastPathComponent];
    }
    if ([path length] > 0 && [[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
        BOOL result = NO;
        NSError **error = NULL;
        result = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                           withIntermediateDirectories:YES
                                                            attributes:nil
                                                                 error:error];
        if (result == NO && error) {
            return NO;
        }
    }
    return YES;
}

// 删除指定的文件。
+ (BOOL)removeFile:(NSString *)aFilePath
{
    if([[NSFileManager defaultManager] fileExistsAtPath:aFilePath]) {
        NSError *error = nil;
		[[NSFileManager defaultManager] removeItemAtPath:aFilePath error:&error];
		if(error) {
			return NO;
		}
	}
	return YES;
}

// 做序列化对象保存到文件中时，将指定的对象转换成NSData。
+ (NSData *)archiverObject:(NSObject *)anObject forKey:(NSString *)aKey
{
    if (anObject == nil || aKey == nil) {
        return nil;
    }
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:anObject forKey:aKey];
	[archiver finishEncoding];
	[archiver release];
	return [data autorelease];
}

// 做反序列化指定数据成相应对象时，将指定的NSData转换成NSObject。
+ (NSObject *)unarchiverObject:(NSData *)anArchivedData withKey:(NSString *)aKey
{
    if (anArchivedData == nil || aKey == nil) {
        return nil;
    }
	
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:anArchivedData];
	NSObject *object = [unarchiver decodeObjectForKey:aKey];
	[unarchiver finishDecoding];
	[unarchiver release];
	return object;
}

#pragma mark - 图片缓存相关

// 获得图片的缓存基本的通用绝对路径。
+ (NSString *)getImageCacheBasePath {
    return [ADWFileManager getPathWithDirectory:NSCachesDirectory filePath:@"Adways/ImageCache"];
}

// 生成图片下载时的临时文件缓存绝对路径。
+ (NSString *)generateImageTemporaryFileDownloadPath:(NSString *)aFileName {
    if ([aFileName length] == 0) {
        return nil;
    }
    NSString *md5String = [ADWUtil md5FromString:aFileName];
    return [[[self getImageCacheBasePath] stringByAppendingPathComponent:md5String]
            stringByAppendingPathExtension:@"temp"];
}

// 生成图片下载完成后缓存的绝对路径。
+ (NSString *)generateImageDownloadPath:(NSString *)aFileName {
    NSString *md5String = [ADWUtil md5FromString:aFileName];
    return [[[self getImageCacheBasePath] stringByAppendingPathComponent:md5String]
            stringByAppendingPathExtension:@"jpg"];
    
}

// 依据特定的URL地址获得缓存图片。
+(UIImage *)getCacheImageWithURL:(NSString *)aURL {
    if ([aURL length] == 0) {
        return nil;
    }
    NSString *cacheImagePath = [self generateImageDownloadPath:aURL];
    if ([ADWFileManager isFileExist:cacheImagePath]) {
        return [UIImage imageWithContentsOfFile:cacheImagePath];
    }
    return nil;
}


// 清楚缓存的图片数据
+ (void)removeCachedImages
{
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[ADWFileManager getImageCacheBasePath]
                                                                         error:nil];
    for (NSString *file in files) {
        [ADWFileManager removeFile:[[ADWFileManager getImageCacheBasePath] stringByAppendingPathComponent:file]];
    }
    
    NSNotification *notification = [NSNotification notificationWithName:kClearCacheImagesNotification object:nil];
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification
                                               postingStyle:NSPostWhenIdle
                                               coalesceMask:NSNotificationCoalescingOnName
                                                   forModes:nil];
    

}

#pragma mark - 数据缓存相关

// 保存用户登录信息到本地
+ (void)saveUserLoginInfo:(NSString *)userName password:(NSString *)password sessionKey:(NSString *)sessionKey
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:3];
    if ([userName length]) {
        [dictionary setValue:userName forKey:kUserNameKey];
    }
    if ([password length]) {
        [dictionary setValue:password forKey:kPasswordKey];
    }
    if ([sessionKey length]) {
        [dictionary setValue:sessionKey forKey:kSessionKey];
    }
    NSData *loginedUsersData = [ADWFileManager archiverObject:dictionary forKey:@"loginedUsers"];
    [dictionary release];
    NSString *basePath = [ADWFileManager getPathWithDirectory:NSDocumentDirectory filePath:@"Adways/DataCache"];
    NSString *path = [[basePath stringByAppendingPathComponent:@"loginedUsers"] stringByAppendingPathExtension:@"dat"];
    [loginedUsersData writeToFile:path atomically:YES];
}

// 读取记录的当前登录用户的信息
+ (NSDictionary *)readCurrentUserLoginInfo
{
    NSString *basePath = [ADWFileManager getPathWithDirectory:NSDocumentDirectory filePath:@"Adways/DataCache"];
    NSString *path = [[basePath stringByAppendingPathComponent:@"loginedUsers"] stringByAppendingPathExtension:@"dat"];
    if ([ADWFileManager isFileExist:path]) {
        NSData *loginedUsersData = [[NSData alloc] initWithContentsOfFile:path];
        NSDictionary *dictionary
        = (NSDictionary *)[ADWFileManager unarchiverObject:loginedUsersData withKey:@"loginedUsers"];
        [loginedUsersData release];
        return dictionary;
    }
    return nil;
}

// 删除保存的当前用户数据
+ (void)removeCachedCurrentUserInfo
{
    NSString *basePath = [ADWFileManager getPathWithDirectory:NSDocumentDirectory filePath:@"Adways/DataCache"];
    NSString *path = [[basePath stringByAppendingPathComponent:@"loginedUsers"] stringByAppendingPathExtension:@"dat"];
    [ADWFileManager removeFile:path];
}

// 保存搜索关键字到历史记录
+ (void)saveSearchKey:(NSString *)searchKey
{
    NSMutableArray *searchKeys = [[NSMutableArray alloc] init];
    [searchKeys addObject:searchKey];
    NSMutableArray *historySearchKeys = [ADWFileManager readHistorySearchKey];
    if ([historySearchKeys count] > 0) {
        if (![historySearchKeys containsObject:searchKey]) {
            [searchKeys addObjectsFromArray:historySearchKeys];
        }
    }
    NSString *basePath = [ADWFileManager getPathWithDirectory:NSDocumentDirectory filePath:@"Adways/DataCache"];
    NSString *path = [[basePath stringByAppendingPathComponent:@"searchKeys"] stringByAppendingPathExtension:@"dat"];
    [searchKeys writeToFile:path atomically:YES];
    [searchKeys release];
}

// 读取记录中的搜索历史记录
+ (NSMutableArray *)readHistorySearchKey
{
    NSString *basePath = [ADWFileManager getPathWithDirectory:NSDocumentDirectory filePath:@"Adways/DataCache"];
    NSString *path = [[basePath stringByAppendingPathComponent:@"searchKeys"] stringByAppendingPathExtension:@"dat"];
    NSMutableArray *historySearchKeys = [NSMutableArray arrayWithContentsOfFile:path];
    return historySearchKeys;
}

// 清除搜索历史记录
+ (void)clearHistorySearchKey
{
    NSString *basePath = [ADWFileManager getPathWithDirectory:NSDocumentDirectory filePath:@"Adways/DataCache"];
    NSString *path = [[basePath stringByAppendingPathComponent:@"searchKeys"] stringByAppendingPathExtension:@"dat"];
    [ADWFileManager removeFile:path];
}

#pragma mark - Memory management methods

- (void)dealloc
{
    [super dealloc];
}

@end
