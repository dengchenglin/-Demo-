//
//  GNHotelViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "GNHotelViewController.h"
#import "SearchHotelViewController.h"
#import "CustomView.h"
#import "CitySelectButton.h"
#import "SelectTypeButton.h"
#import "CitySelectViewController.h"
#import "DateSelectViewController.h"
#import "DayModel.h"

@interface GNHotelViewController ()<CitySelectDelegate,DateSelectViewControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    UIView *viewCJ;
    UIWebView *phoneCallWebView;
}
@end

@implementation GNHotelViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self initNav:@"酒店"];
    [self createScreen];
    [self createCJView];
    
}

//创建国际的 view
- (void)createCJView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    viewCJ = [[UIView alloc] initWithFrame:CGRectMake(420 ,40,320,600)];
    viewCJ.backgroundColor = [JJDevice colorWithR:232 G:232 B:232 A:1];
    UIView *whiteBack = [[UIView alloc] initWithFrame:CGRectMake(20,20,280 ,100)];
    whiteBack.backgroundColor = [UIColor whiteColor];
    whiteBack.layer.borderColor = [UIColor clearColor].CGColor; //边框颜色
    whiteBack.layer.borderWidth = 1.0; //边框宽度
    whiteBack.layer.cornerRadius = 15.0;//圆角弯曲度
    UILabel *lbremind = [[UILabel alloc] initWithFrame:CGRectMake(20,5,130,20)];
    lbremind.text = @"国际酒店预订请致电";
    lbremind.font = [UIFont systemFontOfSize:14.0];
    [whiteBack addSubview:lbremind];
    
    UILabel *lbNumber = [[UILabel alloc] initWithFrame:CGRectMake(150,5,120,20)];
    
    NSMutableAttributedString *connet = [[NSMutableAttributedString alloc] initWithString:@"010-8454-9980"];
    NSRange range = {0, [connet length]};
    [connet addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    lbNumber.attributedText = connet;
    lbNumber.font = [UIFont systemFontOfSize:14.0];
    lbNumber.textColor = [JJDevice colorWithR:90 G:184 B:234 A:1];
    
    UIButton *buttonNumger = [[UIButton alloc] initWithFrame:CGRectMake(140,5,120,20)];
    [buttonNumger addTarget:self action:@selector(makeAPhone) forControlEvents:UIControlEventTouchUpInside];

    [whiteBack addSubview:lbNumber];
    [whiteBack addSubview:buttonNumger];
    
    UILabel *lbYDLC = [[UILabel alloc] initWithFrame:CGRectMake(20,25,200,20)];
    lbYDLC.text = @"预订流程:";
    lbYDLC.font = [UIFont systemFontOfSize:14.0];
    [whiteBack addSubview:lbYDLC];
    
    UILabel *lbLC = [[UILabel alloc] initWithFrame:CGRectMake(20,40,240,60)];
    lbLC.numberOfLines = 3;
    lbLC.font = [UIFont systemFontOfSize:14.0];
    lbLC.text = @"电话咨询->确认需求->客服后台生成订单->客人到个人中心完成支付、审批->完成预订";
    lbLC.textColor = [JJDevice colorWithR:248 G:126 B:0 A:1];
    [whiteBack addSubview:lbLC];
    
    [viewCJ addSubview:whiteBack];
    
    [self.view addSubview:viewCJ];
}

