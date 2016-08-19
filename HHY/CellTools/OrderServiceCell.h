//
//  OrderServiceCell.h
//  HHY
//
//  Created by chenguangjiang on 14-11-10.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FillOrderViewController.h"
#import "CustomPickView.h"
#import "IntakerViewController.h"
@interface OrderServiceCell : UITableViewCell<CustomPickDelegate,IntakerDelegate,UITextFieldDelegate>
-(NSNumber *)refreshView:(NSArray *)servelist;
@property (nonatomic,copy)NSArray *serviceList;
@property (nonatomic,assign)NSInteger nightCount;
@property (nonatomic,assign)NSInteger roomcount;
@property (weak, nonatomic) IBOutlet UIView *serviceView;
@property (weak, nonatomic) IBOutlet UILabel *roomCount;
@property (nonatomic,weak)FillOrderViewController *fillOrderVC;
@property (weak, nonatomic) IBOutlet UITextField *intakerName;



@end
