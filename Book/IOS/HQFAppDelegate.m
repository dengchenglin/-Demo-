//
//  HQFAppDelegate.m
//  IOS
//
//  Created by qianfeng on 13-11-7.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFAppDelegate.h"
#import "HQFFirstViewController.h"
#import "HQFSecondViewController.h"
#import "HQFThreeViewController.h"
#import "HQFFourViewController.h"


@interface HQFAppDelegate()
-(void)initCusttomTabbar;//初始化自己的tabbar
@end

@implementation HQFAppDelegate
@synthesize myTarBar;
@synthesize dataArr;
@synthesize muLuArr;
@synthesize bookSelfArr;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    dataArr = [[NSMutableArray alloc]init];
    muLuArr = [[NSMutableArray alloc]init];
    bookSelfArr = [[NSMutableArray alloc]init];
    NSLog(@"bookSelf----%@",bookSelfArr);
    HQFFirstViewController *fist = [[HQFFirstViewController alloc]initWithNibName:@"HQFFirstViewController"bundle:nil];
    //UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:fist];
    HQFSecondViewController *second = [[HQFSecondViewController alloc]initWithNibName:@"HQFSecondViewController"bundle:nil];
    HQFThreeViewController *three = [[HQFThreeViewController alloc]initWithNibName:@"HQFThreeViewController" bundle:nil];
    HQFFourViewController *four = [[HQFFourViewController alloc]initWithNibName:@"HQFFourViewController" bundle:nil];
    
    self.tabBarController = [[UITabBarController alloc]init];
    self.tabBarController.viewControllers = @[fist,second,three,four];
    self.window.rootViewController = self.tabBarController;
    [self initCusttomTabbar];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)initCusttomTabbar
{
    //1.先将原来的tabbar隐藏
    self.tabBarController.tabBar.hidden = YES;
//    //1.删掉tarbar
//    for (UIView *v1 in self.tabBarController.view.subviews) {
//        if ([v1 isKindOfClass:[UITabBar class]]) {
//            [v1 removeFromSuperview];
//        }
//    }
    //加入自定义tabbar的背景图片
//    //实例化自定义tabbar的背景图片
//    UIImage *customTabbarBackground = [UIImage imageNamed:@"skin_bottom_bar_background.png"];
//    
    //通过该图片的到对应的宽高，由于图片不适配，所有只能自己定义
//    int imgHeight=76;
//    int imgWidth=320;
    
    //通过图片的宽高实例化自己的View，冒充tabbar
    myTarBar = [[UIView alloc]initWithFrame:CGRectMake(0, 480-49, 320, 49)];
    myTarBar.backgroundColor = [UIColor blackColor];
    //myTabBar.alpha = 0.7;
    
//    //在该view中加入背景图片
//    UIImageView *customTabBarImageView = [[UIImageView alloc]initWithImage:customTabbarBackground];
//    [myTarBar addSubview:customTabBarImageView];
    
    //加入对应的四个按键并分别设置各自的响应函数
    //按钮1
    customTabBarBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *customTabBarBtn1Nommal = [UIImage imageNamed:@"icon2.png"];
    UIImage *customTabBarBtn1Select = [UIImage imageNamed:@"icon2_selected.png"];
    customTabBarBtn1.frame = CGRectMake(320/4*0, 0, 320/4, 49);
    customTabBarBtn1.tag = 310;
    [customTabBarBtn1 setBackgroundImage:customTabBarBtn1Nommal forState:UIControlStateNormal];
    [customTabBarBtn1 setBackgroundImage:customTabBarBtn1Select forState:UIControlStateSelected];
    [customTabBarBtn1 addTarget:self action:@selector(btnOneSelectde) forControlEvents:UIControlEventTouchUpInside];
    [myTarBar addSubview:customTabBarBtn1];
    
    //按钮2
    customTabBarBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *customTabBarBtn2Nommal = [UIImage imageNamed:@"icon3.png"];
    UIImage *customTabBarBtn2Select = [UIImage imageNamed:@"icon3_selected.png"];
    customTabBarBtn2.frame = CGRectMake(320/4*1, 0, 320/4, 49);
    customTabBarBtn2.tag = 320;
    [customTabBarBtn2 setBackgroundImage:customTabBarBtn2Nommal forState:UIControlStateNormal];
    [customTabBarBtn2 setBackgroundImage:customTabBarBtn2Select forState:UIControlStateSelected];
    [customTabBarBtn2 addTarget:self action:@selector(btnTowSelectde) forControlEvents:UIControlEventTouchUpInside];
    [myTarBar addSubview:customTabBarBtn2];
    
    //按钮3
    customTabBarBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *customTabBarBtn3Nommal = [UIImage imageNamed:@"icon1.png"];
    UIImage *customTabBarBtn3Select = [UIImage imageNamed:@"icon1_selected.png"];
    customTabBarBtn3.frame = CGRectMake(320/4*2, 0, 320/4, 49);
    [customTabBarBtn3 setBackgroundImage:customTabBarBtn3Nommal forState:UIControlStateNormal];
    [customTabBarBtn3 setBackgroundImage:customTabBarBtn3Select forState:UIControlStateSelected];
    [customTabBarBtn3 addTarget:self action:@selector(btnThreeSelectde) forControlEvents:UIControlEventTouchUpInside];
    [myTarBar addSubview:customTabBarBtn3];
    
    //按钮1
    customTabBarBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *customTabBarBtn4Nommal = [UIImage imageNamed:@"icon4.png"];
    UIImage *customTabBarBtn4Select = [UIImage imageNamed:@"icon4_selected.png"];
    customTabBarBtn4.frame = CGRectMake(320/4*3, 0, 320/4, 49);
    [customTabBarBtn4 setBackgroundImage:customTabBarBtn4Nommal forState:UIControlStateNormal];
    [customTabBarBtn4 setBackgroundImage:customTabBarBtn4Select forState:UIControlStateSelected];
    [customTabBarBtn4 addTarget:self action:@selector(btnFourSelectde) forControlEvents:UIControlEventTouchUpInside];
    [myTarBar addSubview:customTabBarBtn4];
    
    
    //将自定义的tabbar加到tabbarController中
    [self.tabBarController.view addSubview:myTarBar];
    
    //设置初始状态
    int initSelect = 0;//假设第一个被选中，现实中多为从记录中加载
    customTabBarBtn1.selected = YES;
    [self.tabBarController setSelectedIndex:initSelect];
    
}

//自定义tabbar上第一个按钮的响应函数

- (void)btnOneSelectde
{
    customTabBarBtn1.selected = YES;
    customTabBarBtn2.selected = NO;
    customTabBarBtn3.selected = NO;
    customTabBarBtn4.selected = NO;
    [self.tabBarController setSelectedIndex:0];
}
- (void)btnTowSelectde
{
    customTabBarBtn1.selected = NO;
    customTabBarBtn2.selected = YES;
    customTabBarBtn3.selected = NO;
    customTabBarBtn4.selected = NO;
    [self.tabBarController setSelectedIndex:1];
}

- (void)btnThreeSelectde
{
    customTabBarBtn1.selected = NO;
    customTabBarBtn2.selected = NO;
    customTabBarBtn3.selected = YES;
    customTabBarBtn4.selected = NO;
    [self.tabBarController setSelectedIndex:2];
    
}

- (void)btnFourSelectde
{
    customTabBarBtn1.selected = NO;
    customTabBarBtn2.selected = NO;
    customTabBarBtn3.selected = NO;
    customTabBarBtn4.selected = YES;
    [self.tabBarController setSelectedIndex:3];
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

@end
