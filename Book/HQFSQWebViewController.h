//
//  HQFSQWebViewController.h
//  IOS
//
//  Created by qianfeng on 13-11-19.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQFSQWebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *shuQiWebView;
- (IBAction)shuQiBtn:(UIButton *)sender;

@end
