//
//  Utils.m
//  funMatch_iPad
//
//  Created by Dean on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"
#import "NSDate-Utilities.h"

@implementation Utils

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
													 message:message
													delegate:nil
										   cancelButtonTitle:@"好"
										   otherButtonTitles:nil];
	[alert show];
}

+ (NSString *)applicationDocumentsDirectory:(NSString *)filename
{
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
														 NSUserDomainMask,
														 YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	NSString *appendPath = filename;
    return [basePath stringByAppendingPathComponent:appendPath];
}

+ (NSString *)applicationCachesDirectory:(NSString *)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
														 NSUserDomainMask,
														 YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return [basePath stringByAppendingPathComponent:filename];
}

#pragma mark -
#pragma mark Bookmark load ans save

+ (id)loadDataFrom:(NSString *)filename
{
	NSString *filePath = [Utils applicationDocumentsDirectory:filename];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		NSData *data = [[NSMutableData alloc]
						initWithContentsOfFile:filePath];
		NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
										 initForReadingWithData:data];
		id result = [unarchiver decodeObjectForKey:@"data"];
		[unarchiver finishDecoding];
		return result;
	} else {
		return nil;
	}
}

+ (void)saveData:(id)dataToSave to:(NSString *)filename
{
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]
								 initForWritingWithMutableData:data];
	[archiver encodeObject:dataToSave forKey:@"data"];
	[archiver finishEncoding];
	NSString *filePath = [Utils applicationDocumentsDirectory:filename];
    
	[data writeToFile:filePath atomically:YES];
}


+ (void)deleteDataFile:(NSString *)filename
{
    NSString *filePath = [Utils applicationDocumentsDirectory:filename];
	//NSLog(@"save filePath: %@", filePath);
    BOOL success = [[NSFileManager defaultManager]removeItemAtPath:filePath error:nil];
    if (!success) {
        [self saveData:nil to:filename];
    }
    
}

+ (NSString *)md5:(NSString *)str
{
	const char *cStr = [str UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}

+ (BOOL)versionGE:(NSString *)version
{
    //    return NO;
	NSString *deviceVersion = [UIDevice currentDevice].systemVersion;
	return [deviceVersion compare:version] >= NSOrderedSame;
}

+ (NSInteger)timeSpForDate:(NSDate *)date
{
    return (long)[date timeIntervalSince1970];
}

+ (NSString *)timeStrForSp:(NSInteger)sp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:sp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if ([date isToday]) {
        [formatter setDateFormat:@"HH:mm"];
        return [formatter stringFromDate:date];
    } else {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [formatter stringFromDate:date];
    }
    
}

+ (BOOL)validateUrl:(NSString *)candidate
{
    NSString *urlRegEx = @"http+:[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

//double LantitudeLongitudeDist(double lon1,double lat1,
//							  double lon2,double lat2)

+ (double)distanceWithZuobiaox1:(double)zuobiaox1 zuobiaoy1:(double)zuobiaoy1 zuobiaox2:(double)zuobiaox2 zuobiaoy2:(double)zuobiaoy2
{
    double er = 6378137; // 6378700.0f;
	//ave. radius = 6371.315 (someone said more accurate is 6366.707)
	//equatorial radius = 6378.388
	//nautical mile = 1.15078
	double radlat1 = M_PI*zuobiaox1/180.0f;
	double radlat2 = M_PI*zuobiaox2/180.0f;
    
	//now long.
	double radlong1 = M_PI*zuobiaoy1/180.0f;
	double radlong2 = M_PI*zuobiaoy2/180.0f;
    
	if( radlat1 < 0 ) radlat1 = M_PI/2 + fabs(radlat1);// south
	if( radlat1 > 0 ) radlat1 = M_PI/2 - fabs(radlat1);// north
	if( radlong1 < 0 ) radlong1 = M_PI*2 - fabs(radlong1);//west
    
	if( radlat2 < 0 ) radlat2 = M_PI/2 + fabs(radlat2);// south
	if( radlat2 > 0 ) radlat2 = M_PI/2 - fabs(radlat2);// north
	if( radlong2 < 0 ) radlong2 = M_PI*2 - fabs(radlong2);// west
    
	//spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
	//zero ag is up so reverse lat
	double x1 = er * cos(radlong1) * sin(radlat1);
	double y1 = er * sin(radlong1) * sin(radlat1);
	double z1 = er * cos(radlat1);
    
	double x2 = er * cos(radlong2) * sin(radlat2);
	double y2 = er * sin(radlong2) * sin(radlat2);
	double z2 = er * cos(radlat2);
    
	double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    
	//side, side, side, law of cosines and arccos
	double theta = acos((er*er+er*er-d*d)/(2*er*er));
	double dist  = theta*er;
    
	return dist;
}

+ (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

@end
