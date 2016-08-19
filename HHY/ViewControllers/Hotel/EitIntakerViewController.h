//
//  EitIntakerViewController.h
//  HHY
//
//  Created by chenguangjiang on 14-11-12.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "IntakerViewController.h"
@interface EitIntakerViewController : RootViewController
@property (weak,nonatomic)IntakerViewController *intakerVC;
@property (nonatomic,copy) NSDictionary *intakerDic;
@property (weak, nonatomic) IBOutlet UITextField *intakerName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (assign,nonatomic) NSInteger index;
@end
