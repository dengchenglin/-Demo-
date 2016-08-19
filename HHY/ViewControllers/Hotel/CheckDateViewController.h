//
//  CheckDateViewController.h
//  HHY
//
//  Created by chenguangjiang on 14-11-6.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
@protocol CheckDateDelegate <NSObject>

-(void)changeDate:(NSString *)startdate andEnddate:(NSString *)endate;

@end
@interface CheckDateViewController : UIViewController
@property (nonatomic,weak)id <CheckDateDelegate>delegate;
@property (nonatomic,copy)NSString *startDate;
@property (nonatomic,copy)NSString *endDate;
@property (nonatomic,copy)NSDate *endate;
@end

