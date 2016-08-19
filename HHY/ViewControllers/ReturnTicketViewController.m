//
//  ReturnTicketViewController.m
//  HHY
//
//  Created by jiangjun on 14-5-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "ReturnTicketViewController.h"
#import "CustomView.h"

@interface ReturnTicketViewController ()

@end

@implementation ReturnTicketViewController

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
        [self initNav:@"退订"];
    }else{
        [self initNav:@"退票"];
    }
    [self createScreen];
}

-(void)createScreen
{
    CustomView *view1 = [[CustomView alloc] initWithFrame:CGRectMake(0, 20, 320, 110)];
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
    
    
    UILabel *lableStata = [AffUIToolBar lableCgrectmake:CGRectMake(270, 6, 50, 15) lableNametext:@"已支付"];
    lableStata.textAlignment = NSTextAlignmentCenter;
    lableStata.textColor = [UIColor whiteColor];
    lableStata.font = [UIFont systemFontOfSize:12];
    lableStata.backgroundColor = [JJDevice colorWithR:191 G:191 B:191 A:1];
    [view1 addSubview:lableStata];
    
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
    
    NSArray *colorArray = @[[JJDevice colorWithR:99 G:147 B:218 A:1], [JJDevice colorWithR:226 G:134 B:39 A:1]];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(160+i*80, 80, 60, 20);
        [button setBackgroundColor:[colorArray objectAtIndex:i]];
        if (i==0) {
            if (self.isHotel) {
                [button setTitle:@"退订" forState:UIControlStateNormal];
            }else{
                [button setTitle:@"退票" forState:UIControlStateNormal];
            }
            [button setBackgroundImage:[UIImage imageNamed:@"tuiding"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"tuidingBTN"] forState:UIControlStateHighlighted];
        }else{
            [button setTitle:@"改期" forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"gaiqi"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"gaiqiBTN"] forState:UIControlStateHighlighted];
        }
        button.tag = 100+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:button];
    }
    
    _detailLable = [AffUIToolBar lableCgrectmake:CGRectMake(10, 135, 300, 40) lableNametext:@"注:退票应尽量提前申请,否则退票手续费会大大增加.退票\n原则参考:(连接较详细的说明)"];
    _detailLable.numberOfLines = 2;
    _detailLable.textAlignment = NSTextAlignmentLeft;
    _detailLable.font = [UIFont systemFontOfSize:12.0];
    _detailLable.textColor = [JJDevice colorWithR:190 G:190 B:190 A:1];
    [self.view addSubview:_detailLable];

}

