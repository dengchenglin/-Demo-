//
//  Utils.h
//  funMatch_iPad
//
//  Created by Dean on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface Utils : NSObject

#pragma mark save / restore map state

+ (NSString *)applicationDocumentsDirectory:(NSString *)filename;
+ (NSString *)applicationCachesDirectory:(NSString *)filename;

#pragma mark -
#pragma mark Bookmark load ans save

+ (void)saveData:(id)dataToSave to:(NSString *)filename;
+ (id)loadDataFrom:(NSString *)filename;
+ (void)deleteDataFile:(NSString *)filename;
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message;
+ (NSString *)md5:(NSString *)str;
+ (BOOL)versionGE:(NSString *)version;

+ (NSInteger)timeSpForDate:(NSDate *)date;
+ (NSString *)timeStrForSp:(NSInteger)sp;

+ (BOOL)validateUrl:(NSString *)candidate;

+ (double)distanceWithZuobiaox1:(double)zuobiaox1 zuobiaoy1:(double)zuobiaoy1 zuobiaox2:(double)zuobiaox2 zuobiaoy2:(double)zuobiaoy2;

+ (int)convertToInt:(NSString*)strtemp;

@end
