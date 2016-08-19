//
//  DayModel.m
//  HHY
//
//  Created by jiangjun on 14-4-29.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "DayModel.h"

@implementation DayModel
@synthesize description = _description;
@synthesize selfDate = _selfDate;

-(id)init
{
    if (self = [super init]) {
        self.monthArray = [[NSMutableArray alloc] initWithObjects:@"", @"JAN", @"FEB", @"MAR", @"APR", @"MAY", @"JUN", @"JUL", @"AUG", @"SEP", @"OCT", @"NOV", @"DEC", nil];
    }
    return self;
}

-(void)anayse:(NSDate *)date
{
    /*确定属性_weekday 的值，美版 iphone 和行货略有区别*/
    NSArray *engArray_English = @[@"Sun",@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat"];
    NSArray *engArray_Chease = @[@"周日",@"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    
    NSDateFormatter *form= [[NSDateFormatter alloc] init];
    [form setDateFormat:@"G yyyy/MM/dd(EEE) K:mm:ss"];
    NSString *string1 = [form stringFromDate:date];
    NSArray *array1 = [string1 componentsSeparatedByString:@" "];
    NSArray *arrayTemp = [[array1 objectAtIndex:1] componentsSeparatedByString:@"("];
    
    NSString *strRet = [[arrayTemp objectAtIndex:1] substringToIndex:3];
    NSLog(@"strRet = %@", strRet);
    strRet = [strRet stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    for (int i=0; i<7; i++) {
        if ( ([strRet isEqualToString:[engArray_English objectAtIndex:i]]) || ([strRet isEqualToString:[engArray_Chease objectAtIndex:i]]) ) {
            
            self.weekDay = [NSString stringWithFormat:@"%d",i];
        }
    }

    
    
    
    NSArray *weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五",@"六"];
    NSString *string = date.description;
    NSArray *array = [string componentsSeparatedByString:@" "];
//    2014-04-28
//    2014-04-29
    self.description = [array objectAtIndex:0];
    NSArray *dayArray = [self.description componentsSeparatedByString:@"-"];
    self.day = [dayArray objectAtIndex:2];
    self.month = [self.monthArray objectAtIndex:[[dayArray objectAtIndex:1] integerValue]];
    self.year = [[dayArray objectAtIndex:0] substringFromIndex:2];
    self.time = [[self.day stringByAppendingString:self.month] stringByAppendingString:self.year];
    self.month_DayDespt = [NSString stringWithFormat:@"%d月%d日",[[dayArray objectAtIndex:1] intValue], [[dayArray objectAtIndex:2] intValue]];
    
    self.year_weekdayDespt = [NSString stringWithFormat:@"%@年  星期%@", [dayArray objectAtIndex:0], [weekArray objectAtIndex:[self.weekDay intValue]]];
    self.selfDate = date;
}

-(UIDayCompareRet)comPareOtherDay:(DayModel *)model
{
    NSLog(@" %@ Entering Comparing %@", [self changeThedescription], [model changeThedescription]);
    if ([self changeThedescription].integerValue < [[model changeThedescription] integerValue]) {
        return UIDayModelBefore;
    }else if ([self changeThedescription].integerValue == [model changeThedescription].integerValue){
        return UIDayModelEqual;
    }else{
        return UIDayModelAfter;
    }
}

-(NSString *)changeThedescription
{
    NSMutableString *string = [[NSMutableString alloc] initWithString:self.description];
    for (int i=0; i<string.length; i++) {
        unichar ch = [string characterAtIndex:i];
        if (ch == '-') {
            [string replaceCharactersInRange:NSMakeRange(i, 1) withString:@"0"];
        }
    }
    return string;
}
@end
