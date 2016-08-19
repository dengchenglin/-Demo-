//
//  AirOrderModel.h
//  HHY
//
//  Created by jiangjun on 14-6-6.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FlightListModel;

@interface AirOrderModel : NSObject
@property(nonatomic,copy)NSString *addTime;
@property(nonatomic,copy)NSString *contactName;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *issuingDate;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *orderNumber;
@property(nonatomic,copy)NSString *pnr;
@property(nonatomic,copy)NSString *ticketState;
@property(nonatomic,copy)NSString *total;
@property(nonatomic,retain)NSMutableArray *flightListArray;
-(void)addOneFlight:(FlightListModel *)model;
-(void)jiexiDict:(NSDictionary *)dict;
@end
