//
//  ApplyAirOrderModel.m
//  HHY
//
//  Created by 兵 张 on 14/11/22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "ApplyAirOrderModel.h"

@implementation ApplyAirOrderModel
@synthesize orderNumber = _orderNumber;
@synthesize addTime = _addTime;
@synthesize monile = _monile;
@synthesize contactName = _contactName;
@synthesize totleFee = _totleFee;
@synthesize ticketState = _ticketState;
@synthesize username = _username;

- (void)jieXi:(NSDictionary *)dic
{
    _orderNumber = [dic objectForKey:@"orderNumber"];
    _addTime = [dic objectForKey:@"addTime"];
    _monile = [dic objectForKey:@"mobile"];
    _contactName = [dic objectForKey:@"contactName"];
    _totleFee = [dic objectForKey:@"totalFee"];
    _ticketState = [dic objectForKey:@"ticketState"];
    _username = [dic objectForKey:@"username"];
}

@end
