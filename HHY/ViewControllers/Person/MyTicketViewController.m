//
//  MyTicketViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-25.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "MyTicketViewController.h"
#import "AirOrderListCell.h"
#import "HotelMenuViewCell.h"
#import "AirOrderModel.h"
#import "HotelOrderModel.h"
#import "FlightListModel.h"
#import "OrderDetailViewController.h"
#import "HotelOrderdetailViewController.h"
#import "AirReturnViewController.h"
#import "AirChangeDViewController.h"

//#import "ParserData.h"

@interface MyTicketViewController ()
{
    NSArray *airStateArray;
    NSArray *airNumState;
}

@end

@implementation MyTicketViewController

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
    [self initNav:@"我的订单"];
    _dataTicketArray = [[NSMutableArray alloc] init];
    _dataHotelArray = [[NSMutableArray alloc] init];
    
    airStateArray = @[@"预订中",@"待收款",@"已处理",@"记录已消除",@"逻辑删除",@"已确认",@"已审批",@"审批中",@"审批拒绝",@"导入",@"出票提示邮件",@"旅客行程邮件",@"已付款",@"已结算",@"已出票",@"已退票",@"已改期",@"改期申请",@"退票申请",@"航班延误申请",@"退票已核算"];
    airNumState = @[@"0",@"1",@"2",@"3",@"33",@"5",@"6",@"4",@"14",@"7",@"71",@"72",@"88",@"8",@"9",@"20",@"24",@"21",@"22",@"23",@"221"];
    
    
    [self createScreen];
    [self getLoadData];
}

-(void)createScreen
{

    NSArray *array = @[@"机票", @"酒店"];
    isHotel = NO;
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*160, 0, 160, 40);
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"buttonCN"] forState:UIControlStateNormal];
        button.tag = 100+i;
        [self.view addSubview:button];
        [button addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
        if (i==1) {
            [button setBackgroundImage:[UIImage imageNamed:@"buttonBtn"] forState:UIControlStateNormal];
        }else{
            button.titleLabel.textColor = [UIColor orangeColor];
        }
    }
    
    if (iPhone5) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, 320, 568-60-64) style:UITableViewStylePlain];
        _hotelTableView = [[UITableView alloc] initWithFrame:CGRectMake(420, 60, 320, 568-60-64) style:UITableViewStylePlain];
    }else{
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, 320, 480-60-64) style:UITableViewStylePlain];
        _hotelTableView = [[UITableView alloc] initWithFrame:CGRectMake(420, 60, 320, 480-60-64) style:UITableViewStylePlain];
    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _hotelTableView.delegate = self;
    _hotelTableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self.view addSubview:_hotelTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_hotelTableView) {
        return self.dataHotelArray.count;
    }else{
        return self.dataTicketArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_hotelTableView) {
        return 90;
    }else{
        AirOrderModel *model = [self.dataTicketArray objectAtIndex:indexPath.row];
        return model.flightListArray.count*30 + 50;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView) {
        static NSString *cellId = @"cell";
        AirOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AirOrderListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        
        NSArray *viewsPriceCount = [cell.contentView subviews];
        for (UIView *view in viewsPriceCount) {
            [view removeFromSuperview];
        }
        [cell getCell];
        AirOrderModel *model = [self.dataTicketArray objectAtIndex:indexPath.row];
        cell.orderNumLable.text = [NSString stringWithFormat:@"订  单  号:  %@", model.orderNumber];
        NSInteger count = 0;
    
        for (int i=0; i<model.flightListArray.count; i++) {
            FlightListModel *obj = [model.flightListArray objectAtIndex:i];
            count += [obj.ticketPrice integerValue];
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 30+i*30, 260, 30)];
            lable.text = [NSString stringWithFormat:@"%@-%@ %@   %@起飞", obj.orgCityCn, obj.desCityCn, [[obj.departureDate componentsSeparatedByString:@" "] objectAtIndex: 0], obj.departureTime];
            lable.font = FONT_14;
            lable.textColor = [JJDevice colorWithR:143 G:143 B:143 A:1];
            [cell.contentView addSubview:lable];
        }
        
        cell.priceLable.text = [NSString stringWithFormat:@"¥  %d", [model.total integerValue]];
        cell.stateLable.text = [JJDevice orderState:model.ticketState];
        return cell;
    }else{
        static NSString *cellId = @"cell_hotel";
        HotelMenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HotelMenuViewCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellAccessoryNone;
        HotelOrderModel *model = [self.dataHotelArray objectAtIndex:indexPath.row];
        cell .nameLable.text = [model.hotelHotel objectForKey:@"hotelName"];
        cell.numberLable.text = model.orderNum;
        cell.dateLable.text = model.orderTime;
        cell.priceLable.text = [NSString stringWithFormat:@"￥%@",model.hhyAmount];
        cell.priceLable.textColor = [JJDevice colorWithR:239 G:81 B:0 A:1.0];
        
        //color
        cell.dingdannum.textColor = [JJDevice colorWithR:144 G:144 B:144 A:1.0];
        cell.starttime.textColor = [JJDevice colorWithR:144 G:144 B:144 A:1.0] ;
        cell.jiage.textColor = [JJDevice colorWithR:144 G:144 B:144 A:1.0];
        cell.numberLable.textColor = [JJDevice colorWithR:144 G:144 B:144 A:1.0];
        cell.dateLable.textColor = [JJDevice colorWithR:144 G:144 B:144 A:1.0];
        
        cell.stateLable.text = [JJDevice hotelOrderState:model.orderStatus];
        
        return cell;
    }
}

