//
//  AppDelegate.m
//  XCLibDemo
//
//  Created by qianbailangmac on 15/12/21.
//  Copyright © 2015年 XC. All rights reserved.
//

#import "AppDelegate.h"
#import "XCHTTPClient.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidStart) name:XCHTTPClientTaskDidStartNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskDidFinish) name:XCHTTPClientTaskDidFinishNotification object:nil];
    return YES;
}

- (void)taskDidStart
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)taskDidFinish
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
