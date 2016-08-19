//
//  JJDevice.m
//  HeheyuanDemo
//
//  Created by jiangjun on 14-4-22.
//  Copyright (c) 2014年 jiangjun. All rights reserved.
//

#import "JJDevice.h"

@implementation JJDevice
+(CGFloat)getOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+(CGFloat)getScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+(CGFloat)getScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+(UIColor *)colorWithR:(double)r G:(double)g B:(double)b A:(float)a
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

+(NSString *)weekdayFromDate:(NSDate *)date
{
//    NSArray *engArray = @[@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun"];
    NSArray *engArray_English = @[@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun"];
    NSArray *engArray_Chease = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
    
    NSArray *weekArray = @[@"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", @"星期日"];
    NSDateFormatter *form= [[NSDateFormatter alloc] init];
    [form setDateFormat:@"G yyyy/MM/dd(EEE) K:mm:ss"];
    NSString *string = [form stringFromDate:date];
    NSArray *array = [string componentsSeparatedByString:@" "];
    NSArray *arrayTemp = [[array objectAtIndex:1] componentsSeparatedByString:@"("];
    
    NSString *strRet = [[arrayTemp objectAtIndex:1] substringToIndex:3];
    NSLog(@"strRet = %@", strRet);
    strRet = [strRet stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    for (int i=0; i<7; i++) {
        if ( ([strRet isEqualToString:[engArray_English objectAtIndex:i]]) || ([strRet isEqualToString:[engArray_Chease objectAtIndex:i]]) ){
            NSString *stringRet = [[NSString alloc] initWithString:[weekArray objectAtIndex:i]];
            
            return stringRet;
        }
    }
    
    return strRet;
}


+(NSString *)shipType:(NSString *)string
{
    if ([string isEqualToString:@"[Y]"]) {
        return @"经济舱";
    }else if([string isEqualToString:@"[C]"]){
        return @"商务舱";
    }else if([string isEqualToString:@"[F]"]){
        return @"头等舱";
    }
    return @"";
}

+(NSString *)hotelOrderState:(NSString *)state
{
    NSString *stateText;
    if ([state isEqualToString:@"SUCCESSPAID"]) {
        stateText = @"已支付";
    }
    if ([state isEqualToString:@"UNPAID"]) {
        stateText = @"待支付";
    }
    if ([state isEqualToString:@"CANCELPAID"]) {
        stateText = @"已取消";
    }
    if ([state isEqualToString:@"FAILPAID"]) {
        stateText = @"支付失败";
    }
    if ([state isEqualToString:@"WAITSHENPI"]) {
        stateText = @" 等待审批";
    }
    
    if ([state isEqualToString:@"APPROVE"]) {
        stateText = @"审批通过";
    }
    
    if ([state isEqualToString:@"REFUSE"]) {
        stateText = @"审批拒绝";
    }
    if ([state isEqualToString:@"UPDATE"]) {
        stateText = @"修改(待支付)";
    }
    if ([state isEqualToString:@"PROCESSING"]) {
        stateText = @"退款处理中";
    }
    if ([state isEqualToString:@"FAILREFUND"]) {
        stateText = @"退款失败";
    }
    if ([state isEqualToString:@"ORDERFAIL"]) {
        stateText = @"下单失败";
    }
    
    if ([state isEqualToString:@"SUCCESSREFUND"]) {
        stateText = @"退款成功";
    }
    
    
    return stateText;
}

+(NSString *)orderState:(NSString *)state
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i=0; i<224; i++) {
        [array addObject:@""];
    }
    [array replaceObjectAtIndex:0 withObject:@"预订中"];
    //    1 待收款
    [array replaceObjectAtIndex:1 withObject:@"待收款"];
    //    2 已处理
    [array replaceObjectAtIndex:2 withObject:@"已处理"];
    //    3 记录已取消
    [array replaceObjectAtIndex:3 withObject:@"记录已取消"];
    //    33 逻辑删除
    [array replaceObjectAtIndex:33 withObject:@"逻辑删除"];
    //    5 已确认
    [array replaceObjectAtIndex:5 withObject:@"已确认"];
    //    6 已审批
    [array replaceObjectAtIndex:6 withObject:@"已审批"];
    //    60 已审批*
    [array replaceObjectAtIndex:60 withObject:@"已审批*"];
    //    4 审批中
    [array replaceObjectAtIndex:4 withObject:@"审批中"];
    //    14 审批拒绝X
    [array replaceObjectAtIndex:14 withObject:@"审批拒绝X"];
    //    7 导入
    [array replaceObjectAtIndex:7 withObject:@"导入"];
    //    71 出票提示邮件
    [array replaceObjectAtIndex:71 withObject:@"出票提示邮件"];
    //    72 旅客行程邮件
    [array replaceObjectAtIndex:72 withObject:@"旅客行程邮件"];
    //    88 已付款
    [array replaceObjectAtIndex:88 withObject:@"已付款"];
    //    8 已结算
    [array replaceObjectAtIndex:8 withObject:@"已结算"];
    //    9 已出票
    [array replaceObjectAtIndex:9 withObject:@"已出票"];
    //    20 已退票
    [array replaceObjectAtIndex:20 withObject:@"已退票"];
    //    24 已改期
    [array replaceObjectAtIndex:24 withObject:@"已改期"];
    //    21 改期申请
    [array replaceObjectAtIndex:21 withObject:@"改期申请"];
    //    22 退票申请
    [array replaceObjectAtIndex:22 withObject:@"退票申请"];
    //    23 航班延误申请
    [array replaceObjectAtIndex:23 withObject:@"航班延误申请"];
    //    221 退票已核算
    [array replaceObjectAtIndex:221 withObject:@"退票已核算"];
    //    222 改期已核算
    [array replaceObjectAtIndex:222 withObject:@"改期已核算"];
    //    223 航班延误
    [array replaceObjectAtIndex:223 withObject:@"航班延误"];
    //    44 发送邮件
    [array replaceObjectAtIndex:44 withObject:@"发送邮件"];
    //    90 已出票未审批
    [array replaceObjectAtIndex:90 withObject:@"已出票未审批"];
    //    91 已出票待结算
    [array replaceObjectAtIndex:91 withObject:@"已出票待结算"];
    //    92 OPEN
    [array replaceObjectAtIndex:92 withObject:@"OPEN"];
    return [array objectAtIndex:[state integerValue]];
}
@end