-(void)createScreen
{
    NSArray *array = @[@"国内", @"国际"];
    
    isChange = NO;
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*160, 0, 160, 40);
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"buttonBtn"] forState:UIControlStateNormal];
        button.tag = 100+i;
        [self.view addSubview:button];
        [button addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
        if (i==1) {
            [button setBackgroundImage:[UIImage imageNamed:@"buttonCN"] forState:UIControlStateNormal];
        }
    }
    
    
    CustomView *headView = [[CustomView alloc] initWithFrame:CGRectMake(0, 60, 320, 170)];
    [self.view addSubview:headView];
    
    NSArray *nameArray = @[@"目的城市", @"酒店名称", @"入住日期", @"退房日期", @"星级"];
    NSArray *imageArray = @[@"dcity", @"fz", @"cdate", @"cdate", @"star"];
    
    for (int i=0; i<5; i++) {
        UIImageView *imageView = nil;
        UILabel *ttLable = nil;
        if (i<2) {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, i*30+10, 13, 11)];
            ttLable = [[UILabel alloc] initWithFrame:CGRectMake(40, i*30, 60, 30)];
        }else if(i==4){
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, i*30+30, 13*4/3, 11*4/3)];
            ttLable = [[UILabel alloc] initWithFrame:CGRectMake(40, i*30+20, 60, 30)];
        }else{
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (i-2)*40+70, 13*4/3, 11*4/3)];
            ttLable = [[UILabel alloc] initWithFrame:CGRectMake(40, (i-2)*40+60, 60, 40)];
        }
       
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [headView addSubview:imageView];
        
        ttLable.backgroundColor = [UIColor clearColor];
        ttLable.text = [nameArray objectAtIndex:i];
        ttLable.textColor = [JJDevice colorWithR:100 G:100 B:100 A:1];
        ttLable.font = [UIFont systemFontOfSize:14];
        ttLable.textAlignment = NSTextAlignmentCenter;
        [headView addSubview:ttLable];
     
        if (i!=4) {
            UIImageView *lineView = nil;
            if (i<2) {
                lineView  = [[UIImageView alloc] initWithFrame:CGRectMake(40, 30+i*30, 280, 1)];
            }else{
                lineView  = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20+i*40, 280, 1)];
            }
            lineView.image = [UIImage imageNamed:@"xian"];
            [headView addSubview:lineView];
        }
    }
    
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *hotelDic = [defaults objectForKey:@"hotelDic"];
    
    _cityTF = [[UITextField alloc] initWithFrame:CGRectMake(110, 30, 160, 30)];
    _cityTF.borderStyle = UITextBorderStyleNone;
    _cityTF.textAlignment = NSTextAlignmentLeft;
    _cityTF.placeholder = @"输入你想查找的酒店名称";
    _cityTF.font = [UIFont systemFontOfSize:14];
    _cityTF.delegate = self;
    [headView addSubview:_cityTF];
  

    _cityBT = [[SelectTypeButton alloc] initWithFrame:CGRectMake(110, 0, 200, 30)];
    _cityBT.tag = 100;

    [_cityBT addTarget:self action:@selector(choseNum:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_cityBT];

    _starBT = [[SelectTypeButton alloc] initWithFrame:CGRectMake(110, 140, 200, 30)];
    _starBT.tag = 101;
    
    [_starBT addTarget:self action:@selector(choseNum:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:_starBT];
    
    
    
    _bookDateBT = [[CitySelectButton alloc] initWithFrame:CGRectMake(110, 60, 200, 40)];
    _bookDateBT.tag = 102;
    NSDate *nowdate = [NSDate date];
    DayModel *nowDayModel = [[DayModel alloc] init];
    [nowDayModel anayse:nowdate];
//    NSString *weekString = [JJDevice weekdayFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    _bookDateBT.yearLable.textColor = [JJDevice colorWithR:151 G:151 B:151 A:1];

    if([self getTDay:nowDayModel])
    {
        _bookDateBT.dateLable.text = [self getTDay:nowDayModel];
    }
    else{
        _bookDateBT.dateLable.text = nowDayModel.month_DayDespt;
    }
    _bookDateBT.yearLable.text = nowDayModel.year_weekdayDespt;
    
    [_bookDateBT addTarget:self action:@selector(choseNum:) forControlEvents:UIControlEventTouchUpInside];
    self.intakeDate = nowDayModel.description;
    [headView addSubview:_bookDateBT];

    _leavDateBT = [[CitySelectButton alloc] initWithFrame:CGRectMake(110, 100, 200, 40)];
    _leavDateBT.tag = 103;

    _leavDateBT.yearLable.textColor = [JJDevice colorWithR:151 G:151 B:151 A:1];
    NSDate *tomorrowDay = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    DayModel *tomorrowModel = [[DayModel alloc]init];
    [tomorrowModel anayse:tomorrowDay];

    if([self getTDay:tomorrowModel])
    {
        _leavDateBT.dateLable.text = [self getTDay:tomorrowModel];
    }
    else{
        _leavDateBT.dateLable.text = tomorrowModel.month_DayDespt;
    }
    _leavDateBT.yearLable.text = tomorrowModel.year_weekdayDespt;

    [_leavDateBT addTarget:self action:@selector(choseNum:) forControlEvents:UIControlEventTouchUpInside];
    self.outakeDate = tomorrowModel.description;
    [headView addSubview:_leavDateBT];
    
    
 
    
    
    UIButton *askButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [askButton setBackgroundImage:[UIImage imageNamed:@"chaxun"] forState:UIControlStateNormal];
    askButton.frame = CGRectMake(40, 280, 240, 40);
    askButton.layer.cornerRadius = 5;
    [askButton addTarget:self action:@selector(choseHotel) forControlEvents:UIControlEventTouchUpInside];
    askButton.layer.masksToBounds = YES;
    [self.view addSubview:askButton];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignField)];
    [self.view addGestureRecognizer:tap];
    

    if([hotelDic objectForKey:@"hotelName"])
    {
        _cityTF.text = [hotelDic objectForKey:@"hotelName"];
    }
    if([hotelDic objectForKey:@"cityName"])
    {
        _cityBT.typeLable.text = [hotelDic objectForKey:@"cityName"];
        
    }
    if([hotelDic objectForKey:@"cityCode"])
    {
        self.cityCode = [hotelDic objectForKey:@"cityCode"];
    }
    _starBT.typeLable.text = @"不限";

    
}

