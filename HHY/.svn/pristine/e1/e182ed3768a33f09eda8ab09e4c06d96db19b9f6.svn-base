//
//  Passenger.m
//  HHY
//
//  Created by jiangjun on 14-6-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "Passenger.h"

@implementation Passenger
-(NSDictionary *)getJson:(NSString *)capexFee andAllfuel:(NSString *)fuelFee andAirPrice:(NSString *)price
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.name forKey:@"name"];	//乘机人姓名
    [dict setValue:self.zjh forKey:@"idNo"];	//证件号
    if ([self.note isEqualToString:@"CHILD"]) {//乘机人类型
        [dict setValue:@"CHD" forKey:@"type"];//儿童
    }else{
        [dict setValue:@"CR" forKey:@"type"];	//成人
    }
    NSLog(@"%@", self.note);
    [dict setValue:self.mobile forKey:@"mobile"];	//手机号码
    [dict setValue:@([price intValue]) forKey:@"price"];	//票价
    [dict setValue:@([capexFee intValue]) forKey:@"capexFee"];	//机建费
    [dict setValue:@([fuelFee intValue]) forKey:@"fuelFee"];	//燃油费
    [dict setValue:@([self getbaoxianfei]) forKey:@"insureFee"];	//保险
    [dict setValue:@"" forKey:@"prefer"];	//旅行偏好
    [dict setValue:@"" forKey:@"mileageCard"];	//里程卡
    [dict setValue:self.birthday forKey:@"birthday"];	//出生日期
    [dict setValue:@"" forKey:@"costCenter"];	//成本中心
    [dict setValue:@"" forKey:@"empno"];	//员工号
    return dict;
}
-(void)setBaoxianfei:(NSInteger)num
{
    _baoxianfei = num;
}
-(NSInteger)getbaoxianfei
{
    return _baoxianfei;
}
@end
