//
//  HQFLoginViewController.h
//  IOS
//
//  Created by qianfeng on 13-11-21.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface HQFLoginViewController : UIViewController<UITextFieldDelegate,ASIHTTPRequestDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userTextFielf;
@property (weak, nonatomic) IBOutlet UITextField *passwTextField;

- (IBAction)myBackBtn:(UIButton *)sender;
- (IBAction)loginBtn:(UIButton *)sender;
- (IBAction)signinBtn:(UIButton *)sender;

@end
