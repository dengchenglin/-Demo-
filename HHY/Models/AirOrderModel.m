//
//  AirOrderModel.m
//  HHY
//
//  Created by jiangjun on 14-6-6.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "AirOrderModel.h"
#import "FlightListModel.h"

@implementation AirOrderModel
-(id)init
{
    if (self = [super init]) {
        _flightListArray = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)addOneFlight:(FlightListModel *)model
{
    if (![self.flightListArray containsObject:model]) {
        [self.flightListArray addObject:model];
    }
}

-(void)jiexiDict:(NSDictionary *)dict
{
    self.addTime = [dict objectForKey:@"addTime"];
    self.contactName = [dict objectForKey:@"contactName"];
    self.email = [dict objectForKey:@"email"];
    self.issuingDate = [dict objectForKey:@"issuingDate"];
    self.mobile = [dict objectForKey:@"mobile"];
    self.orderNumber = [dict objectForKey:@"orderNumber"];
    self.pnr = [dict objectForKey:@"pnr"];
    self.ticketState = [dict objectForKey:@"ticketState"];
    self.total = [dict objectForKey:@"total"];
    if ([[dict objectForKey:@"flightList"] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *tempDict in [dict objectForKey:@"flightList"]) {
            FlightListModel *model = [[FlightListModel alloc] initWithDictionary:tempDict error:nil];
            [self addOneFlight:model];
        }
    }
}
@end
