//
//  AirReturnViewController.m
//  HHY
//
//  Created by jiangjun on 14-6-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "AirReturnViewController.h"
#import "PassangerCell.h"
#import "LinkPeopleCell.h"
#import "changeDatePassengerCell.h"
#import "OrderInfoCell.h"
#import "AirOrderModel.h"
#import "AirReturnTicketCell.h"
#import "TicketPayViewController.h"

@interface AirReturnViewController ()
{
    NSDictionary *infoDic;
    
    UILabel *OrderPricelable;
    UILabel *tuiPricelable;
    
    float allPrice;
    float tuiPrice;
    
    
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

@implementation AirReturnViewController
@synthesize airModel = _airModel;

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
    [self initNav:@"改期单"];
    [self createScreen];
    
    [self createTuiGaiRuleView];
    
    allPrice = 0;
    [self getLoadData];
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
    
    [self ruleOK:nil];
}

-(void)getLoadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"orderNum = %@", self.airModel.orderNumber);
    [[HHYNetworkEngine sharedInstance] queryOrderDetail:self.airModel.orderNumber block:^(NSError *error, id data) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (!error) {
            if ([data isKindOfClass:[NSDictionary class]]) {
                infoDic = [[NSDictionary alloc] initWithDictionary:data];
                
                for (int i=0; i<[[infoDic objectForKey:@"flightDetailVO"] count]; i++) {
                    //
                    float tgFee = [[[[infoDic objectForKey:@"flightDetailVO"] objectAtIndex:i] objectForKey:@"tpFee"] floatValue];
                    allPrice += tgFee;
                    float tuiFee = [[[[infoDic objectForKey:@"flightDetailVO"] objectAtIndex:i] objectForKey:@"farePrice"] floatValue];
                    tuiPrice += tuiFee;
                }
                OrderPricelable .text = [NSString stringWithFormat:@"退票费: ¥%.2f", allPrice];
                tuiPricelable.text = [NSString stringWithFormat:@"实退金额: ¥%.2f", tuiPrice];
            }
            
            [_tableView reloadData];
        }
    }];
}


-(void)createScreen
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (iPhone5) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 324, 568-64-45) style:UITableViewStyleGrouped];
    }else{
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 324, 480-64-45) style:UITableViewStyleGrouped];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self creatBottom];
}

- (void)creatBottom
{
    UIView *view = [[UIView alloc] init];
    view.userInteractionEnabled = YES;
    view.backgroundColor = [JJDevice colorWithR:224 G:137 B:34 A:1];
    if (iPhone5) {
        view.frame = CGRectMake(0, 568-64-50, 320, 50);
    }else{
        view.frame = CGRectMake(0, 480-64-50, 320, 50);
    }
    [self.view addSubview:view];
    NSArray *array = @[@"同意"];
    
    for (int i=0; i<1; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tuiding"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tuidingBTN"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 2000+i;
        button.frame = CGRectMake(200+60, 5, 50, 40);
        
        [view addSubview:button];
    }
    OrderPricelable= [AffUIToolBar lableCgrectmake:CGRectMake(20, 5, 170, 20) lableNametext:[NSString stringWithFormat:@"退票费: ¥%@", @""]];
    OrderPricelable.font = FONT_14;
    tuiPricelable= [AffUIToolBar lableCgrectmake:CGRectMake(20, 25, 170, 20) lableNametext:[NSString stringWithFormat:@"实退金额: ¥%@", @""]];
    tuiPricelable.font = FONT_14;
    OrderPricelable.textAlignment = NSTextAlignmentLeft;
    OrderPricelable.textColor = [UIColor whiteColor];
    tuiPricelable.textAlignment = NSTextAlignmentLeft;
    tuiPricelable.textColor = [UIColor whiteColor];
    [view addSubview:OrderPricelable];
    [view addSubview:tuiPricelable];
    [self.view addSubview:view];
}



