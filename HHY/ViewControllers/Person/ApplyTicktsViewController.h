//
//  ApplyTicktsViewController.h
//  HHY
//
//  Created by 兵 张 on 14/11/21.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface ApplyTicktsViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isHotel;
    UITableView *_tableView;
    UITableView *_hotelTableView;
}
@property(nonatomic,retain)NSMutableArray *dataTicketArray;
@property(nonatomic,retain)NSMutableArray *dataHotelArray;

@end