-(void)resignField
{
    [_cityTF resignFirstResponder];

}


-(void)choseHotel
{
    if(_cityBT.typeLable.text.length == 0 || _cityBT.typeLable.text == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"目的城市不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
    }
    else if(self.intakeDate == nil|| self.intakeDate.length == 0){
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"入住日期不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        
    }
    else if(self.outakeDate == nil|| self.outakeDate.length == 0)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"退房日期不能为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *hotelDic = [[NSMutableDictionary alloc] init];
        if(_cityBT.typeLable.text != nil || _cityBT.typeLable.text.length != 0)
        {
            [hotelDic setObject:_cityBT.typeLable.text forKey:@"cityName"];
          
        }
        if(_cityCode != nil && _cityCode.length != 0)
        {
            [hotelDic setObject:_cityCode forKey:@"cityCode"];
        }
        if(_cityTF.text != nil || _cityTF.text.length != 0)
        {
            [hotelDic setObject:_cityTF.text forKey:@"hotelName"];
        }else
        {
            [hotelDic setObject:@"" forKey:@"hotelName"];
        }
     
  
        [defaults setObject:hotelDic forKey:@"hotelDic"];
        NSString *hotelLevel= @"";
        if([_starBT.typeLable.text isEqualToString:@"五星"]){hotelLevel = @"5";}
        if([_starBT.typeLable.text isEqualToString:@"四星"]){hotelLevel = @"4";}
        if([_starBT.typeLable.text isEqualToString:@"三星"]){hotelLevel = @"3";}
        if([_starBT.typeLable.text isEqualToString:@"三星以下"]){hotelLevel = @"0";}
       
        SearchHotelViewController *sc = [[SearchHotelViewController alloc] init];
        sc.cityName = _cityBT.typeLable.text;
        sc.hotelName = _cityTF.text;
        sc.startDate = _intakeDate;
        sc.endDate = _outakeDate;
        sc.hotelLevel = hotelLevel;
        sc.cityCode = _cityCode;
        [self.navigationController pushViewController:sc animated:YES];
        
    }
}

-(void)choseNum:(UIButton *)button
{
    if(button.tag == 100)
    {
        CitySelectViewController *ctl = [[CitySelectViewController alloc]init];
        ctl.delegate = self;
        [self.navigationController pushViewController:ctl animated:YES];
    }
    if(button.tag == 101)
    {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"五星", @"四星", @"三星", @"三星以下",@"不限", nil];
        action.delegate = self;
        action.tag = 99;
        [action showInView:self.view];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:_intakeDate];
    DayModel *model = [[DayModel alloc]init];
    [model anayse:date];

    if(button.tag == 102)
    {
        DateSelectViewController *ctl = [[DateSelectViewController alloc]init];
        ctl.target = self;
        ctl.isStarting = YES;
        ctl.startDay = model;
        [self.navigationController pushViewController:ctl animated:YES];
    }
    if(button.tag == 103)
    {
        DateSelectViewController *ctl = [[DateSelectViewController alloc]init];
        ctl.target = self;
        ctl.isStarting = NO;
            ctl.startDay = model;
        [self.navigationController pushViewController:ctl animated:YES];
    }
}

