//
//  IntakerViewController.h
//  HHY
//
//  Created by chenguangjiang on 14-11-11.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@protocol IntakerDelegate <NSObject>
@optional
-(void)didSelectIntaker:(NSString *)intaker;

@end
@interface IntakerViewController : RootViewController

@property (weak,nonatomic) id<IntakerDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
-(void)refreshIntakerList;
@end

