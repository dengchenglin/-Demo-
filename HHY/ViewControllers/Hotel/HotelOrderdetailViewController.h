//
//  HotelOrderdetailViewController.h
//  HHY
//
//  Created by 兵 张 on 14/11/17.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface HotelOrderdetailViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_hotelTable;
    IBOutlet UIView *bottomView;
    IBOutlet UILabel *lbOrderPrice;
    IBOutlet UIButton *btPay;
    
}

@property(nonatomic, retain)NSString *orderNum;
@property(nonatomic, retain)NSString *hotelName;
@property(nonatomic, retain)NSString *hotelTime;
@property(nonatomic, retain)NSString *orderState;


- (IBAction)toPay:(id)sender;
@end
