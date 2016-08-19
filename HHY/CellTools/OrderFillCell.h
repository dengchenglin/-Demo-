//
//  OrderFillCell.h
//  HHY
//
//  Created by chenguangjiang on 14-11-7.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FillOrderViewController.h"
@interface OrderFillCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic,assign)FillOrderViewController *fillOrderVC;
@property (weak, nonatomic) IBOutlet UITextField *Contacter;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *postcode;
@property (weak, nonatomic) IBOutlet UITextField *adress;
@property (weak, nonatomic) IBOutlet UIButton *noBut;
@property (weak, nonatomic) IBOutlet UIButton *isBut;
- (IBAction)yes;
- (IBAction)no;

@property (nonatomic,copy) NSString *invoice;
@end
