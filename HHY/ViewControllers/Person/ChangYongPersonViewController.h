//
//  ChangYongPersonViewController.h
//  HHY
//
//  Created by jiangjun on 14-4-24.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
@class CJRModel;
@class Passenger;
@protocol ChangYongPersonViewControllerDelegate <NSObject>
-(void)addCJR:(Passenger *)model;
@end

@interface ChangYongPersonViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
}
@property(nonatomic,assign)BOOL isOrderTicket;
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,weak)id<ChangYongPersonViewControllerDelegate>target;
@end
