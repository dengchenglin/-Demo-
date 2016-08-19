//
//  HotelOrderParameter.m
//  HHY
//
//  Created by chenguangjiang on 14-11-10.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HotelOrderParameter.h"
static HotelOrderParameter *hotelOrderParameter=nil;
static dispatch_once_t onceToken;
@implementation HotelOrderParameter
-(id)init
{
    if(self = [super init])
    {
        self.orderDic = [[NSMutableDictionary alloc]init];
        self.serviceDic = [[NSMutableDictionary alloc]init];
        self.sevpriceDic = [[NSMutableDictionary alloc]init];
        self.intakerDic = [[NSMutableDictionary alloc]init];

    }
    return self;
}
+(HotelOrderParameter *)shareOrderParameter
{
    dispatch_once(&onceToken, ^{
        if(hotelOrderParameter == nil)
        {
            hotelOrderParameter = [[HotelOrderParameter alloc]init];
        }
    });
    return hotelOrderParameter;
}

//拼接services
-(void)refreshServiceDic
{
    NSMutableString *services = [NSMutableString string];
    for(NSString *service in [_serviceDic allValues])
    {
        [services appendString:service];
        [services appendString:@"*"];
    }
    if(services.length != 0)
    {
        [services deleteCharactersInRange:NSMakeRange(services.length - 1, 1)];
    }
    
 
    [self.orderDic setObject:services forKey:@"services"];
}



//拼接入住人
-(void)refreshIntakerDic
{

    NSMutableString *intakers = [NSMutableString string];
    for(NSString *intaker in [_intakerDic allValues])
    {
        [intakers appendString:intaker];
        [intakers appendString:@"*"];
    }
    if(intakers.length != 0)
    {
        [intakers deleteCharactersInRange:NSMakeRange(intakers.length - 1, 1)];
    }

    [self.orderDic setObject:intakers forKey:@"guestName"];
}

//计算总金额
-(void)refreshSerPriceDic
{

    CGFloat totalPrice = 0;
    for(NSNumber *price in [_sevpriceDic allValues])
    {
        totalPrice = totalPrice + [price floatValue];
    }
 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"countTotalAmount" object:[NSNumber numberWithFloat:totalPrice]];
}
@end
