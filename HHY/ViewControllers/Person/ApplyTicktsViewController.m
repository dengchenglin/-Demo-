//
//  ApplyTicktsViewController.m
//  HHY
//
//  Created by 兵 张 on 14/11/21.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "ApplyTicktsViewController.h"
#import "MyTicketViewController.h"

#import "HotelMenuViewCell.h"
#import "AirOrderModel.h"
#import "HotelOrderModel.h"
#import "FlightListModel.h"
#import "OrderDetailViewController.h"
#import "HotelOrderdetailViewController.h"

#import "ApplyAirTicketsOrderTableViewCell.h"
#import "ApplyAirOrderModel.h"
#import "HotelOrderModel.h"

//#import "ParserData.h"

@interface ApplyTicktsViewController ()
{
    NSArray *airStateArray;
    NSArray *airNumState;
}

@end

@implementation ApplyTicktsViewController
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
    [self initNav:@"审批订单"];
    _dataTicketArray = [[NSMutableArray alloc] init];
    _dataHotelArray = [[NSMutableArray alloc] init];
    
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
        [button setBackgroundImage:[UIImage imageNamed:@"buttonBtn"] forState:UIControlStateNormal];
        button.tag = 100+i;
        [self.view addSubview:button];
        [button addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
        if (i==1) {
            [button setBackgroundImage:[UIImage imageNamed:@"buttonCN"] forState:UIControlStateNormal];
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
        return 110;
    }else{
        return 110;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableView) {
        static NSString *cellId = @"cell";
        ApplyAirTicketsOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ApplyAirTicketsOrderTableViewCell" owner:self options:nil] lastObject];
        }
        
        if ( ([_dataTicketArray count]!=0) && (!isHotel) ){
            
            ApplyAirOrderModel *model = [self.dataTicketArray objectAtIndex:indexPath.row];
            cell.lbOrderNum.text = [NSString stringWithFormat:@"订  单  号:  %@", model.orderNumber];
            
            NSString *time = [model.addTime substringToIndex:10];
            cell.lbTime.text = time;
            cell.lbPhone.text = model.monile;
            cell.lbContact.text = model.contactName;
            cell.lbPrice.text = [NSString stringWithFormat:@"￥%@", model.totleFee];
            cell.lbState.text = [JJDevice orderState:model.ticketState];
            
            if ([model.ticketState isEqualToString:@"4"]) {//审批中
                //添加取消、确定按钮
                cell.btCacle.tag = 2000 + indexPath.row;
                [cell.btCacle addTarget:self action:@selector(applyCacle:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.btPass.tag = 2000 + indexPath.row;
                [cell.btPass addTarget:self action:@selector(applyPass:) forControlEvents:UIControlEventTouchUpInside];
                
            } else {
                cell.btCacle.hidden = YES;
                cell.btPass.hidden = YES;
            }
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        static NSString *cellId = @"cell_hotel";
        ApplyAirTicketsOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ApplyAirTicketsOrderTableViewCell" owner:self options:nil] lastObject];
        }
        HotelOrderModel *model = [self.dataHotelArray objectAtIndex:indexPath.row];
        
        cell.lbOrderNum.text = model.orderNum;
        cell.lbTime.text = [model.orderTime substringToIndex:10];
        cell.lbPhone.text = model.tel;
        cell.lbContact.text = model.contact;
        cell.lbPrice.text = [NSString stringWithFormat:@"￥%@", model.hhyAmount];
        
        cell.lbState.text = [JJDevice hotelOrderState:model.orderStatus];
        
        if ([model.orderStatus isEqualToString:@"WAITSHENPI"]) {//待审批，显示通过、拒绝按钮
            cell.btCacle.tag = 2000 +indexPath.row;
            [cell.btCacle addTarget:self action:@selector(hotelOrderCacle:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.btPass.tag = 2000 + indexPath.row;
            [cell.btPass addTarget:self action:@selector(hotelOrderChange:) forControlEvents:UIControlEventTouchUpInside];
            
        } else {
            cell.btCacle.hidden = YES;
            cell.btPass.hidden = YES;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)applyCacle:(UIButton *)sender
{
    //审批拒绝
    int index = sender.tag - 2000;
    ApplyAirOrderModel *model = [self.dataTicketArray objectAtIndex:index];
    NSDictionary *infoDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"14",@"state",model.orderNumber,@"orderNum",model.username,@"username", nil];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] airOrderLeaderApply:infoDic block:^(NSError *error,id data){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            //
            [Utils alertWithTitle:@"提示" message:data];
            [_tableView reloadData];
        } else {
            [Utils alertWithTitle:@"提示" message:@"审批操作失败，请稍候再试！"];
        }
    }];
    
}

- (void)applyPass:(UIButton *)sender
{
    //审批通过
    int index = sender.tag - 2000;
    ApplyAirOrderModel *model = [self.dataTicketArray objectAtIndex:index];
    NSDictionary *infoDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"6",@"state",model.orderNumber,@"orderNum",model.username,@"username", nil];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] airOrderLeaderApply:infoDic block:^(NSError *error,id data){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            //
            [Utils alertWithTitle:@"提示" message:data];
            [_tableView reloadData];
        } else {
            [Utils alertWithTitle:@"提示" message:@"审批操作失败，请稍候再试！"];
        }
    }];
    
}

