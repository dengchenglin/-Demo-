//
//  TicketModel.h
//  HHY
//
//  Created by jiangjun on 14-4-29.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "JSONModel.h"

@interface TicketModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *adepCode;
@property(nonatomic,strong)NSString<Optional> *adepName;
@property(nonatomic,strong)NSString<Optional> *arriveTime;
@property(nonatomic,strong)NSString<Optional> *airLineCode;
@property(nonatomic,strong)NSString<Optional> *arriveTerminal;
@property(nonatomic,strong)NSString<Optional> *departTerminal;
@property(nonatomic,strong)NSString<Optional> *airLineName;
@property(nonatomic,strong)NSString<Optional> *destName;
@property(nonatomic,strong)NSString<Optional> *fltNo;
@property(nonatomic,strong)NSString<Optional> *flyTime;
@property(nonatomic,strong)NSString<Optional> *operateCode;
@property(nonatomic,strong)NSString<Optional> *planeModel;
@property(nonatomic,strong)NSArray<Optional> *spaceAndPrice;
@property(nonatomic,strong)NSString<Optional> *deptDate;
@property(nonatomic,strong)NSString<Optional> *departFee;
@property(nonatomic,strong)NSString<Optional> *fuelFee;
@property(nonatomic, strong)NSString<Optional> *taxFee;
@property(nonatomic,strong)NSString<Optional> *stops;
@property(nonatomic,strong)NSString<Optional> *destCode;
@property(nonatomic,strong)NSDictionary<Ignore> *minPrice;
@property(nonatomic,strong)NSDictionary<Ignore> *maxPrice;
-(void)anasystring:(NSString *)string;
-(void)paixu;
-(void)anasyDict:(NSDictionary *)temp;
@end
