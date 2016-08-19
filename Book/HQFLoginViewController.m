//
//  HQFLoginViewController.m
//  IOS
//
//  Created by qianfeng on 13-11-21.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFLoginViewController.h"
#import "HQFSigninViewController.h"
#import "ASIHTTPRequest.h"
#import "NSString+SBJSON.h"
#import "HQFLoginModel.h"


//登录帐号界面
@interface HQFLoginViewController (){
    bool flag ;
}

@end

@implementation HQFLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myTap)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)myTap
{
    [self.passwTextField resignFirstResponder];
    [self.userTextFielf resignFirstResponder];
}

//返回按钮
- (IBAction)myBackBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginBtn:(UIButton *)sender {
    if (self.passwTextField.text.length == 0&& self.userTextFielf.text.length == 0) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"帐号或密码输入有误" message:@"请重新输入!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
    else
    {
        NSString *getStr = @"http://book1104.duapp.com/getMessage.php";
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:getStr]];
        request.delegate = self;
        [request startAsynchronous];
    }
    
    
}

- (IBAction)signinBtn:(UIButton *)sender {
    
    HQFSigninViewController *signin = [[HQFSigninViewController alloc]init];
    [self presentViewController:signin animated:YES completion:nil];
}

#pragma mark --
#pragma mark ASIHTTPRequestDelegate的代理

- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSString * str = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    id objc = [str JSONValue];
    for (NSDictionary *dic in objc) {
        HQFLoginModel *model = [[HQFLoginModel alloc]init];
        model.uerName = [dic objectForKey:@"usrName"];
        model.passW = [dic objectForKey:@"passW"];
        model.phone = [dic objectForKey:@"phone"];
        
        if ([self.userTextFielf.text isEqualToString:model.uerName])
        {
            if ([self.passwTextField.text isEqualToString:model.passW]) {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"登录成功" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                alertView.tag = 25;
                [alertView show];
                flag = YES;
            }
            else
            {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"密码有误" message:@"请重新输入!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }
            break;
        }
    }
    
    if(flag == NO){
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"帐号有误" message:@"请重新输入!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
}

#pragma mark --
#pragma mark UIAlertViewDelegate的代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 25) {
        NSLog(@"-----");
    }
}

#pragma mark --
#pragma mark UITextFieldDelegate的代理

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
@end
