//
//  AddIntakerCell.h
//  HHY
//
//  Created by chenguangjiang on 14-11-11.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntakerViewController.h"
@interface AddIntakerCell : UITableViewCell
@property (weak,nonatomic) IntakerViewController *intakerVC;
@property (weak, nonatomic) IBOutlet UITextField *intakerName;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *addBut;
- (IBAction)add;
@end
