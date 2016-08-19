//
//  CheckDateViewController.m
//  HHY
//
//  Created by chenguangjiang on 14-11-6.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "CheckDateViewController.h"
#import "CKCalendarView.h"
#import "DayModel.h"
#import "CitySelectButton.h"
#import "CustomNavBar.h"
@interface CheckDateViewController ()<CKCalendarDelegate,CustomBarDelegate>
@end

@implementation CheckDateViewController

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
 
    [self createView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
    CustomNavBar *navbar =[[CustomNavBar alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navbar.delegate = self;
    [navbar creatTitle:@"修改日期"];
    [navbar creatRightButtonWithFrame:CGRectMake(265, 27.5, 40, 25) andImageName:nil andTitle:@"完成"];
    [self.view addSubview:navbar];
    
}

-(void)createView{
    
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startSunday];
    calendar.frame = CGRectMake(0, 84, 320, 300);
    calendar.selectedDate = [self getDate:_startDate];
    [self.view addSubview:calendar];
    calendar.delegate = self;
    
    UIView *resultView =[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 70, 320, 40)];
    resultView.backgroundColor = [UIColor whiteColor];
      NSDate *date = [self getDate:_startDate];
    UILabel *startlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 30)];
    startlabel.tag = 1;
    startlabel.text = [NSString stringWithFormat:@"入住:%@",[self getMdStr:date]];
    startlabel.textColor = kADWColor(50, 50, 50, 1);
    startlabel.font = [UIFont systemFontOfSize:12];
    [resultView addSubview:startlabel];
    
    
    UIView *countView = [[UIView alloc]initWithFrame:CGRectMake(110, 7, 100, 26)];
    [countView.layer setBorderWidth:1];
    [countView.layer setBorderColor:kADWColor(180, 180, 180, 1).CGColor];
    UIButton *minlus = [UIButton buttonWithType:UIButtonTypeCustom];
    [minlus setFrame:CGRectMake(0, 1, 30, 24)];
    [minlus setTitle:@"－" forState:UIControlStateNormal];
    [minlus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [minlus setBackgroundColor:kADWColor(53, 144, 248, 1)];
    [minlus addTarget:self action:@selector(minplus) forControlEvents:UIControlEventTouchUpInside];
    [countView addSubview:minlus];
    
    UIButton *plus = [UIButton buttonWithType:UIButtonTypeCustom];
    [plus setFrame:CGRectMake(70, 1, 30, 24)];
    [plus setTitle:@"＋" forState:UIControlStateNormal];
    [plus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [plus setBackgroundColor:kADWColor(53, 144, 248, 1)];
    [plus addTarget:self action:@selector(plus) forControlEvents:UIControlEventTouchUpInside];
    [countView addSubview:plus];
    
    UILabel *countLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 3, 20, 20)];
    countLable.tag = 3;
    countLable.text = @"1";
    countLable.textAlignment = NSTextAlignmentCenter;
    countLable.textColor = kADWColor(50, 50, 50, 1);
    countLable.font = [UIFont systemFontOfSize:12];
    [countView addSubview:countLable];
    UILabel *nightlabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 3, 20, 20)];
    nightlabel.text = @"晚";
    nightlabel.font = [UIFont systemFontOfSize:13];
    nightlabel.textColor = kADWColor(50, 50, 50, 1);
    [countView addSubview:nightlabel];
    
    [resultView addSubview:countView];
    
 
    
    
    
    UILabel *endlabel =[[UILabel alloc]initWithFrame:CGRectMake(230, 5, 80, 30)];
    endlabel.tag = 2;
    NSDate *endate =[self getDate:_endDate];
    
    endlabel.text = [NSString stringWithFormat:@"离店:%@",[self getMdStr:endate]];
    endlabel.textColor = kADWColor(50, 50, 50, 1);
    endlabel.font = [UIFont systemFontOfSize:12];
    [resultView addSubview:endlabel];
    
    [self.view addSubview:resultView];
}

-(NSString *)getMdStr:(NSDate *)date
{
    DayModel *dayMoel = [[DayModel alloc]init];
    [dayMoel anayse:date];
    
    return dayMoel.month_DayDespt;
}

-(NSDate *)getDate:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timezone = [NSTimeZone timeZoneForSecondsFromGMT:0.0f];
    [formatter setTimeZone:timezone];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    return [formatter dateFromString:dateStr];
    
}

#pragma mark CKcalenderDelegate


-(void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
    
    if([self getNightcount:date] < 0)
    {
        [Utils alertWithTitle:@"选中时间不能在今天之前" message:nil];
        return;
    }
     NSDate *tempDate = [NSDate dateWithTimeInterval:(double)8*60.0*60.0 sinceDate:date];
    UILabel *label = (UILabel *)[self.view viewWithTag:1];
    label.text = [NSString stringWithFormat:@"入住:%@",[self getMdStr:tempDate]];
    DayModel *daymoel = [[DayModel alloc]init];
    [daymoel anayse:tempDate];
    self.startDate = daymoel.description;
    
    
    UILabel *countlabel = (UILabel *)[self.view viewWithTag:3];
    NSDate *startDate = [self getDate:_startDate];
    NSDate *endate = [NSDate dateWithTimeInterval:[countlabel.text integerValue] * 24 *60 *60 sinceDate:startDate];
    self.endate = endate;
    UILabel *endlabel = (UILabel *)[self.view viewWithTag:2];
    endlabel.text = [NSString stringWithFormat:@"离店:%@",[self getMdStr:endate]];
}


-(void)minplus
{
    UILabel *countlabel = (UILabel *)[self.view viewWithTag:3];
    if([countlabel.text integerValue]<2)
    {
        return;
    }
    countlabel.text = [NSString stringWithFormat:@"%d",[countlabel.text integerValue] - 1];
    
    NSDate *startDate = [self getDate:_startDate];
    NSDate *endate = [NSDate dateWithTimeInterval:[countlabel.text integerValue] * 24 *60 *60 sinceDate:startDate];
    self.endate = endate;
    UILabel *label = (UILabel *)[self.view viewWithTag:2];
    label.text = [NSString stringWithFormat:@"离店:%@",[self getMdStr:endate]];
}
-(void)plus
{
    UILabel *countlabel = (UILabel *)[self.view viewWithTag:3];
    countlabel.text = [NSString stringWithFormat:@"%d",[countlabel.text integerValue] + 1];
    NSDate *startDate = [self getDate:_startDate];
    NSDate *endate = [NSDate dateWithTimeInterval:[countlabel.text integerValue] * 24 *60 *60 sinceDate:startDate];
     self.endate = endate;
    UILabel *label = (UILabel *)[self.view viewWithTag:2];
    label.text = [NSString stringWithFormat:@"离店:%@",[self getMdStr:endate]];

}


-(void)rightButtonClick
{
    if(_delegate && [_delegate respondsToSelector:@selector(changeDate:andEnddate:)])
    {
        if(_startDate && _endate)
        {
            DayModel *daymodel = [[DayModel alloc]init];
            [daymodel anayse:_endate];
            [_delegate changeDate:self.startDate andEnddate:daymodel.description];
         }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