-(void)createRighteItem
{
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(232, 0, 30, 44);
    [phoneButton setImage:[UIImage imageNamed:@"playPhone"]forState:UIControlStateNormal];
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


- (void)btnClick:(UIButton *)sender
{
    //同意
    
    
    /*
    //跳支付
    TicketPayViewController *theView = [[TicketPayViewController alloc] init];
    theView.orderNum = self.airModel.orderNumber;
    theView.allCount = allPrice;
    theView.detailInfo = infoDic;
    [self.navigationController pushViewController:theView animated:YES];*/
}

#pragma tableViewDataSource

#pragma tableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *array = @[@"订单信息", @"航班信息", @"乘机人信息",@"联系人信息"];

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 20)];
        lable.text = [array objectAtIndex:section];
        lable.font = FONT_14;
        [view addSubview:lable];
        return view;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int se = 1;
    if (section==1) {
        NSArray *array = [infoDic objectForKey:@"flightDetailVO"];
        se  =[array count];
    } else if (section==2) {
        NSArray *array = [infoDic objectForKey:@"passengerDetailVO"];
        se = [array count];
    }
    return se;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    if (indexPath.section == 0) {
        OrderInfoCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderInfoCell" owner:nil options:nil] lastObject];
        }
        
        NSString *stateName = [JJDevice orderState:self.airModel.ticketState];
        cell.orderState . text = stateName;
        cell.payType.hidden = YES;
        cell.orderNum.text = self.airModel.orderNumber;
        cell.orderNum.font = FONT_12;
        cell.bookTime .text = self.airModel.addTime;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==1){
        AirReturnTicketCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AirReturnTicketCell" owner:nil options:nil] lastObject];
        }
        
        NSArray *array = [infoDic objectForKey:@"flightDetailVO"];
        NSString *date = [[array objectAtIndex:indexPath.row] objectForKey:@"departureDate"];
        date = [date substringToIndex:date.length-8];
        
        cell.startDate.text = date;
        
        NSString *terminal = [[array objectAtIndex:indexPath.row] objectForKey:@"terminal"];
        NSString *startT = [terminal substringToIndex:2];
        NSString *endT = [terminal substringFromIndex:[terminal length]-2];
        
        cell.placeLable.text = [NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:indexPath.row] objectForKey:@"orgCityCN"],[[array objectAtIndex:indexPath.row] objectForKey:@"desCityCN"]];
        cell.startTime.text = [[array objectAtIndex:indexPath.row] objectForKey:@"departureTime"];
        cell.startPlace.text = [NSString stringWithFormat:@"%@%@",[[array objectAtIndex:indexPath.row] objectForKey:@"orgCity"],startT];
        cell.endPlace.text = [NSString stringWithFormat:@"%@%@", [[array objectAtIndex:indexPath.row] objectForKey:@"desCity"],endT];
        
        cell.tuiGaiGuiDing.tag = 2000 +indexPath.row;
        [cell.tuiGaiGuiDing addTarget:self action:@selector(TGGD:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *cw;
        if ([[[array objectAtIndex:indexPath.row] objectForKey:@"cabin"] isEqualToString:@"Y"]) {
            cw = @"经济舱";
        }else if([[[array objectAtIndex:indexPath.row] objectForKey:@"cabin"] isEqualToString:@"C"]){
           cw = @"商务舱";
        }else{
            cw = @"头等舱";
        }
        
        
        cell.airTypeLable.text = [NSString stringWithFormat:@"%@  %@  %@  %@", [[array objectAtIndex:indexPath.row] objectForKey:@"airWayName"],[[array objectAtIndex:indexPath.row] objectForKey:@"flightnumber"],cw,[[array objectAtIndex:indexPath.row] objectForKey:@"model"]];
        cell.pricelable.text = [NSString stringWithFormat:@"￥%@",[[array objectAtIndex:indexPath.row] objectForKey:@"publishedPrice"]];
        NSString *tax =[[array objectAtIndex:indexPath.row] objectForKey:@"tax"];
        cell.suiPriceLable.text = [tax stringByReplacingOccurrencesOfString:@"-" withString:@"￥"];
        cell.returnPrice.font = FONT_14;
        cell.returnPrice.text = [NSString stringWithFormat:@"退票费￥%@",[[array objectAtIndex:indexPath.row] objectForKey:@"tpFee"]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2) {
        PassangerCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PassangerCell" owner:nil options:nil] lastObject];
            [cell chushihua];
        }
        NSArray *array = [infoDic objectForKey:@"passengerDetailVO"];
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        cell.nameText.text = [dic objectForKey:@"name"];
        cell.shenfengzhen.text = @"保    险";
        cell.sfzText.text = [NSString stringWithFormat:@"航空意外险 %@份,共%@元",[dic objectForKey:@"insurance"],[dic objectForKey:@"sn"]];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        LinkPeopleCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LinkPeopleCell" owner:nil options:nil] lastObject];
        }
        
        NSString *contact = [infoDic objectForKey:@"contactName"];
        NSString *phone = [infoDic objectForKey:@"mobile"];
        NSString *email = [infoDic objectForKey:@"email"];
        cell.nameTF.text = contact;
        cell.phoneTF.text = phone;
        cell.emainTF.text = email;
        cell.nameTF.enabled = NO;
        cell.phoneTF.enabled = NO;
        cell.emainTF.enabled = NO;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)TGGD:(UIButton *)sender
{
    int index = sender.tag - 2000;
    NSArray *array = [infoDic objectForKey:@"flightDetailVO"];
    NSDictionary *info = [array objectAtIndex:index];
    NSString *cangWei = [info objectForKey:@"cabin"];
    
    if (!tgIsLOAD) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[HHYNetworkEngine sharedInstance] tgqrule:@"" andSpace:cangWei block:^(NSError *error, id data) {
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

- (void)ruleOK:(UIButton *)sender {
    [self TGDisAppear];
}

#pragma tableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50.0f;
    }else if (indexPath.section == 1){
        return 150.0f;
    }else if (indexPath.section == 2){
        return 50.0f;
    }else if (indexPath.section == 3){
        return 90.0f;
    }
    return 0;
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
