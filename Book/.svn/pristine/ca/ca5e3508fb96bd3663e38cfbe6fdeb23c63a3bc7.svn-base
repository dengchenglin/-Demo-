//
//  HQFSQWebViewController.m
//  IOS
//
//  Created by qianfeng on 13-11-19.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFSQWebViewController.h"

@interface HQFSQWebViewController ()

@end

@implementation HQFSQWebViewController

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
    NSString *url = @"http://t.shuqi.com";
    self.shuQiWebView.scrollView.bounces = NO;
    [self.shuQiWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shuQiBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ==
#pragma UIWebViewDelegate的代理

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

@end
