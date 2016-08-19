//
//  HQFAppDelegate.h
//  IOS
//
//  Created by qianfeng on 13-11-7.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQFAppDelegate : UIResponder <UIApplicationDelegate>
{
    UIButton *customTabBarBtn1;
    UIButton *customTabBarBtn2;
    UIButton *customTabBarBtn3;
    UIButton *customTabBarBtn4;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) UITabBarController *tabBarController;
@property (nonatomic,retain) UIView *myTarBar;
@property (nonatomic,retain) NSMutableArray *dataArr;
@property (nonatomic,retain) NSMutableArray *muLuArr;
@property (nonatomic,retain) NSMutableArray *bookSelfArr;

@end