- (void)hotelOrderCacle:(UIButton *)sender
{
    int index = sender.tag - 2000;
    HotelOrderModel *model = [self.dataHotelArray objectAtIndex:index];
    NSString *orderNum = model.orderNum;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] hotelOrderApplyRefuse:orderNum block:^(NSError *error,id data){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            NSLog(@"data = %@", [data description]);
            if ([data isKindOfClass:[NSDictionary class]]) {
                if ([[data objectForKey:@""] isEqualToString:@"审批拒绝成功"]) {
                    [Utils alertWithTitle:@"提示" message:@"审批拒绝成功"];
                } else {
                    [Utils alertWithTitle:@"提示" message:@"审批拒绝失败"];
                }
            }
        } else {
            [Utils alertWithTitle:@"提示" message:@"审批操作失败，请稍候再试！"];
        }
    }];
}

- (void)hotelOrderChange:(UIButton *)sender
{
    int index = sender.tag - 2000;
    HotelOrderModel *model = [self.dataHotelArray objectAtIndex:index];
    NSString *orderNum = model.orderNum;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] hotelOrderApplyPass:orderNum block:^(NSError *error,id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            //
            if ([data isKindOfClass:[NSDictionary class]]) {
                if ([[data objectForKey:@""] isEqualToString:@"审批通过成功"]) {
                    [Utils alertWithTitle:@"提示" message:@"审批通过成功!"];
                } else {
                    [Utils alertWithTitle:@"提示" message:@"审批操作失败!"];
                }
            } else {
                [Utils alertWithTitle:@"提示" message:@"审批操作失败，请稍候再试!"];
            }
        } else {
            [Utils alertWithTitle:@"提示" message:@"审批操作失败，请稍候再试！"];
        }
    }];
    
}

#pragma mark -- netWorkRequest
-(void)getLoadData
{
    NSUserDefaults *appDefault = [NSUserDefaults standardUserDefaults];
    NSString *email = [appDefault objectForKey:@"applyEmail"];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[HHYNetworkEngine sharedInstance] searchAirOrderNeedApply:email   block:^(NSError *error, id data){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            if ([data isKindOfClass:[NSArray class]]) {
                
                
                NSLog(@"data = %@", [data description]);
                for (NSDictionary *dict in data) {
                    ApplyAirOrderModel *model = [[ApplyAirOrderModel alloc] init];
                    [model jieXi:dict];
                    [self.dataTicketArray addObject:model];
                }
                [_tableView reloadData];
            }
        } else {
            [Utils alertWithTitle:@"提示" message:@"获取信息失败,请稍候再试"];
        }
    }];
    
    
    
    /*
    [[HHYNetworkEngine sharedInstance] queryAirPlainOrder:^(NSError *error, id data) {
        NSLog(@"%@", [[HHYNetworkEngine sharedInstance] getToken]);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            if ([data isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in data) {
                    AirOrderModel *model = [[AirOrderModel alloc] init];
                    [model jiexiDict:dict];
                    [self.dataTicketArray addObject:model];
                }
                [_tableView reloadData];
                
            }
        }
    }];*/
}

#pragma mark -- cellSelected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
    
    if ((isHotel)&&(self.dataHotelArray.count==0) ){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[HHYNetworkEngine sharedInstance] searchHotelOrderNeedApply:[[NSUserDefaults standardUserDefaults] objectForKey:@"applyEmail"] block:^(NSError *error, id data) {
            NSLog(@"%@", [[HHYNetworkEngine sharedInstance] getToken]);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!error) {
                if ([data isKindOfClass:[NSArray class]]) {
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
