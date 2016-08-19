//
//  TicketPayViewController.h
//  HHY
//
//  Created by jiangjun on 14-5-29.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"

@interface TicketPayViewController : RootViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    UITableView *_applyPeopletable;
}
@property(nonatomic,retain)NSDictionary *jasonDict;
@property(nonatomic,assign)NSInteger priceCount;
@property(nonatomic,assign)NSInteger allCount;
@property(nonatomic,retain)NSMutableArray *airPlainArray;
@property(nonatomic,retain)NSMutableArray *passengerArray;
@property(nonatomic,retain)UILabel *numLable;
@property(nonatomic,copy)NSString *orderNum;
@property(nonatomic,assign)BOOL isHuiyuan;

//从订单详情跳入时，传入这两个字段，可用此判断上一页面
@property(nonatomic, retain)NSString *startTime;
@property(nonatomic, retain)NSDictionary *detailInfo;

@end
