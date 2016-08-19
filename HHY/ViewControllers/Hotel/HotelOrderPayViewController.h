//
//  HotelOrderPayViewController.h
//  HHY
//
//  Created by 兵 张 on 14/11/15.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface HotelOrderPayViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UITableView *_applyPeopletable;
}
@property(nonatomic,assign)BOOL isHuiYuan;

//传参
@property(nonatomic, retain)NSString *orderNum;
@property(nonatomic, retain)NSString *hotelName;
@property(nonatomic, retain)NSDictionary *roomDic;
@property(nonatomic, retain)NSString *roomNumber;
@property(nonatomic, retain)NSString *addBedCount;
@property(nonatomic, retain)NSString *addBedMoney;
@property(nonatomic, retain)NSString *breckfirstCount;
@property(nonatomic, retain)NSString *breckfirstMoney;
@property(nonatomic, retain)NSString *startDate;
@property(nonatomic, retain)NSString *endDate;

@property (nonatomic, retain)NSString *price;
@property(nonatomic, retain)NSString *orderTime;

@end
