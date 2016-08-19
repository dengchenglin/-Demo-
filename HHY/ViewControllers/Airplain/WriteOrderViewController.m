//
//  WriteOrderViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-30.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "WriteOrderViewController.h"
#import "CustomView.h"
#import "DayModel.h"
#import "TicketModel.h"
#import "OrderPriceCell.h"
#import "AddPlainRangeViewController.h"
#import "TicketAndDayModel.h"
#import "TitcketViewController.h"
#import "LoginViewController.h"


@interface WriteOrderViewController ()
{
    UIView *TGView;
    BOOL tgIsLOAD;
    
    UIView *tuiGaiRuleView;
    UILabel *lbGai;
    UILabel *lbConentOfGai;
    UILabel *lbTui;
    UILabel *lbTuiRule;
    
    UIButton *btOK;
}

@end

@implementation WriteOrderViewController

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNav:self.start_endPoint];
    [self createScreen];
    
    [self createTuiGaiRuleView];
    [self TGDisAppear];
}

- (void)createTuiGaiRuleView
{
    TGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    TGView.backgroundColor = [UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:0.6];
    lbGai = [[UILabel alloc] initWithFrame:CGRectMake(58, 108, 30, 20)];
    lbConentOfGai = [[UILabel alloc] initWithFrame:CGRectMake(50+40, 8+100, 170, 110)];
    lbTui = [[UILabel alloc] initWithFrame:CGRectMake(58, 220, 30, 20)];
    lbTuiRule = [[UILabel alloc] initWithFrame:CGRectMake(90, 220, 170, 100)];
    btOK = [[UIButton alloc] initWithFrame:CGRectMake(70, 335, 180, 30)];
    [btOK addTarget:self action:@selector(ruleOK:) forControlEvents:UIControlEventTouchUpInside];
    [btOK setTitle:@"确定" forState:0];
    
    lbTui.textColor = [UIColor orangeColor];
    lbGai.textColor = [UIColor orangeColor];
    lbTuiRule.textColor = [UIColor grayColor];
    lbConentOfGai.textColor = [UIColor grayColor];
    btOK .backgroundColor = [JJDevice colorWithR:247 G:114 B:18 A:1.0];
    [btOK setTitleColor:[UIColor whiteColor] forState:0];
    
    UIFont *font13 = [UIFont systemFontOfSize:13.0];
    lbTui.font = font13;
    lbGai.font = font13;
    lbTuiRule.font = font13;
    lbConentOfGai.font = font13;
    
    lbTui.text = @"退票:";
    lbGai.text = @"改期:";
    lbConentOfGai.numberOfLines = 0;
    lbTuiRule.numberOfLines = 0;
    
    tuiGaiRuleView = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 220, 270)];
    tuiGaiRuleView.backgroundColor = [UIColor whiteColor];
    tuiGaiRuleView.layer.borderColor = [UIColor lightGrayColor].CGColor; //边框颜色
    tuiGaiRuleView.layer.borderWidth = 5.0; //边框宽度
    tuiGaiRuleView.layer.cornerRadius = 5.0;//圆角弯曲度
    
    [TGView addSubview:tuiGaiRuleView];
    
    [TGView addSubview:lbTui];
    [TGView addSubview:lbTuiRule];
    [TGView addSubview:lbGai];
    [TGView addSubview:lbConentOfGai];
    [TGView addSubview:btOK];
    
    [self.view addSubview:TGView];
}

- (void)TGDisAppear
{
    [UIView animateWithDuration:0.3 animations:^{
        tuiGaiRuleView.alpha = 0.0;
        TGView.alpha = 0.0;
        lbConentOfGai.alpha = 0.0;
        lbGai.alpha = 0.0;
        lbTui.alpha = 0.0;
        lbTuiRule.alpha = 0.0;
        btOK.alpha = 0.0;
    }];
}

- (void)TGAppear
{
    [UIView animateWithDuration:0.3 animations:^{
        tuiGaiRuleView.alpha = 1.0;
        TGView.alpha = 1.0;
        lbConentOfGai.alpha = 1.0;
        lbGai.alpha = 1.0;
        lbTui.alpha = 1.0;
        lbTuiRule.alpha = 1.0;
        btOK.alpha = 1.0;
    }];
}

