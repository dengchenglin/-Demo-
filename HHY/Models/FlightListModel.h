//
//  FlightListModel.h
//  HHY
//
//  Created by jiangjun on 14-6-6.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "JSONModel.h"

@interface FlightListModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *arrivalTime;
@property(nonatomic,strong)NSString<Optional> *departureDate;
@property(nonatomic,strong)NSString<Optional> *departureTime;
@property(nonatomic,strong)NSString<Optional> *desCityCn;
@property(nonatomic,strong)NSString<Optional> *flightNumber;
@property(nonatomic,strong)NSString<Optional> *orgCityCn;
@property(nonatomic,strong)NSString<Optional> *tax;
@property(nonatomic,strong)NSString<Optional> *ticketPrice;
@property(nonatomic,strong)NSString<Optional> *tpFee;
@end
