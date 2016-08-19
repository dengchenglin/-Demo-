//
//  CitySelectViewController.h
//  HHY
//
//  Created by chenguangjiang on 14-10-29.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@protocol CitySelectDelegate <NSObject>

-(void)selectCity:(NSString *)cityName andCityCode:(NSString *)cityCode;

@end

@interface CitySelectViewController : RootViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak,nonatomic) id <CitySelectDelegate>delegate;

@end

