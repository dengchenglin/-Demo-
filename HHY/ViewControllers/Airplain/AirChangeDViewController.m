//
//  AirChangeDViewController.m
//  HHY
//
//  Created by 兵 张 on 14/12/17.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "AirChangeDViewController.h"
#import "TicketPayViewController.h"
#import "PassangerCell.h"
#import "LinkPeopleCell.h"
#import "changeDatePassengerCell.h"
#import "OrderInfoCell.h"
#import "AirOrderModel.h"
#import "AirChangeDCell.h"

@interface AirChangeDViewController ()
{
    UITableView *vtableView;

    NSString *orderNumBefore;
    NSDictionary *infoDic;
    NSDictionary *oldInfoDic;
    
    UILabel *OrderPricelable;
    float fltgFee;
}

@end

@implementation AirChangeDViewController
@synthesize airModel = _airModel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initNav:@"改期单"];
    [self createScreen];
    [self getLoadData];
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
    NSArray *array = @[@"支付"];
    
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
    OrderPricelable= [AffUIToolBar lableCgrectmake:CGRectMake(20, 10, 170, 30) lableNametext:[NSString stringWithFormat:@"需支付金额: ¥%@", @""]];
    OrderPricelable.font = FONT_14;
    OrderPricelable.textAlignment = NSTextAlignmentLeft;
    OrderPricelable.textColor = [UIColor whiteColor];
    [view addSubview:OrderPricelable];
    [self.view addSubview:view];
}


-(void)getLoadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"orderNum = %@", self.airModel.orderNumber);
    [[HHYNetworkEngine sharedInstance] queryOrderDetail:self.airModel.orderNumber block:^(NSError *error, id data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (!error) {
            NSLog(@"data = %@",data);
            if ([data isKindOfClass:[NSDictionary class]]) {
                infoDic = [[NSDictionary alloc] initWithDictionary:data];
            }
            
            NSArray *array = [infoDic objectForKey:@"flightDetailVO"];
            fltgFee = 0;
            for (NSDictionary *dic in array) {
                float fl = [[dic objectForKey:@"tpFee"] floatValue];
                fltgFee += fl;
            }
            OrderPricelable.text = [NSString stringWithFormat:@"需支付金额:￥%.2f", fltgFee];
            
            [vtableView reloadData];
        } else {
            [Utils alertWithTitle:@"提示" message:@"获取订单信息失败"];
        }
    }];
    

    
    //截取订单号
    int index = 0;
    for (int i=14; i<[self.airModel.orderNumber length]; i++) {
        NSString *str = [self.airModel.orderNumber substringFromIndex:i];
        if ([str hasPrefix:@"-"]) {
            index = i;
            break;
        }
    }
    
    NSString *oldOrderNum = [self.airModel.orderNumber substringToIndex:index];
    oldOrderNum = [oldOrderNum substringFromIndex:2];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"orderNum = %@", oldOrderNum);
    [[HHYNetworkEngine sharedInstance] queryOrderDetail:oldOrderNum block:^(NSError *error, id data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (!error) {
            NSLog(@"data = %@",data);
            if ([data isKindOfClass:[NSDictionary class]]) {
                oldInfoDic = [[NSDictionary alloc] initWithDictionary:data];
            }
            
            [vtableView reloadData];
        } else {
            [Utils alertWithTitle:@"提示" message:@"获取订单信息失败"];
        }
    }];
}


-(void)createScreen
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    vtableView = [[UITableView alloc] init];
    if (iPhone5) {
        vtableView.frame = CGRectMake(0, 0, 320, 568-64-45);
    }else{
        vtableView.frame =CGRectMake(0, 0, 320, 480-64-45);
    }
    vtableView.delegate = self;
    vtableView.dataSource = self;
    [self.view addSubview:vtableView];
    
    [self creatBottom];
}

-(void)createRighteItem
{
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(232, 0, 30, 44);
    [phoneButton setImage:[UIImage imageNamed:@"playPhone"]forState:UIControlStateNormal];
    //    [phoneButton addTarget:self action:@selector(playPhone) forControlEvents:UIControlEventTouchUpInside];
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
    //支付
     //跳支付
     TicketPayViewController *theView = [[TicketPayViewController alloc] init];
     theView.orderNum = self.airModel.orderNumber;
     theView.allCount = fltgFee;
     theView.detailInfo = infoDic;
     [self.navigationController pushViewController:theView animated:YES];
}

#pragma tableViewDataSource

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *array = @[@"订单信息", @"航班信息", @"乘机人信息",@"联系人信息"];

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 20)];
        lable.text = [array objectAtIndex:section];
        lable.font = FONT_14;
        [view addSubview:lable];
        view.backgroundColor = [JJDevice colorWithR:232 G:232 B:232 A:1.0];
        
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
    return 1;
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
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
        return cell;
    }else if (indexPath.section==1){
        AirChangeDCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AirChangeDCell" owner:nil options:nil] lastObject];
        }
        //改前
        NSArray *array1 = [oldInfoDic objectForKey:@"flightDetailVO"];
        NSDictionary *dic1 = [array1 objectAtIndex:indexPath.row];
        NSString *bDate = [dic1 objectForKey:@"departureDate"];
        bDate = [bDate substringToIndex:bDate.length-8];
