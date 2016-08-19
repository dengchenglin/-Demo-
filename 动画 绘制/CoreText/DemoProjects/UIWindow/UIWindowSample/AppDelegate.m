//
//  AppDelegate.m
//  UIWindowSample
//
//  Created by TangQiao on 6/1/14.
//  Copyright (c) 2014 TangQiao. All rights reserved.
//

#import "AppDelegate.h"
#import "PasswordInputWindow.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSLog(@"UIWindowLevelNormal=%f UIWindowLevelStatusBar=%f UIWindowLevelAlert=%f",
          UIWindowLevelNormal, UIWindowLevelStatusBar, UIWindowLevelAlert);
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[PasswordInputWindow sharedInstance] show];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
