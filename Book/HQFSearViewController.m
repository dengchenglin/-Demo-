//
//  HQFSearViewController.m
//  IOS
//
//  Created by qianfeng on 13-11-19.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFSearViewController.h"

@interface HQFSearViewController ()

@end

@implementation HQFSearViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil AndBookId:(NSString *)bookId
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        myBookId = bookId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@">>>>>>>%@",myBookId);
    self.myWebView.scrollView.bounces = NO;
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://bookt.yisou.com/i.php?v=3&ct=def&ac=show&bid=%@&contentsite=",myBookId]]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)blackBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ==
#pragma UIWebViewDelegate的代理
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

@end