- (void)hotelOrderCacle:(UIButton *)sender
{
    int index = sender.tag - 2000;
    HotelOrderModel *model = [self.dataHotelArray objectAtIndex:index];
    
    NSString *OrderNum = model.orderNum;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] hotelOrderCacle:OrderNum block:^(NSError *error, id data) {
        NSLog(@"%@", [[HHYNetworkEngine sharedInstance] getToken]);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            if ([data isKindOfClass:[NSDictionary class]]) {
                if ([[data objectForKey:@"msg"] isEqualToString:@"退单失败"]) {
                    UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"退单失败，请仔细阅读退该规则！" delegate:self cancelButtonTitle:@"OK"
                                                            otherButtonTitles:nil, nil];
                    [altView show];
                } else {
                    UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该订单取消成功" delegate:self cancelButtonTitle:@"OK"
                                                            otherButtonTitles:nil, nil];
                    [altView show];
                }
            } else {
                UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"退单失败，请仔细阅读退该规则！" delegate:self cancelButtonTitle:@"OK"
                                                        otherButtonTitles:nil, nil];
                [altView show];
            }
        } else {
            UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"退单失败，请仔细阅读退该规则！" delegate:self cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil, nil];
            [altView show];
        }
    }];
}

- (void)hotelOrderChange:(UIButton *)sender
{
    int index = sender.tag - 3000;
}

#pragma mark -- netWorkRequest
-(void)getLoadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] queryAirPlainOrder:^(NSError *error, id data) {
        NSLog(@"%@", [[HHYNetworkEngine sharedInstance] getToken]);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            if ([data isKindOfClass:[NSArray class]]) {
                if(self.dataTicketArray.count != 0)
                {
                    [self.dataTicketArray removeAllObjects];
                }
                for (NSDictionary *dict in data) {
                 
                    AirOrderModel *model = [[AirOrderModel alloc] init];
                    [model jiexiDict:dict];
                    [self.dataTicketArray addObject:model];
                }
                [_tableView reloadData];

            }
        }
    }];
}

