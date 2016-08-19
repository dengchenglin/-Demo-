//
//  ADWUtil.m
//  AdwaysAppFrame
//
//  Created by song duan on 12-6-7.
//  Copyright (c) 2012年 adways. All rights reserved.
//

#import "ADWUtil.h"
#import <CommonCrypto/CommonHMAC.h>
#import "ADWFoundation.h"
#import <arpa/inet.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <sys/sysctl.h>
#import "ADWModel.h"
#import "ADWGlobalVariables.h"
@implementation ADWUtil

//获取星期几
+ (NSInteger)getWeekday
{
    NSDate*date = [NSDate date];
    
    NSCalendar*calendar = [NSCalendar currentCalendar];
    
    NSDateComponents*comps;
    
    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
            
                       fromDate:date];
    
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

// 将指定字符串做md5并返回md5字符串。
+ (NSString *)md5FromString:(NSString *)aString
{
    if([aString length] == 0){
        return nil;
    }
    
    const char *value = [aString UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    NSMutableString *md5String = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [md5String appendFormat:@"%02x",outputBuffer[count]];
    }
    return [md5String autorelease];
}

// 依据指定时间字符串返回对应的NSDate。
+ (NSDate *)getDateFromString:(NSString *)aTimeString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:aTimeString];
    [formatter release];
    return date;
}

// 依据指定的NSDate返回对应格式的NSString
+ (NSString *)getTimeStringFromDate:(NSDate *)aDate
{
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *setNowDate = [formatter stringFromDate:aDate];
	return setNowDate;
}

// 获得当前时间。
+ (NSString *)getNowDate
{
    NSDate *now = [NSDate date];
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CCT"]];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *setNowDate = [formatter stringFromDate:now];
	return setNowDate;
    
    
}


// 获得当前时间戳
+ (NSString *)getNowDateTimestamp
{
    NSDate *date = [ADWUtil getDateFromString:[ADWUtil getNowDate]];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSNumber *timeIntervalNumber = [NSNumber numberWithDouble:timeInterval];
    return [timeIntervalNumber stringValue];

}

+ (BOOL)whetherInstalled:(NSString *)urlScheme
{
    if ([urlScheme length] == 0) {
        return NO;
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@://", urlScheme]];
    return [[UIApplication sharedApplication] canOpenURL:url];
}

/*
 function :将传入的数组按照指定的元素个数进行拆分，返回包含拆分后元素数组的数组
 例如：待传入数组array_1 含有10个元素。现在指定按照5个元素的单位来拆分，那么这个array_1就将被拆分为两个数组。
 返回值为数组array_2，在数组array_2中包含了两个数组array_3 , array_4。 
 array_3 和 array_4 中则分别存放原array_1数组中的前五个和后五个元素。
 如果原array_1中含有13个元素，那么返回的array_2中将包含3个子数组 array_3, array_4, array_5。
 array_3, array_4这两个数组中每个都含有5个元素，array_5中含有最后三个元素。
 */
+ (NSMutableArray *)splitArray:(NSArray *)aSourceArray perCount:(NSInteger)splitCount
{
    NSMutableArray *resultArray = nil;
    if (aSourceArray != nil && [aSourceArray count] > 0 && splitCount >= 0) {
        if (splitCount >= [aSourceArray count] || splitCount == 0) {
            resultArray = [[[NSMutableArray alloc] initWithArray:aSourceArray] autorelease];
        }else if (splitCount > 0 && splitCount < [aSourceArray count]) {
            NSInteger arrayIndex = 0;
            NSMutableArray *mutableArrayOne = [[NSMutableArray alloc] init];
            for (int i = 0; i < [aSourceArray count]; i ++) {
                id object = [aSourceArray objectAtIndex:i];
                if (i % splitCount == 0) {
                    NSMutableArray *tempOneArray = [[NSMutableArray alloc] init];
                    [tempOneArray addObject:object];
                    [mutableArrayOne addObject:tempOneArray];
                    [tempOneArray release];
                    arrayIndex = [mutableArrayOne count] - 1;
                }else {
                    if (arrayIndex < [mutableArrayOne count]) {
                        NSMutableArray *tempOneArray = (NSMutableArray *)[mutableArrayOne objectAtIndex:arrayIndex];
                        [tempOneArray addObject:object];
                    }
                }
            }
            resultArray = [[[NSMutableArray alloc] initWithArray:mutableArrayOne] autorelease];
            [mutableArrayOne release];
        }
    }
    return resultArray;
}

+ (CGSize)sizeForString:(NSString *)string 
             stringFont:(UIFont *)aFont 
 maximumAcceptableWidth:(CGFloat)width
      maxlineBreakModel:(UILineBreakMode)aBreakModel
{
	CGSize textSize = [string sizeWithFont:aFont 
                         constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) 
                             lineBreakMode:aBreakModel];
	return textSize;
}

//构造已经生成后的URL地址
+ (NSString *)requestFormedURLStringWith:(NSString *)urlString userID:(NSString *)userID
{

    NSString *newURLString = urlString;
    if(userID == nil || userID.length == 0)
    {
         NSRange range = [urlString rangeOfString:@"@uid@"];
        
        NSString *newString = @"";
        if (range.location != NSNotFound){
        newString = [urlString stringByReplacingCharactersInRange:range withString:@"410787"];
        return [NSString stringWithFormat:@"%@",newString];
        }
        else {
            return urlString;
        }
        
    }
    else{
        NSRange range = [urlString rangeOfString:@"@uid@"];

        if (range.location != NSNotFound) {
       
            newURLString = [urlString stringByReplacingCharactersInRange:range withString:userID];
        }
        else{
            newURLString = urlString;
        }
   
    }
    return [NSString stringWithFormat:@"%@/app_redirect?uid=%@&session_key=%@&url=%@",kApp_RedirectURL,[ADWGlobalVariables shareGlobalVariables].userid,[ADWGlobalVariables shareGlobalVariables].sessionKey,EnCodingNSString(newURLString)];

}

#pragma mark - Memory management methods

- (void)dealloc
{
    [super dealloc];
}

@end
