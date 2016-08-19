//
//  DateSelectViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-29.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "DateSelectViewController.h"
#import "DayModel.h"

@interface DateSelectViewController ()

@end

@implementation DateSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNav:self.titleString];
    [self createScreen];
}

-(void)createScreen
{
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startSunday];
    calendar.frame = CGRectMake(0, 40, 320, 300);
    self.dayModel = [[DayModel alloc] init];
    [self.view addSubview:calendar];
    calendar.delegate = self;
}

-(void)changeTheWeekday:(NSString *)string
{
    self.weekady = string;
    self.dayModel.weekDay = string;
}

-(void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
   if([self getNightcount:date] < 0)
   {
        [Utils alertWithTitle:@"选中时间不能在今天之前" message:nil];
       return;
   }
    
    NSDate *tempDate = [NSDate dateWithTimeInterval:(double)8*60.0*60.0 sinceDate:date];
    
    
    if (!_isStarting) {
        if (![tempDate isEqualToDate:_startDay.selfDate]) {
            NSDate *earDate = [tempDate earlierDate:_startDay.selfDate];
            if (earDate!=_startDay.selfDate) {
                //
                [Utils alertWithTitle:@"返程日期不能早于出发日期!" message:nil];
                return ;
            }
        }
    }
    
    [self.dayModel anayse:tempDate];
    if (self.isStarting) {
        [self.target changeDateStarting:self.dayModel];
    }else
        [self.target changeDateEnd:self.dayModel];
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)getNightcount:(NSDate *)endDate
{
    NSDate *nowDate = [NSDate date];
    NSTimeInterval time = [endDate timeIntervalSinceDate:nowDate];
    return  ((NSInteger)time)/(3600 * 24);
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
