//
//  EitIntakerCell.h
//  HHY
//
//  Created by chenguangjiang on 14-11-11.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntakerViewController.h"
@interface EitIntakerCell : UITableViewCell
@property (weak,nonatomic)IntakerViewController *intakerVC;
@property (nonatomic,copy)NSDictionary *intakerDic;
@property (nonatomic,assign)NSInteger index;
@property (weak, nonatomic) IBOutlet UILabel *intakeName;
@property (weak, nonatomic) IBOutlet UIButton *selectBut;
@property (weak, nonatomic) IBOutlet UIButton *eitBut;
- (IBAction)eit;
@end
