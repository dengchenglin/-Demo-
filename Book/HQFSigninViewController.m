//
//  HQFSigninViewController.m
//  IOS
//
//  Created by qianfeng on 13-11-22.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFSigninViewController.h"
#import "ASIHTTPRequest.h"
#import "GDataXMLNode.h"
#import "NSString+SBJSON.h"

@interface HQFSigninViewController ()

@end

@implementation HQFSigninViewController

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


- (void)myTap
{
    [self.usrText resignFirstResponder];
    [self.passwText resignFirstResponder];
    [self.phoneText resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)myBackBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)signinBtn:(UIButton *)sender {
    
    
    NSLog(@"-----%@------%@-----%d",self.usrText.text,self.passwText.text,[self.phoneText.text intValue]);
    NSString *insertURL = [NSString stringWithFormat:@"http://book1104.duapp.com/insertIntoPost.php?usrName=%@&passW=%@&phone=%d",self.usrText.text,self.passwText.text,[self.phoneText.text intValue]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:insertURL]];
    request.delegate = self;
    [request startAsynchronous];
}


#pragma mark --
#pragma mark ASIHTTPRequestDelegate的代理
- (void)requestFinished:(ASIHTTPRequest *)request
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"注册成功" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
    
}

#pragma mark --
#pragma mark UIAlertViewDelegate的代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --
#pragma UITextFieldDelegate的代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
@end
