//
//  OrderDetailModel.h
//  HHY
//
//  Created by jiangjun on 14-6-8.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FlightsDetailModel;
@class PassengerDetailModel;

@interface OrderDetailModel : NSObject
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *advanceBooking;
@property(nonatomic,copy)NSString *contactName;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *issuingDate;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *orderNumber;
@property(nonatomic,copy)NSString *payment;
@property(nonatomic,copy)NSString *pnr;
@property(nonatomic,copy)NSString *refundReason;
@property(nonatomic,copy)NSString *ticketState;
@property(nonatomic,copy)NSString *travelNature;
@property(nonatomic,copy)NSString *treasons;
@property(nonatomic,copy)NSMutableArray *flightArray;
@property(nonatomic,copy)NSMutableArray *passengerArray;
-(void)addOneFlight:(FlightsDetailModel *)model;
-(void)addOnePassenger:(PassengerDetailModel *)model;
-(void)jiexiFromDict:(NSDictionary *)dict;
@end
