//
//  SearchHotelViewController.h
//  HHY
//
//  Created by jiangjun on 14-4-22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"

@interface SearchHotelViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic,copy)NSString *hotelName;
@property (nonatomic,copy)NSString *cityName;
@property (nonatomic,copy)NSString *startDate;
@property (nonatomic,copy)NSString *endDate;
@property (nonatomic,copy)NSString *hotelLevel;
@property (nonatomic,assign)NSInteger pageNo;
@property (nonatomic,assign)NSInteger pageSize;
@property (nonatomic,copy)NSString *cityCode;


@end