-(void)createRighteItem
{
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(232, 0, 30, 44);
    [phoneButton setImage:[UIImage imageNamed:@"playPhone"]forState:UIControlStateNormal];
    [phoneButton addTarget:self action:@selector(playPhone) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *tempItem = [[UIBarButtonItem alloc] initWithCustomView:phoneButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(276, 0, 30, 44);
    [rightButton setImage:[UIImage imageNamed:@"fhsy"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(returnRoot) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *flexright = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    [flexright setWidth:5];
    self.navigationItem.rightBarButtonItems = @[rightItem, flexright, tempItem];
}



-(void)createScreen
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, 320, 100)];
    [self.view addSubview:view1];
    
    NSArray *weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    UILabel *dateLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
    NSLog(@"%@",self.dateModel.weekDay);
    dateLable.text = [NSString stringWithFormat:@"%@ 星期%@", self.dateModel.month_DayDespt, [weekArray objectAtIndex:[self.dateModel.weekDay intValue]]];
    dateLable.font = FONT_12;
    dateLable.textColor = [JJDevice colorWithR:99 G:99 B:99 A:1];
    [view1 addSubview:dateLable];
    
    UILabel *lable = [AffUIToolBar lableCgrectmake:CGRectMake(120, 0, 120, 30) lableNametext:[NSString stringWithFormat:@"%@%@%@", self.currentModel.airLineName, self.currentModel.airLineCode, self.currentModel.fltNo]];
    lable.font = FONT_14;
    lable.textColor = [JJDevice colorWithR:99 G:99 B:99 A:1];
    lable.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:lable];
    
    UILabel *lable1 = [AffUIToolBar lableCgrectmake:CGRectMake(240, 0, 60, 30) lableNametext:[NSString stringWithFormat:@"机型%@", self.currentModel.planeModel]];
    lable1.font = FONT_14;
    lable1.textColor = [JJDevice colorWithR:99 G:99 B:99 A:1];
    [view1 addSubview:lable1];
    
    _startPlaceLable = [AffUIToolBar lableCgrectmake:CGRectMake(20, 35, 100, 30) lableNametext:[NSString stringWithFormat:@"%@ %@", self.currentModel.adepName, self.currentModel.arriveTerminal]];
    _startPlaceLable.textAlignment = NSTextAlignmentLeft;
    _startPlaceLable.textColor = [UIColor grayColor];
    [view1 addSubview:_startPlaceLable];
    
    _endPlaceLable = [AffUIToolBar lableCgrectmake:CGRectMake(180, 35, 120, 30) lableNametext:[NSString stringWithFormat:@"%@ %@", self.currentModel.destName, self.currentModel.departTerminal]];
    _endPlaceLable.textColor = [UIColor grayColor];
    _endPlaceLable.textAlignment = NSTextAlignmentRight;
    [view1 addSubview:_endPlaceLable];
    
    _startingtimeLable = [AffUIToolBar lableCgrectmake:CGRectMake(20, 60, 80, 35) lableNametext:self.currentModel.flyTime];
    _startingtimeLable.textAlignment = NSTextAlignmentLeft;
    _startingtimeLable.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    [view1 addSubview:_startingtimeLable];
    
    _endingtimeLable = [AffUIToolBar lableCgrectmake:CGRectMake(220, 60, 80, 35) lableNametext:self.currentModel.arriveTime];
    _endingtimeLable.textAlignment = NSTextAlignmentRight;
    _endingtimeLable.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    [view1 addSubview:_endingtimeLable];
    
    UIImageView *imageView = [AffUIToolBar imageviewRect:CGRectMake(130, 40, 60, 30) andimage:[UIImage imageNamed:@"feiji"]];
    [view1 addSubview:imageView];
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 91, 320, 1)];
    lineView.backgroundColor = [JJDevice colorWithR:109 G:183 B:230 A:1];
    [self.view addSubview:lineView];
    
    
    if (iPhone5) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 92, 320, 568-93-64) style:UITableViewStylePlain];
    }else{
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 92, 320, 480-93-64) style:UITableViewStylePlain];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentModel.spaceAndPrice.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    OrderPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[OrderPriceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dict = [self.currentModel.spaceAndPrice objectAtIndex:indexPath.row];
    float tempf = [[dict objectForKey:@"disAmt"] floatValue]/[[self.currentModel.maxPrice objectForKey:@"disAmt"] floatValue]*10;
    if ([self.shippingspaceType isEqualToString:@"Y"]) {
        if (tempf==10) {
            cell.typeLable.text = @"经济舱全价";
        }else
            cell.typeLable.text =[NSString stringWithFormat:@"%@%.1f折", @"经济舱", tempf];
        
    }else if([self.shippingspaceType isEqualToString:@"C"]){
        if (tempf==10) {
            cell.typeLable.text = @"商务舱全价";
        }else
            cell.typeLable.text =[NSString stringWithFormat:@"%@%.1f折", @"商务舱", tempf];
    }else{
        if (tempf==10) {
            cell.typeLable.text = @"头等舱全价";
        }else
            cell.typeLable.text =[NSString stringWithFormat:@"%@%.1f折", @"头等舱", tempf];
    }
    
    cell.priceLable.text = [NSString stringWithFormat:@"¥ %@", [dict objectForKey:@"disAmt"]];
    if ([dict objectForKey:@"ticket"] || [[dict objectForKey:@"ticket"] isEqualToString:@""]) {
        if ([[dict objectForKey:@"ticket"] isKindOfClass:[NSString class]]&&[[dict objectForKey:@"ticket"] isEqualToString:@"A"]) {
            cell.countLable.text = @">9张";
        }else{
            cell.countLable.text = [NSString stringWithFormat:@"%@张", [dict objectForKey:@"ticket"]];
        }
    }
    
    cell.tuigaiguidingBT.tag = indexPath.row + 10000;
    [cell.tuigaiguidingBT addTarget:self action:@selector(shuoming:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.bookButton.tag = indexPath.row+1000;
    [cell.bookButton addTarget:self action:@selector(selectTheTk:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

-(void)selectTheTk:(UIButton *)button
{
    
    if ([[LoginModel shareInstace] getIsWangfan]) {
        if ([[LoginModel shareInstace] getISSelectTicket]) {
            AddPlainRangeViewController *avc = [[AddPlainRangeViewController alloc] init];
            TicketAndDayModel *tdmodel = [[TicketAndDayModel alloc] init];
            tdmodel.dayModel = self.dateModel;
            tdmodel.ticketModel = self.currentModel;
            tdmodel.shipType = self.shippingspaceType;
            tdmodel.palceText = self.start_endPoint;
            tdmodel.dictAmi = [self.currentModel.spaceAndPrice objectAtIndex:button.tag-1000];
            [[LoginModel shareInstace] addOneRange:tdmodel];
            NSArray *array = [[LoginModel shareInstace] getRangeArray];
            for (TicketAndDayModel *model in array) {
                [avc addOneAirPlain:model];
            }
            
            [[LoginModel shareInstace] setWangfan:NO];
            [[LoginModel shareInstace] removeAllRange];
            [[LoginModel shareInstace] setIsSelectTicket:NO];//选择往返后 将选择设置为初始值
            [self.navigationController pushViewController:avc animated:YES];
        }else{
            TitcketViewController *tvc = [[TitcketViewController alloc] init];
            tvc.ticketURL = [[LoginModel shareInstace] getWangfanURL];
            TicketAndDayModel *tdmodel = [[TicketAndDayModel alloc] init];
            tdmodel.dayModel = self.dateModel;
            tdmodel.ticketModel = self.currentModel;
            tdmodel.shipType = self.shippingspaceType;
            tdmodel.palceText = self.start_endPoint;
            tdmodel.dictAmi = [self.currentModel.spaceAndPrice objectAtIndex:button.tag-1000];
            [[LoginModel shareInstace] addOneRange:tdmodel];
            [[LoginModel shareInstace] setIsSelectTicket:YES];//将往返里面的选择属性改称已经选择了
            tvc.dateString = [[LoginModel shareInstace] getDateString];
            tvc.start_endPoint = [[LoginModel shareInstace] getStartEndPoint];
            tvc.dateModel = [[LoginModel shareInstace] getDateModel];
            tvc.shippingspaceType = [[LoginModel shareInstace] getshippingspaceType];
            [self.navigationController pushViewController:tvc animated:YES];
        }
    }else{
        if ([[HHYNetworkEngine sharedInstance] checkLogin]) {
            AddPlainRangeViewController *avc = [[AddPlainRangeViewController alloc] init];
            TicketAndDayModel *tdmodel = [[TicketAndDayModel alloc] init];
            tdmodel.dayModel = self.dateModel;
            tdmodel.ticketModel = self.currentModel;
            tdmodel.shipType = self.shippingspaceType;
            tdmodel.palceText = self.start_endPoint;
            tdmodel.dictAmi = [self.currentModel.spaceAndPrice objectAtIndex:button.tag-1000];
            if ([[LoginModel shareInstace] getOrderTicketState]) {
                [avc removeAllArray];
            }
            [avc addOneAirPlain:tdmodel];
            [self.navigationController pushViewController:avc animated:YES];
        }else{
            LoginViewController *lvc = [[LoginViewController alloc] init];
            UINavigationController *lnc = [[UINavigationController alloc] initWithRootViewController:lvc];
            lvc.isDismiss = YES;
            [self presentViewController:lnc animated:YES completion:nil];
        }
    }
}

-(void)shuoming:(UIButton *)button
{
    if (!tgIsLOAD) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[HHYNetworkEngine sharedInstance] tgqrule:self.currentModel.airLineCode andSpace:self.shippingspaceType block:^(NSError *error, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!error) {
                NSDictionary *dict = [data objectAtIndex:0];
//                [Utils alertWithTitle:[dict objectForKey:@"tp"] message:[dict objectForKey:@"gq"]];
                lbConentOfGai.text = [dict objectForKey:@"gq"];
                lbTuiRule.text = [dict objectForKey:@"tp"];
                
                [self TGAppear];
                tgIsLOAD = YES;
            }
        }];
    } else {
        [self TGAppear];
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

- (void)ruleOK:(UIButton *)sender {
    [self TGDisAppear];
}
@end