-(void)addOrderLable
{
    self.detailLable.frame = CGRectMake(10, 265, 300, 40);
    _orderView = [[CustomView alloc] initWithFrame:CGRectMake(0, 150, 320, 110)];
    [self.view addSubview:_orderView];
    
    UIImageView *lineView = [AffUIToolBar imageviewRect:CGRectMake(0, 29, 320, 1) andimage:[UIImage imageNamed:@"xian"]];
    [_orderView addSubview:lineView];
    
    UILabel *lable = [AffUIToolBar lableCgrectmake:CGRectMake(20, 2, 60, 20) lableNametext:@"退票订单"];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.font = [UIFont systemFontOfSize:10];
    [_orderView addSubview:lable];
    
    UILabel *lable1 = [AffUIToolBar lableCgrectmake:CGRectMake(20, 40, 70, 20) lableNametext:@"原始订单:"];
    lable1.textColor = [JJDevice colorWithR:144 G:144 B:144 A:1];
    lable1.textAlignment = NSTextAlignmentLeft;
    lable1.font = [UIFont systemFontOfSize:12];
    [_orderView addSubview:lable1];
    
    _yuanshiOrder = [AffUIToolBar lableCgrectmake:CGRectMake(90, 40, 100, 20) lableNametext:@"1111111111"];
    _yuanshiOrder.textColor = [JJDevice colorWithR:144 G:144 B:144 A:1];
    _yuanshiOrder.textAlignment = NSTextAlignmentLeft;
    _yuanshiOrder.font = [UIFont systemFontOfSize:12];
    [_orderView addSubview:_yuanshiOrder];
    
    UILabel *lableStata = [AffUIToolBar lableCgrectmake:CGRectMake(270, 34, 50, 15) lableNametext:@"已退票"];
    lableStata.textAlignment = NSTextAlignmentCenter;
    lableStata.textColor = [UIColor whiteColor];
    lableStata.font = [UIFont systemFontOfSize:12];
    lableStata.backgroundColor = [JJDevice colorWithR:191 G:191 B:191 A:1];
    [_orderView addSubview:lableStata];
    
    UILabel *lable2 = [AffUIToolBar lableCgrectmake:CGRectMake(20, 60, 35, 20) lableNametext:@"应退:"];
    lable2.textColor = [JJDevice colorWithR:144 G:144 B:144 A:1];
    lable2.font = FONT_12;
    lable2.textAlignment = NSTextAlignmentLeft;
    [_orderView addSubview:lable2];
    
    _shouldReturn = [AffUIToolBar lableCgrectmake:CGRectMake(55, 60, 40, 20) lableNametext:@"¥ 3980"];
    _shouldReturn.font = FONT_12;
    _shouldReturn.textColor = [JJDevice colorWithR:144 G:144 B:144 A:1];
    [_orderView addSubview:_shouldReturn];
    
    UILabel *lable3 = [AffUIToolBar lableCgrectmake:CGRectMake(105, 60, 35, 20) lableNametext:@"扣除:"];
    lable3.textColor = [JJDevice colorWithR:144 G:144 B:144 A:1];
    lable3.font = FONT_12;
    lable3.textAlignment = NSTextAlignmentLeft;
    [_orderView addSubview:lable3];
    
    _kouchuLable = [AffUIToolBar lableCgrectmake:CGRectMake(140, 60, 40, 20) lableNametext:@"¥ 380"];
    _kouchuLable.font = FONT_12;
    lable2.textAlignment = NSTextAlignmentLeft;
    _kouchuLable.textColor = [JJDevice colorWithR:144 G:144 B:144 A:1];
    [_orderView addSubview:_kouchuLable];
    
    UILabel *lable4 = [AffUIToolBar lableCgrectmake:CGRectMake(190, 60, 35, 20) lableNametext:@"实退:"];
    lable4.textColor = [JJDevice colorWithR:100 G:148 B:218 A:1];
    lable4.font = FONT_12;
    lable4.textAlignment = NSTextAlignmentLeft;
    [_orderView addSubview:lable4];
    
    _reallyReturn = [AffUIToolBar lableCgrectmake:CGRectMake(225, 60, 40, 20) lableNametext:@"¥ 3980"];
    _reallyReturn.font = FONT_12;
    lable2.textAlignment = NSTextAlignmentLeft;
    _reallyReturn.textColor = [JJDevice colorWithR:100 G:148 B:218 A:1];
    [_orderView addSubview:_reallyReturn];
    
    
    NSArray *colorArray = @[[JJDevice colorWithR:99 G:147 B:218 A:1], [JJDevice colorWithR:226 G:134 B:39 A:1]];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(160+i*80, 85, 60, 20);
        [button setBackgroundColor:[colorArray objectAtIndex:i]];
        if (i==0) {
            [button setTitle:@"同意" forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"tuiding"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"tuidingBTN"] forState:UIControlStateHighlighted];
        }else{
            [button setTitle:@"不同意" forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"gaiqi"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"gaiqiBTN"] forState:UIControlStateHighlighted];
        }
        button.tag = 102+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_orderView addSubview:button];
    }
}

-(void)btnClick:(UIButton *)button
{
    if (button.tag == 100) {
        [self addOrderLable];
    }
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
