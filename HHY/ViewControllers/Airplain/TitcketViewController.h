//
//  TitcketViewController.h
//  HHY
//
//  Created by chenguangjiang on 14-11-19.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
@class TicketModel;
@class DayModel;

@interface TitcketViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property(nonatomic,copy)NSString *dateString;
@property(nonatomic,copy)NSString *start_endPoint;
@property(nonatomic,retain)UILabel *countLable;
@property(nonatomic,copy)NSString *ticketURL;
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,copy)NSString *shippingspaceType;
@property(nonatomic,retain)DayModel *dateModel;
@property(nonatomic,retain)UILabel *timeLable;
@property(nonatomic,assign)BOOL isTimeUp;
@property(nonatomic,assign)BOOL isPriceDown;
@end
