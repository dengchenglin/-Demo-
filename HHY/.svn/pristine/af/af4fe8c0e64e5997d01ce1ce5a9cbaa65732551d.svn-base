//
//  ChangeDateViewController.m
//  HHY
//
//  Created by jiangjun on 14-5-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "ChangeDateViewController.h"
#import "CustomView.h"

@interface ChangeDateViewController ()

@end

@implementation ChangeDateViewController

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
    self.view.backgroundColor = BG_COLRO;
    if (self.isHotel) {
        [self initNav:@"酒店改期"];
    }else{
        [self initNav:@"飞机改期"];
    }
    [self createScreen];
}

-(void)createScreen
{
    UILabel *headlable = [AffUIToolBar lableCgrectmake:CGRectMake(20, 0, 300, 30) lableNametext:@"填写改期申请"];
    headlable.textColor = [JJDevice colorWithR:114 G:114 B:114 A:1.0];
    headlable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:headlable];
    
    for (int i=0; i<2; i++) {
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29+i*91, 320, 1)];
        lineView.image = [UIImage imageNamed:@"xian"];
        [self.view addSubview:lineView];
    }
    self.headTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 30, 320, 90)];
    _headTextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headTextView];
    
    CustomView *view1 = [[CustomView alloc] initWithFrame:CGRectMake(0, 135, 320, 75)];
    [self.view addSubview:view1];
    
    if (self.isHotel) {
        [self.typeLable removeFromSuperview];
        self.nameLable = [AffUIToolBar lableCgrectmake:CGRectMake(20, 5.5, 300, 17) lableNametext:@"北京海淀亚螺旋酒店(保证入住)"];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        [view1 addSubview:_nameLable];
    }else{
        _nameLable = [AffUIToolBar lableCgrectmake:CGRectMake(20, 5.5, 70, 17) lableNametext:@"北京-上海"];
        _nameLable.textColor = [JJDevice colorWithR:150 G:150 B:150 A:1.0];
        _nameLable.font = [UIFont systemFontOfSize:14.0];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        [view1 addSubview:_nameLable];
        
        _typeLable = [AffUIToolBar lableCgrectmake:CGRectMake(90, 5.5, 50, 17) lableNametext:@"(单程)"];
        _typeLable.textColor = [JJDevice colorWithR:140 G:189 B:240 A:1.0];
        _typeLable.font = [UIFont systemFontOfSize:14.0];
        _typeLable.textAlignment = NSTextAlignmentLeft;
        [view1 addSubview:_typeLable];
    }
    UILabel *lable1 = [AffUIToolBar lableCgrectmake:CGRectMake(20, 22.5, 70, 17) lableNametext:@"订 单 号:"];
    lable1.font = [UIFont systemFontOfSize:14.0];
    lable1.textColor = [JJDevice colorWithR:150 G:150 B:150 A:1.0];
    lable1.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:lable1];
    
    _orderNumberLable = [AffUIToolBar lableCgrectmake:CGRectMake(90, 22.5, 200, 17) lableNametext:@"1234567890"];
    _orderNumberLable.textColor = [JJDevice colorWithR:150 G:150 B:150 A:1.0];
    _orderNumberLable.font = [UIFont systemFontOfSize:14.0];
    _orderNumberLable.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:_orderNumberLable];
    
    UILabel *lable2 = [AffUIToolBar lableCgrectmake:CGRectMake(20, 39.5, 70, 17) lableNametext:@""];
    lable2.textColor = [JJDevice colorWithR:150 G:150 B:150 A:1.0];
    if (self.isHotel) {
        lable2.text = @"入住时间:";
    }else{
        lable2.text = @"起飞时间:";
    }
    lable2.font = [UIFont systemFontOfSize:14.0];
    lable2.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:lable2];

    
    _startingLable = [AffUIToolBar lableCgrectmake:CGRectMake(90, 39.5, 200, 17) lableNametext:@"2014-4-30 19:30"];
    _startingLable.textColor = [JJDevice colorWithR:150 G:150 B:150 A:1.0];
    _startingLable.font = [UIFont systemFontOfSize:14.0];
    _startingLable.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:_startingLable];

    UILabel *lable3 = [AffUIToolBar lableCgrectmake:CGRectMake(20, 56.5, 70, 17) lableNametext:@"订单总额:"];
    lable3.font = [UIFont systemFontOfSize:14.0];
    lable3.textColor = [JJDevice colorWithR:150 G:150 B:150 A:1.0];
    lable3.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:lable3];
    
    _priceLable = [AffUIToolBar lableCgrectmake:CGRectMake(90, 56.5, 200, 17) lableNametext:@"¥ 2356"];
    _priceLable.textColor = [JJDevice colorWithR:219 G:126 B:0 A:1.0];
    _priceLable.font = [UIFont systemFontOfSize:14.0];
    _priceLable.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:_priceLable];
    
    CustomView *view2 = [[CustomView alloc] initWithFrame:CGRectMake(0, 230, 320, 80)];
    [self.view addSubview:view2];
    
    for (int i=0; i<2; i++) {
        UIImageView *linetemp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xian"]];
        linetemp.frame = CGRectMake(0, 30+i*25, 320, 1);
        [view2 addSubview:linetemp];
    }
    
    UILabel *lable4 = [AffUIToolBar lableCgrectmake:CGRectMake(20, 0, 200, 30) lableNametext:@"联系人信息"];
    lable4.textAlignment = NSTextAlignmentLeft;
    [view2 addSubview:lable4];
    
    UILabel *namelable = [AffUIToolBar lableCgrectmake:CGRectMake(20, 30, 50, 25) lableNametext:@"姓名"];
    namelable.textAlignment = NSTextAlignmentLeft;
    namelable.font = [UIFont systemFontOfSize:14];
    namelable.textColor = [JJDevice colorWithR:112 G:112 B:112 A:1.0];
    [view2 addSubview:namelable];
    
    UILabel *phoneLable = [AffUIToolBar lableCgrectmake:CGRectMake(20, 55, 50, 25) lableNametext:@"手机"];
    phoneLable.textAlignment = NSTextAlignmentLeft;
    phoneLable.font = [UIFont systemFontOfSize:14];
    phoneLable.textColor = [JJDevice colorWithR:112 G:112 B:112 A:1.0];
    [view2 addSubview:phoneLable];
    
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(70, 30, 200, 25)];
    _nameTF.delegate = self;
    _nameTF.placeholder = @"请输入姓名";
    _nameTF.borderStyle = UITextBorderStyleNone;
    [view2 addSubview:_nameTF];
    
    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(70, 55, 200, 25)];
    _phoneTF.delegate = self;
    _phoneTF.borderStyle = UITextBorderStyleNone;
    [view2 addSubview:_phoneTF];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameTF resignFirstResponder];
    [self.phoneTF resignFirstResponder];
    return YES;
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
