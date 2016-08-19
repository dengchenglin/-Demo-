//
//  AppDelegate.h
//  baiduMapDemo
//
//  Created by 杨晓龙 on 13-3-29.
//  Copyright (c) 2013年 yangxiaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKMapManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

     BMKMapManager *_mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@end
