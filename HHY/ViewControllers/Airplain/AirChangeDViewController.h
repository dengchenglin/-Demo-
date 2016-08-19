//
//  AirChangeDViewController.h
//  HHY
//
//  Created by 兵 张 on 14/12/17.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@class AirOrderModel;
@interface AirChangeDViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}

@property (nonatomic, retain)AirOrderModel *airModel;

@end