//        for (int i=7; i<bDate.length; i++) {
//            NSString *str = [bDate substringToIndex:i];
//            if ([str hasPrefix:@" "]) {
//                bDate = [bDate substringToIndex:i];
//                break;
//            }
//        }
        
        cell.bDate.text = bDate;
        cell.bCityToCIty.text = [NSString stringWithFormat:@"%@-%@",[dic1 objectForKey:@"orgCityCN"],[dic1 objectForKey:@"desCityCN"]];
        cell.bStartTime.text = [dic1 objectForKey:@"departureTime"];
        cell.bEndTime.text = [dic1 objectForKey:@"arrivalTime"];
        
        
        NSString *terminal1 = [dic1 objectForKey:@"terminal"];
        NSString *st1 = [terminal1 substringToIndex:2];
        NSString *et1 = [terminal1 substringFromIndex:4];
        
        cell.bStatePlace.text = [NSString stringWithFormat:@"%@%@",[dic1 objectForKey:@"orgCity"],st1];
        cell.bEndPlace.text = [NSString stringWithFormat:@"%@%@",[dic1 objectForKey:@"desCity"],et1];
        
        NSString *cw1;
        if ([[[array1 objectAtIndex:indexPath.row] objectForKey:@"cabin"] isEqualToString:@"Y"]) {
            cw1 = @"经济舱";
        }else if([[[array1 objectAtIndex:indexPath.row] objectForKey:@"cabin"] isEqualToString:@"C"]){
            cw1 = @"商务舱";
        }else{
            cw1 = @"头等舱";
        }
        cell.bAirPlaneInfo.text = [NSString stringWithFormat:@"%@  %@  %@  %@", [dic1 objectForKey:@"airWayName"],[dic1 objectForKey:@"flightnumber"],cw1,[dic1 objectForKey:@"model"]];
        cell.bairPrice.text = [NSString stringWithFormat:@"￥%@", [dic1 objectForKey:@"publishedPrice"]];
        
        NSString *tax1 = [dic1 objectForKey:@"tax"];
        tax1 = [tax1 stringByReplacingOccurrencesOfString:@"-" withString:@"￥"];
        cell.bShuiText.text = [NSString stringWithFormat:@"￥%@", tax1];
        
        //改后
        NSArray *array = [infoDic objectForKey:@"flightDetailVO"];
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        NSString *aDate = [dic objectForKey:@"departureDate"];
        aDate = [aDate substringToIndex:aDate.length-8];
//        for (int i=7; i<aDate.length; i++) {
//            NSString *str = [aDate substringToIndex:i];
//            if ([str hasPrefix:@" "]) {
//                aDate = [aDate substringToIndex:i];
//                break;
//            }
//        }
        
        cell.aDate.text = aDate;
        cell.aCityToCIty.text = [NSString stringWithFormat:@"%@-%@",[dic objectForKey:@"orgCityCN"],[dic objectForKey:@"desCityCN"]];
        cell.aStartTime.text = [dic objectForKey:@"departureTime"];
        cell.aEndTime.text = [dic objectForKey:@"arrivalTime"];
        
        NSString *terminal = [dic objectForKey:@"terminal"];
        NSString *st = [terminal substringToIndex:2];
        NSString *et = [terminal substringFromIndex:4];
        
        cell.aStartPlace.text = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"orgCity"],st];
        cell.aEdnPlace.text = [NSString stringWithFormat:@"%@%@",[dic objectForKey:@"desCity"],et];
        
        NSString *cw;
        if ([[[array objectAtIndex:indexPath.row] objectForKey:@"cabin"] isEqualToString:@"Y"]) {
            cw = @"经济舱";
        }else if([[[array objectAtIndex:indexPath.row] objectForKey:@"cabin"] isEqualToString:@"C"]){
            cw = @"商务舱";
        }else{
            cw = @"头等舱";
        }
        cell.aAirLineInfo.text = [NSString stringWithFormat:@"%@  %@  %@  %@", [dic objectForKey:@"airWayName"],[dic objectForKey:@"flightnumber"],cw,[dic objectForKey:@"model"]];
        cell.aAirLinePriceText.text = [NSString stringWithFormat:@"￥%@", [dic objectForKey:@"publishedPrice"]];
        
        NSString *tax = [dic objectForKey:@"tax"];
        tax = [tax stringByReplacingOccurrencesOfString:@"-" withString:@"￥"];
        cell.aShuiText.text = [NSString stringWithFormat:@"￥%@", tax];
        cell.aGQPrice.text = [NSString stringWithFormat:@"改期费:￥%@",[dic objectForKey:@"tpFee"]];
        
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
#pragma tableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50.0f;
    }else if (indexPath.section == 1){
        return 335.0f;
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


