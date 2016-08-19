//
//  CJRModel.m
//  HHY
//
//  Created by jiangjun on 14-5-12.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "CJRModel.h"

@implementation CJRModel
-(void)anasyDict:(NSDictionary *)dict
{
    self.birthday = [dict objectForKey:@"birthday"];
    self.email = [dict objectForKey:@"email"];
    self.uid = [NSString stringWithFormat:@"%d",[[dict objectForKey:@"id"] intValue]];
    self.mobile = [dict objectForKey:@"mobile"];
    self.name = [dict objectForKey:@"name"];
    self.note = [dict objectForKey:@"note"];
    self.sex = [dict objectForKey:@"sex"];
    self.userId = [dict objectForKey:@"userId"];
    self.zjh = [dict objectForKey:@"zjh"];
    self.zjlx = [dict objectForKey:@"zjlx"];
}
-(NSDictionary *)getJson:(NSString *)capexFee andAllfuel:(NSString *)fuelFee andBaoxian:(NSString *)baoxianString andAirPrice:(NSString *)price
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.name forKey:@"name"];	//乘机人姓名
    [dict setValue:self.zjh forKey:@"idNo"];	//证件号
    [dict setValue:self.note forKey:@"type"];	//乘机人类型
    [dict setValue:self.mobile forKey:@"mobile"];	//手机号码
    [dict setValue:price forKey:@"price"];	//票价
    [dict setValue:capexFee forKey:@"capexFee"];	//机建费
    [dict setValue:fuelFee forKey:@"fuelFee"];	//燃油费
    [dict setValue:baoxianString forKey:@"insureFee"];	//保险
    [dict setValue:@"" forKey:@"prefer"];	//旅行偏好
    [dict setValue:@"" forKey:@"mileageCard"];	//里程卡
    [dict setValue:self.birthday forKey:@"birthday"];	//出生日期
    [dict setValue:@"" forKey:@"costCenter"];	//成本中心
    [dict setValue:@"" forKey:@"empno"];	//员工号
    return dict;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
