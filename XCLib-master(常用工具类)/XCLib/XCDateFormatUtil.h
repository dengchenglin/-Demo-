
#import <Foundation/Foundation.h>

@interface XCDateFormatUtil : NSObject
/**
 *  时间转换到字符串
 *
 *  @param style 格式化样式
 *  @param date  格式化的时间
 *
 *  @return 格式化后的时间字符串
 */
+ (NSString *)dateFormatToStringWithFormatStyle:(NSString *)style date:(NSDate *)date;
/**
 *  字符串转换到时间
 *
 *  @param style      格式化样式
 *  @param dateString 字符串时间
 *
 *  @return 时间对象
 */
+ (NSDate *)stringFormatToDateWithFormatStyle:(NSString *)style string:(NSString *)dateString;
/**
 *  时间戳转时间字符串（yyyy-MM-dd HH:mm:ss）
 *
 *  @param interval 时间戳
 *
 *  @return 时间字符串
 */
+ (NSString *)dateFullStringWithInterval:(double)interval;
/**
 *  时间戳转时间字符串
 *
 *  @param interval 时间戳
 *  @param style    格式化的格式
 *
 *  @return 时间字符串
 */
+ (NSString *)dateFullStringWithInterval:(double)interval formatStyle:(NSString *)style;
/**
 *  时间字符串(yyyy-MM-dd HH:mm:ss)转时间戳
 *
 *  @param dateString 时间字符串
 *
 *  @return 时间戳
 */
+ (NSTimeInterval)timeIntervalWithDateString:(NSString *)dateString;
/**
 *  时间对象转成成最早的时间字符串（yyyy-MM-dd 00:00:00）
 *
 *  @param date 时间对象
 *
 *  @return 时间字符串
 */
+ (NSString *)earliestDateStringWithDate:(NSDate *)date;
/**
 *  时间对象转成成最晚的时间字符串（yyyy-MM-dd 23:59:59）
 *
 *  @param date 时间对象
 *
 *  @return 时间字符串
 */
+ (NSString *)latestDateStringWithDate:(NSDate *)date;
/**
 *  时间对象转换成日期字符串
 *
 *  @param date 时间对象
 *
 *  @return 日期字符串
 */
+ (NSString *)shortDateString:(NSDate *)date;
@end
