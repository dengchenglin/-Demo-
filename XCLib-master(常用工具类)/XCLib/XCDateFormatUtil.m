

#import "XCDateFormatUtil.h"

@implementation XCDateFormatUtil
static NSDateFormatter *formatter = nil;

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        NSTimeZone * zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:zone];
    });
}

+ (NSString *)dateFormatToStringWithFormatStyle:(NSString *)style date:(NSDate *)date
{
    [formatter setDateFormat:style];
    return [formatter stringFromDate:date];
}

+ (NSDate *)stringFormatToDateWithFormatStyle:(NSString *)style string:(NSString *)dateString
{
    [formatter setDateFormat:style];
    return [formatter dateFromString:dateString];
}

+ (NSString *)dateFullStringWithInterval:(double)interval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [self dateFormatToStringWithFormatStyle:@"yyyy-MM-dd HH:mm:ss" date:date];
}

+ (NSString *)dateFullStringWithInterval:(double)interval formatStyle:(NSString *)style
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [self dateFormatToStringWithFormatStyle:style date:date];
}

+ (NSTimeInterval)timeIntervalWithDateString:(NSString *)dateString
{
    return [[self stringFormatToDateWithFormatStyle:@"yyyy-MM-dd HH:mm:ss" string:dateString] timeIntervalSince1970];
}

+ (NSString *)earliestDateStringWithDate:(NSDate *)date
{
    return [self dateFormatToStringWithFormatStyle:@"yyyy-MM-dd 00:00:00" date:date];
}

+ (NSString *)latestDateStringWithDate:(NSDate *)date
{
    return [self dateFormatToStringWithFormatStyle:@"yyyy-MM-dd 23:59:59" date:date];
}
+ (NSString *)shortDateString:(NSDate *)date
{
    return [self dateFormatToStringWithFormatStyle:@"yyyy-MM-dd" date:date];
}
@end
