//
//  LoginModel.m
//  HHY
//
//  Created by jiangjun on 14-5-28.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "LoginModel.h"
#import "DayModel.h"

@implementation LoginModel
static bool isWangfan;
static bool isSelect;
static bool isInterNational;
static bool isOrderTicket;
static NSMutableArray *rangeArray;
static NSString *wangfanURL;
static NSString *dateString;
static NSString *start_endPoint;
static NSString *shippingspaceType;
static DayModel *dateModel;
static DayModel *startDateModel;
+(id)shareInstace
{
    static LoginModel *model = nil;
    if (!model) {
        model = [[LoginModel alloc] init];
        rangeArray = [[NSMutableArray alloc] init];
        isSelect = NO;
    }
    return model;
}
-(void)setWangfan:(BOOL)value
{
    isWangfan = value;
}
-(void)setInterNational:(BOOL)value
{
    isInterNational = value;
}
-(void)setWangfanURL:(NSString *)string
{
    wangfanURL = [string copy];
}
-(NSString *)getWangfanURL
{
    return wangfanURL;
}
-(BOOL)getIsWangfan
{
    return isWangfan;
}
-(BOOL)getIsInterNational
{
    return isInterNational;
}
-(void)addOneRange:(id)obj
{
    if (![rangeArray containsObject:obj]) {
        [rangeArray addObject:obj];
    }
}
-(NSMutableArray *)getRangeArray
{
    return rangeArray;
}

-(void)removeAllRange
{
    [rangeArray removeAllObjects];
}

-(void)setIsSelectTicket:(BOOL)value
{
    isSelect = value;
}
-(BOOL)getISSelectTicket
{
    return isSelect;
}
-(void)setDateString:(NSString *)string
{
    dateString = [string copy];
}
-(NSString *)getDateString
{
    return dateString;
}
-(void)setStartEndPoint:(NSString *)string
{
    start_endPoint = [string copy];
}
-(NSString *)getStartEndPoint
{
    return start_endPoint;
}
-(void)setDateModel:(id)obj;
{
    dateModel = obj;
}
-(id)getDateModel
{
    return dateModel;
}
-(void)setShippingspaceType:(NSString *)string
{
    shippingspaceType = [string copy];
}
-(NSString *)getshippingspaceType
{
    return shippingspaceType;
}
-(void)setStartDateModel:(id)obj
{
    startDateModel = obj;
}
-(id)getStartDateModel
{
    return startDateModel;
}
-(void)setOrderTicketState:(BOOL)value
{
    isOrderTicket = value;
}
-(BOOL)getOrderTicketState
{
    return isOrderTicket;
}
@end
