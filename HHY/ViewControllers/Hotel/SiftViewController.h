//
//  SiftViewController.h
//  HHY
//
//  Created by chenguangjiang on 14-11-1.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@protocol SiftCtlDelegate <NSObject>

-(void)getSiftDic:(NSDictionary *)dic;

@end
@interface SiftViewController :RootViewController
@property (nonatomic,weak)id<SiftCtlDelegate>delegate;
@property (nonatomic,copy)NSString *cityCode;
@end
