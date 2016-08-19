//
//  DateSelectViewController.h
//  HHY
//
//  Created by jiangjun on 14-4-29.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
#import "CKCalendarView.h"
@class DayModel;

@protocol DateSelectViewControllerDelegate <NSObject>

-(void)changeDateStarting:(DayModel *)day;
-(void)changeDateEnd:(DayModel *)day;

@end

@interface DateSelectViewController : RootViewController<CKCalendarDelegate>
{
    UIDatePicker *_datePicker;
}

@property(nonatomic,retain)DayModel *dayModel;
@property(nonatomic,assign)BOOL isStarting;
@property(nonatomic,assign)NSString *weekady;
@property(nonatomic,assign)NSString *titleString;
@property(nonatomic,weak)id<DateSelectViewControllerDelegate>target;

@property (nonatomic ,retain)DayModel *startDay;

@end

