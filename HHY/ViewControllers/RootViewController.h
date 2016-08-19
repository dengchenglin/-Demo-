//
//  RootViewController.h
//  HHY
//
//  Created by jiangjun on 14-4-22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
@interface RootViewController : UIViewController
-(void)initNav:(NSString *)title;
-(void)createRighteItem;
-(void)returnRoot;
- (void)startLogin;
@end
