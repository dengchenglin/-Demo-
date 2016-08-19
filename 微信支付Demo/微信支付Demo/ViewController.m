//
//  ViewController.m
//  微信支付Demo
//
//  Created by chenguangjiang on 16/5/31.
//  Copyright © 2016年 dengchenglin. All rights reserved.
//

#import "ViewController.h"
#import "WXApi.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pay:(id)sender {
    PayReq *pay = [[PayReq alloc]init];
    pay.openID = @"wxf85c74c2ef0697bb";

    [WXApi sendReq:pay];
}
@end
