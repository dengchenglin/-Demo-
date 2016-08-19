//
//  OrderReturnMenuViewController.h
//  HHY
//
//  Created by 兵 张 on 14/11/20.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface OrderReturnMenuViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *menuTable;
    IBOutlet UIView *bottomView;
    IBOutlet UIButton *btSubmit;
}
- (IBAction)Agree:(id)sender;

@property(nonatomic, retain)NSString *orderNum;
@property(nonatomic, retain)NSString *hotelName;
@property(nonatomic, retain)NSString *hotelTime;
@property(nonatomic, retain)NSString *orderState;

@end
