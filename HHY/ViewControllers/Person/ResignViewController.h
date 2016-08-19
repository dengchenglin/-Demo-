//
//  ResignViewController.h
//  HHY
//
//  Created by jiangjun on 14-4-22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"
@interface ResignViewController : RootViewController<UITextFieldDelegate>
{
    BOOL isAgree;
}
@property(nonatomic,retain)UITextField *nameTextFiled;
@property(nonatomic,retain)UITextField *passwordTextFiled;
@property(nonatomic,retain)UITextField *surePasswdTF;
@property (nonatomic,strong)LoginViewController *loginVC;
@end
