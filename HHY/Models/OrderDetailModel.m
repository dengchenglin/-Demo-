//
//  OrderDetailModel.m
//  HHY
//
//  Created by jiangjun on 14-6-8.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel
-(id)init
{
    if (self = [super init]) {
        _flightArray = [[NSMutableArray alloc] init];
        _passengerArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addOneFlight:(FlightsDetailModel *)model
{
    if (![self.flightArray containsObject:model]) {
        [self.flightArray addObject:model];
    }
}

-(void)addOnePassenger:(PassengerDetailModel *)model
{
    if (![self.passengerArray containsObject:model]) {
        [self.passengerArray addObject:model];
    }
}

-(void)jiexiFromDict:(NSDictionary *)dict
{
    self.addTime = [dict objectForKey:@"addTime"];
    self.advanceBooking = [dict objectForKey:@"advanceBooking"];
    self.contactName = [dict objectForKey:@"contactName"];
    self.email = [dict objectForKey:@"email"];
    self.issuingDate = [dict objectForKey:@"issuingDate"];
    self.mobile = [dict objectForKey:@"mobile"];
    self.orderNumber = [dict objectForKey:@"orderNumber"];
    self.payment = [dict objectForKey:@"payment"];
    self.pnr = [dict objectForKey:@"pnr"];
    self.refundReason = [dict objectForKey:@"refundReason"];
    self.ticketState = [dict objectForKey:@"ticketState"];
    self.travelNature = [dict objectForKey:@"travelNature"];
    self.treasons = [dict objectForKey:@"treasons"];
}
@end
