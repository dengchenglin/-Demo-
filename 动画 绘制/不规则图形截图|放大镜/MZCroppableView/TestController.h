//
//  TestController.h
//  MZCroppableView
//
//  Created by chenguangjiang on 15/9/16.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestController : UIViewController
@property (strong, nonatomic) UIImageView *imageView;
- (IBAction)cut:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)fitFill:(id)sender;
- (IBAction)center:(id)sender;
@end
