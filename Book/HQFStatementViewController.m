//
//  HQFStatementViewController.m
//  IOS
//
//  Created by qianfeng on 13-11-19.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFStatementViewController.h"

//免责声明。。。。。。。
@interface HQFStatementViewController ()

@end

@implementation HQFStatementViewController

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回按钮
- (IBAction)myStatementBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
