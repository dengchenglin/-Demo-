//
//  WriteOrderViewController.h
//  HHY
//
//  Created by jiangjun on 14-4-30.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
@class TicketModel;
@class DayModel;

@interface WriteOrderViewController : RootViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property(nonatomic,retain)UILabel *startingtimeLable;
@property(nonatomic,retain)UILabel *endingtimeLable;
@property(nonatomic,retain)UILabel *startPlaceLable;
@property(nonatomic,retain)UILabel *endPlaceLable;
@property(nonatomic,retain)UILabel *typeLable;
@property(nonatomic,retain)UILabel *priceLable;
@property(nonatomic,retain)TicketModel *currentModel;
@property(nonatomic,retain)DayModel *dateModel;
@property(nonatomic,copy)NSString *shippingspaceType;
@property(nonatomic,copy)NSString *start_endPoint;



@end
