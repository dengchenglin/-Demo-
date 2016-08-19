//
//  DayModel.h
//  HHY
//
//  Created by jiangjun on 14-4-29.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DayModel : NSObject
@property(nonatomic,copy)NSString *year;
@property(nonatomic,copy)NSString *month;
@property(nonatomic,copy)NSString *day;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *description;
@property(nonatomic,copy)NSString *weekDay;
@property(nonatomic,copy)NSString *month_DayDespt;
@property(nonatomic,copy)NSString *year_weekdayDespt;
@property(nonatomic,retain)NSMutableArray *monthArray;
@property(nonatomic, retain)NSDate *selfDate;

-(void)anayse:(NSDate *)date;
-(UIDayCompareRet)comPareOtherDay:(DayModel *)model;
@end
