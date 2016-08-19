//
//  AppDelegate.m
//  HHY
//
//  Created by 谈文钊 on 14-4-21.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "MobClick.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"weCoetcEHxBkT3bKGET9U2Fm" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"navbg"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forBarMetrics:UIBarMetricsDefault];
    // Override point for customization after application launch.
    HomeViewController *mvc = [[HomeViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mvc];
    self.window.rootViewController = nc;
    JJRelease(mvc);
    JJRelease(nc);
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //有盟统计
    [MobClick startWithAppkey:@"5449bab2fd98c5d72b015700" reportPolicy:BATCH channelId:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //    [self parse:url application:application];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    //
    //    NSLog(@"url = %@",url);
    [self parse:url application:application];
    
    return  YES;
}

#pragma mark ali
- (void)parse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
    NSLog(@"支付宝--result = %@----%@", [result description], result.resultString);
    if (result)
    {
        NSLog(@"支付宝--result = %@", result);
        
        if (result.statusCode == 9000)
        {
            /*
             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
             */
            
            //交易成功
            //            NSString* key = @"签约帐户后获取到的支付宝公钥";
            //            id<DataVerifier> verifier;
            //            verifier = CreateRSADataVerifier(key);
            //
            //            if ([verifier verifyString:result.resultString withSign:result.signString])
            //            {
            //                            //验证签名成功，交易结果无篡改
            //                NSLog(@"支付宝--result = %@", result);
            //                [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBsuccess" object:@"1"];
            //            } else {
            //                NSLog(@"支付宝-交易失败--result = %@", result);
            //                [[NSNotificationCenter defaultCenter] postNotificationName:@"ZFBsuccess" object:@"0"];
            //            }
            
            NSLog(@"支付宝--支付成功result = %@", result);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPaySuccess" object:@"1"];
        } else {
            //交易失败
            NSLog(@"支付宝-交易失败--result = %@", result);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPaySuccess" object:@"0"];
            
        }
    }
    else
    {
        NSLog(@"支付宝-交易失败--result = %@", result);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"aliPaySuccess" object:@"0"];
        
        //失败
    }
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
    NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
    return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
    AlixPayResult * result = nil;
    
    if (url != nil && [[url host] compare:@"safepay"] == 0) {
        result = [self resultFromURL:url];
    }
    
    return result;
}


@end