-(void)changeImage:(UIButton *)button
{
    if (button.tag == 100) {
        [button setBackgroundImage:[UIImage imageNamed:@"buttonBtn"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        UIButton *buttontmp = (UIButton *)[self.view viewWithTag:101];
        [buttontmp setBackgroundImage:[UIImage imageNamed:@"buttonCN"] forState:UIControlStateNormal];
        [buttontmp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        isChange = NO;
        
        [UIView animateWithDuration:0.5 animations:^{
            viewCJ.frame = CGRectMake(420, 40, 320, 600);
        }];
        
    }else if (button.tag == 101){
        [button setBackgroundImage:[UIImage imageNamed:@"buttonBtn"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        UIButton *buttontmp = (UIButton *)[self.view viewWithTag:100];
        [buttontmp setBackgroundImage:[UIImage imageNamed:@"buttonCN"] forState:UIControlStateNormal];
        [buttontmp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        isChange = YES;
        
        [UIView animateWithDuration:0.5 animations:^{
            viewCJ.frame = CGRectMake(0, 40, 320, 600);
        }];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


#pragma mark SelectDelegate
-(void)selectCity:(NSString *)cityName andCityCode:(NSString *)cityCode
{
    _cityBT.typeLable.text = cityName;
    self.cityCode = cityCode;
}

-(void)changeDateStarting:(DayModel *)day
{


//    if([self getDayCount:day.description andEndDay:_outakeDate] < 0)
//    {
//        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"入住日期不能超过退房日期,请重新选择" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好", nil];
//        alt.tag = 1000;
//        alt.delegate = self;
//        [alt show];
//        return;
//        
//    }
    

    if([self getTDay:day])
    {
        _bookDateBT.dateLable.text = [self getTDay:day];
    }
    else{
        _bookDateBT.dateLable.text = day.month_DayDespt;
    }
    _bookDateBT.yearLable.text = day.year_weekdayDespt;
    self.intakeDate = day.description;
    

    
}
-(void)changeDateEnd:(DayModel *)day
{
    
    if([self getDayCount:_intakeDate andEndDay:day.description] < 0)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"入住日期不能超过退房日期,请重新选择" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好", nil];
        alt.tag = 1001;
        alt.delegate = self;
        [alt show];
        return;
        
    }
    
    if([self getTDay:day])
    {
            _leavDateBT.dateLable.text = [self getTDay:day];
    }
    else{
            _leavDateBT.dateLable.text = day.month_DayDespt;
    }

    _leavDateBT.yearLable.text = day.year_weekdayDespt;
    self.outakeDate = day.description;
    

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if(buttonIndex == 5)
    {
        return;
    }
    NSArray *arr = @[@"五星",@"四星",@"三星",@"三星以下",@"不限"];
    _starBT.typeLable.text = [arr objectAtIndex:buttonIndex];
}

- (void)makeAPhone
{
    NSString *phoneNum = @"01084549980";
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    if ( !phoneCallWebView ) {
        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的View 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
        [self.view addSubview:phoneCallWebView];
    }
    
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

//今天 明天 后天
-(NSString *)getTDay:(DayModel *)model
{

    if([self getNightcount:model.description] == 0)
    {
        return @"今天";
    }
    if([self getNightcount:model.description] == 1)
    {
        return @"明天";
    }
    if([self getNightcount:model.description] == 2)
    {
        return @"后天";
    }
    return nil;
    
}
//获取离今天间隔天数
-(NSInteger)getNightcount:(NSString*)dateStr
{
     NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *TodayDate = [NSDate date];
    DayModel *model = [[DayModel alloc]init];
    [model anayse:TodayDate];
    NSDate *date = [formatter dateFromString:model.description];
    NSDate *newTodayDate = [NSDate dateWithTimeInterval:8 * 3600 sinceDate:date];
    
    NSDate *date1 = [formatter dateFromString:dateStr];
    NSDate *newDate = [NSDate dateWithTimeInterval:8 * 3600 sinceDate:date1];
  
    NSTimeInterval time = [newDate timeIntervalSinceDate:newTodayDate];

    return  ((NSInteger)time)/(3600 * 24);
    
}

//获取选择的间隔天数
-(NSInteger)getDayCount:(NSString *)startDay andEndDay:(NSString *)endDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date1 = [formatter dateFromString:startDay];
    NSDate *date2 = [formatter dateFromString:endDay];
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    return  ((NSInteger)time)/(3600 * 24);
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:_intakeDate];
    DayModel *model = [[DayModel alloc]init];
    [model anayse:date];
    if(alertView.tag == 1000)
    {
        DateSelectViewController *vc = [[DateSelectViewController alloc]init];
        vc.target = self;
        vc.isStarting = YES;
        vc.startDay = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(alertView.tag == 1001)
    {
        DateSelectViewController *vc = [[DateSelectViewController alloc]init];
        vc.target = self;
        vc.isStarting = NO;
        vc.startDay = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(alertView.tag == 9)
    {
        if(buttonIndex == 1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:010-84549980"]];
        }
    }

}
-(void)playPhone
{
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"呼叫" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alt.tag = 9;
    alt.delegate = self;
    [alt show];
}
@end