#pragma mark -- cellSelected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView) {
        
        AirOrderModel *model = [self.dataTicketArray objectAtIndex:indexPath.row];
        NSLog(@"orderNum = %@", model.orderNumber);
        if ([model.ticketState isEqualToString:@"221"] ) {
            //退票已核算
            AirReturnViewController *theView = [[AirReturnViewController alloc] init];
            theView.airModel = model;
            [self.navigationController pushViewController:theView animated:YES];
            
        } else if ([model.ticketState isEqualToString:@"222"]){
            //改签已核算
            AirChangeDViewController *tehView = [[AirChangeDViewController alloc] init];
            tehView.airModel = model;
            [self.navigationController pushViewController:tehView animated:YES];
        } else {
            OrderDetailViewController *odvc = [[OrderDetailViewController alloc] init];
            odvc.orderNum = model.orderNumber;
            odvc.allCountPrice = model.total;
            odvc.orderState = model.ticketState;
            
            [self.navigationController pushViewController:odvc animated:YES];
        }
    } else {
        
        HotelOrderModel *model = [self.dataHotelArray objectAtIndex:indexPath.row];
        
        NSString *orderNum = model.orderNum;
        HotelOrderdetailViewController *theView = [[HotelOrderdetailViewController alloc] init];
        theView.orderNum = orderNum;
        theView.orderState = model.orderStatus;
        theView.hotelName = [model.hotelHotel objectForKey:@"hotelName"];
        theView.hotelTime = model.orderTime;
        [self.navigationController pushViewController:theView animated:YES];
    }
}

-(void)changeImage:(UIButton *)button
{
    if (button.tag == 100) {
        [button setBackgroundImage:[UIImage imageNamed:@"buttonCN"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        UIButton *buttontmp = (UIButton *)[self.view viewWithTag:101];
        [buttontmp setBackgroundImage:[UIImage imageNamed:@"buttonBtn"] forState:UIControlStateNormal];
        [buttontmp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        isHotel = NO;
        [self getLoadData];
    }else if (button.tag == 101){
        [button setBackgroundImage:[UIImage imageNamed:@"buttonCN"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        UIButton *buttontmp = (UIButton *)[self.view viewWithTag:100];
        [buttontmp setBackgroundImage:[UIImage imageNamed:@"buttonBtn"] forState:UIControlStateNormal];
        [buttontmp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        isHotel = YES;
    }
    
    if (isHotel ){
        
        
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"app",@"source",@"1",@"userId",@"1",@"pageNo",@"10",@"pageSize", nil];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[HHYNetworkEngine sharedInstance] hotelOrderList:dic block:^(NSError *error, id data) {
            NSLog(@"%@", [[HHYNetworkEngine sharedInstance] getToken]);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!error) {
                if ([data isKindOfClass:[NSArray class]]) {
                    if(self.dataHotelArray.count!=0)
                    {
                        [self.dataHotelArray removeAllObjects];
                    }
                    for (NSDictionary *dict in data) {
                        
                        
                        HotelOrderModel *model = [[HotelOrderModel alloc] init];
                        [model jiexiDict:dict];
                        [self.dataHotelArray addObject:model];
                    }
                    
                    if (self.dataHotelArray.count==0) {
                        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您尚无酒店订单！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [altView show];
                        
                        return ;
                    }
                    
                    
                    [_hotelTableView reloadData];
                    
                } else {
                    UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信息出错,请稍候再试！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [altView show];
                    
                    return;
                }
            } else {
                UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信息出错,请稍候再试！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [altView show];
                
                return;
            }
        }];
    }
    
    [self hotelTableAppear:isHotel];
}

- (void)hotelTableAppear:(BOOL)Hotel
{
    if (Hotel) {
        [UIView animateWithDuration:0.3 animations:^{
                if (iPhone5) {
                    _hotelTableView.frame = CGRectMake(0, 60, 320, 568-60-64);
                }else{
                    _hotelTableView.frame = CGRectMake(0, 60, 320, 480-60-64) ;
                }
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            if (iPhone5) {
                _hotelTableView.frame = CGRectMake(420, 60, 320, 568-60-64);
            }else{
                _hotelTableView.frame = CGRectMake(420, 60, 320, 480-60-64) ;
            }
        }];
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
