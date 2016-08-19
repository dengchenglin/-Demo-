//
//  airplanDetailmodel.m
//  HHY
//
//  Created by 兵 张 on 14/11/20.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "airplanDetailmodel.h"

@implementation airplanDetailmodel
@synthesize airWayName = _airWayName;
@synthesize flightnumber = _flightnumber;
@synthesize model = _model;
@synthesize orgCityCN = _orgCityCN;
@synthesize desCityCN = _desCityCN;
@synthesize departureDate = _departureDate;

- (void)jieXi:(NSDictionary *)dic
{
    _airWayName = [dic objectForKey:@"airWayName"];
    _flightnumber = [dic objectForKey:@"flightnumber"];
    _model = [dic objectForKey:@"model"];
    _orgCityCN = [dic objectForKey:@"orgCityCN"];
    _desCityCN = [dic objectForKey:@"desCityCN"];
    _departureDate = [dic objectForKey:@"departureDate"];

}


@end
