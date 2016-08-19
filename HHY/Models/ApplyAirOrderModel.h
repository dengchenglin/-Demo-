//
//  ApplyAirOrderModel.h
//  HHY
//
//  Created by 兵 张 on 14/11/22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplyAirOrderModel : NSObject


@property (nonatomic, retain)NSString *orderNumber;
@property (nonatomic, retain)NSString *addTime;
@property (nonatomic, retain)NSString *monile;
@property (nonatomic, retain)NSString *contactName;
@property (nonatomic, retain)NSString *totleFee;
@property (nonatomic, retain)NSString *ticketState;
@property (nonatomic, retain)NSString *username;

- (void)jieXi:(NSDictionary *)dic;
@end
