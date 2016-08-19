//
//  HotelOrderReturnViewController.h
//  HHY
//
//  Created by 兵 张 on 14/11/19.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface HotelOrderReturnViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UITableView *orderInfoTable;
    
    
    IBOutlet UIView *bottomView;
    IBOutlet UIButton *btSubmit;
}

@property(nonatomic, retain)NSString *orderNum;
@property(nonatomic, retain)NSString *hotelName;
@property(nonatomic, retain)NSString *hotelTime;
@property(nonatomic, retain)NSString *orderState;

- (IBAction)submit:(id)sender;


@end
