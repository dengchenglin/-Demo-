//
//  ADWUtil.h
//  AdwaysAppFrame
//
//  Created by song duan on 12-6-7.
//  Copyright (c) 2012年 adways. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADWUtil : NSObject

//获取星期几
+ (NSInteger)getWeekday;

// 将指定字符串做md5并返回md5字符串。
+ (NSString *)md5FromString:(NSString *)aString;

// 依据指定时间字符串返回对应的NSDate。
+ (NSDate *)getDateFromString:(NSString *)aTimeString;

// 依据指定的NSDate返回对应格式的NSString
+ (NSString *)getTimeStringFromDate:(NSDate *)aDate;

// 获得当前时间。
+ (NSString *)getNowDate;

// 判断是否安装了制定的app
+ (BOOL)whetherInstalled:(NSString *)urlScheme;

// 获得当前时间戳
+ (NSString *)getNowDateTimestamp;

/*
 function :将传入的数组按照指定的元素个数进行拆分，返回包含拆分后元素数组的数组
           例如：待传入数组array_1 含有10个元素。现在指定按照5个元素的单位来拆分，那么这个array_1就将被拆分为两个数组。
                返回值为数组array_2，在数组array_2中包含了两个数组array_3 , array_4。 
                array_3 和 array_4 中则分别存放原array_1数组中的前五个和后五个元素。
                如果原array_1中含有13个元素，那么返回的array_2中将包含3个子数组 array_3, array_4, array_5。
                array_3, array_4这两个数组中每个都含有5个元素，array_5中含有最后三个元素。
 */
+ (NSMutableArray *)splitArray:(NSArray *)aSourceArray perCount:(NSInteger)splitCount;

// 获取字符串在指定的字体情况下，所占用的size大小
+ (CGSize)sizeForString:(NSString *)string 
             stringFont:(UIFont *)aFont 
 maximumAcceptableWidth:(CGFloat)width
      maxlineBreakModel:(UILineBreakMode)aBreakModel;

//替换url地址中的uid
+ (NSString *)requestFormedURLStringWith:(NSString *)urlString userID:(NSString *)userID;

@end
