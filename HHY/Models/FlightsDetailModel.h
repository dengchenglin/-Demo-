//
//  FlightsDetailModel.h
//  HHY
//
//  Created by jiangjun on 14-6-8.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "JSONModel.h"

@interface FlightsDetailModel : JSONModel
{
    BOOL _isClick;
}
@property(nonatomic,strong)NSString<Optional> *advanceBooking;
@property(nonatomic,strong)NSString<Optional> *airWayName;
@property(nonatomic,strong)NSString<Optional> *arrivalTime;
@property(nonatomic,strong)NSString<Optional> *cabin;
@property(nonatomic,strong)NSString<Optional> *cheap;
@property(nonatomic,strong)NSString<Optional> *departureDate;
@property(nonatomic,strong)NSString<Optional> *departureTime;
@property(nonatomic,strong)NSString<Optional> *desCity;
@property(nonatomic,strong)NSString<Optional> *desCityCN;
@property(nonatomic,strong)NSString<Optional> *farePrice;
@property(nonatomic,strong)NSString<Optional> *flightnumber;
@property(nonatomic,strong)NSString<Optional> *model;
@property(nonatomic,strong)NSString<Optional> *notCheap;
@property(nonatomic,strong)NSString<Optional> *orgCity;
@property(nonatomic,strong)NSString<Optional> *orgCityCN;
@property(nonatomic,strong)NSString<Optional> *pertpFee;
@property(nonatomic,strong)NSString<Optional> *pertpReson;
@property(nonatomic,strong)NSString<Optional> *publishedPrice;
@property(nonatomic,strong)NSString<Optional> *sn;
@property(nonatomic,strong)NSString<Optional> *stop;
@property(nonatomic,strong)NSString<Optional> *tax;
@property(nonatomic,strong)NSString<Optional> *terminal;
@property(nonatomic,strong)NSString<Optional> *ticketPrice;
@property(nonatomic,strong)NSString<Optional> *tpFee;
-(void)setStateValue:(BOOL)state;
-(BOOL)getStateValue;
@end
