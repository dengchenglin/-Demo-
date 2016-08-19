//
//  airplanDetailmodel.h
//  HHY
//
//  Created by 兵 张 on 14/11/20.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface airplanDetailmodel : NSObject

@property(nonatomic, retain)NSString *airWayName;
@property(nonatomic, retain)NSString *departureDate;
@property(nonatomic, retain)NSString *orgCityCN;
@property(nonatomic, retain)NSString *desCityCN;
@property(nonatomic, retain)NSString *flightnumber;
@property(nonatomic, retain)NSString *model;

- (void)jieXi:(NSDictionary *)dic;

@end
