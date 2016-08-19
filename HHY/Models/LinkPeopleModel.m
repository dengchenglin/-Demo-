//
//  LinkPeopleModel.m
//  HHY
//
//  Created by jiangjun on 14-5-28.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "LinkPeopleModel.h"

@implementation LinkPeopleModel
-(NSDictionary *)getJason
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@(0) forKey:@"company"];	//公司id
    [dict setValue:@(0) forKey:@"dept"];	//部门id
    [dict setValue:@(0) forKey:@"secondDept"];	//二级部门id
    [dict setValue:self.name forKey:@"name"];	//姓名
    [dict setValue:self.mobile forKey:@"mobile"];	//手机
    [dict setValue:@"" forKey:@"phoneNo"];	//电话
    [dict setValue:self.email forKey:@"email"];	//Email
    [dict setValue:@"" forKey:@"payType"];	//支付方式
    [dict setValue:@"" forKey:@"otherNeed"];	//其他需求
    [dict setValue:@"" forKey:@"reason"];	//出差原因
    [dict setValue:@(11) forKey:@"profession"];	//同业
    [dict setValue:@(311) forKey:@"source"];	//来源细分id
    [dict setValue:@(10) forKey:@"orderNature"];	//订单性质
    return dict;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
