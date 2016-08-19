//
//  HotelOrderdetailViewController.m
//  HHY
//
//  Created by 兵 张 on 14/11/17.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HotelOrderdetailViewController.h"
#import "LinkPeopleCell.h"
#import "HotelOrderPayViewController.h"
#import "HotelOrderReturnViewController.h"
#import "CustonLine.h"
@interface HotelOrderdetailViewController ()<UITextFieldDelegate>
{
    NSMutableArray *roomList;
    NSString *orderTime;
    NSString *contact;
    NSString *phoneNumber;
    NSString *hhyPrice;
    
    BOOL isPay;
}

@end

@implementation HotelOrderdetailViewController
@synthesize orderNum = _orderNum;
@synthesize hotelName =_hotelName;
@synthesize hotelTime = _hotelTime;
@synthesize orderState = _orderState;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    roomList = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [JJDevice colorWithR:237 G:237 B:237 A:1.0];
    isPay = YES;
    [self initNav:@"订单详情"];
    [self creatScreen];
    [self creatBottom];
    [self getLoadData];
}

- (void)creatBottom
{
    bottomView.backgroundColor = [JJDevice colorWithR:247 G:114 B:18 A:1.0];
    lbOrderPrice.textColor = [UIColor whiteColor];
    [btPay setTitleColor:[UIColor whiteColor] forState:0];
    [btPay setBackgroundColor:[JJDevice colorWithR:54 G:128 B:214 A:1.0]];
    
    if ([_orderState isEqualToString:@"SUCCESSPAID"]) {
        [btPay setTitle:@"退订" forState:0];
        isPay = NO;
    } else if (![_orderState isEqualToString:@"UNPAID"]) {
        btPay.hidden = YES;
        isPay = NO;
    }
    
    if (iPhone5) {
        bottomView.frame = CGRectMake(0, 518-64, 320, 50);
    } else {
        bottomView.frame = CGRectMake(0, 430-64, 320, 50);
    }
    [self.view addSubview:bottomView];
}

- (void)getLoadData
{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] HotelOrderDetail:_orderNum block:^(NSError *error, id data) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            NSDictionary *dic = data;
            [roomList addObjectsFromArray:[dic objectForKey:@"roomList"]];
            orderTime = [dic objectForKey:@"orderTime"];
            contact = [dic objectForKey:@"contact"];
            phoneNumber = [dic objectForKey:@"tel"];
            
            hhyPrice = [dic objectForKey:@"hhyAmount"];
            
            if (hhyPrice) {
                lbOrderPrice.text = [NSString stringWithFormat:@"订单总金额：￥%@", hhyPrice];
            } else {
                lbOrderPrice.text = [NSString stringWithFormat:@"订单总金额：￥%@", hhyPrice];
            }
            
            float fl = 60 + 60*([roomList count]+1) +60 +60+60;
            
            if (iPhone5) {
                if (fl > 518-64) {
                    fl = 518-64;
                }
                _hotelTable.frame = CGRectMake(0, 0, 320, fl);
            } else {
                if (fl > 430-64) {
                    fl = 430-64;
                }
                _hotelTable.frame = CGRectMake(0, 0, 320, fl);
            }
            
            [_hotelTable reloadData];
        }
    }];
}

- (void)creatScreen
{
    _hotelTable = [[UITableView alloc] init];
    
    float fl = 60 + 60*([roomList count]+1) +60 +60+60;
    
    if (iPhone5) {
        if (fl > 518-64) {
            fl = 518-64;
        }
        _hotelTable.frame = CGRectMake(0, 0, 320, fl);
    } else {
        if (fl > 430-64) {
            fl = 430-64;
        }
        _hotelTable.frame = CGRectMake(0, 0, 320, fl);
    }
    _hotelTable.delegate = self;
    _hotelTable.dataSource = self;
    [self.view addSubview:_hotelTable];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Table
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
{
    UIView *view;
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
    UILabel *lnTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 20)];
    lnTitle.textColor = [JJDevice colorWithR:100 G:100 B:100 A:1.0];
    lnTitle.font = [UIFont systemFontOfSize:16.0];
    if (section==0) {
        lnTitle.text = @"订单信息";
    } else if (section==1){
        lnTitle.text = @"房间信息";
    } else {
        lnTitle.text = @"联系人信息";
    }
    [view addSubview:lnTitle];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}
static   NSInteger rowNumber;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if (section==0) {
        rowNumber = 2;
    } else if (section==1) {
        rowNumber =  [roomList count]+1;
    } else if (section ==2) {
        rowNumber = 2;
    }

    return rowNumber;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float fl = 0;
    if (indexPath.section==0) {
        fl = 30;
    } else if (indexPath.section==1) {
        if (indexPath.row==0) {
            fl = 60;
        }  else {
            fl = 60;
        }
    } else if (indexPath.section==2) {
        fl =30;
    }
    
    return fl;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *returnCell;
    
    if (indexPath.section==0) {
        //
        static NSString *CellIdentifier = @"HotelOrderDetail1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HotelOrderDetail1" owner:self options:nil] objectAtIndex:0];
        }

        UILabel *lb1 = (UILabel *)[cell viewWithTag:1000];
        UILabel *lb2 = (UILabel *)[cell viewWithTag:1001];
        UIButton *bt1 = (UIButton *)[cell viewWithTag:2000];
        
        lb1.textColor = [JJDevice colorWithR:134 G:134 B:134 A:1.0];
        lb2.textColor = [JJDevice colorWithR:137 G:137 B:137 A:1.0];
        if (indexPath.row==0) {
            //
            lb1.text = @"订  单  号:";
            lb2.text = _orderNum;
            
            [bt1 setTitle:[JJDevice hotelOrderState:_orderState] forState:0];
        } else {
            lb1.text = @"申请日期:";
            [bt1 setTitle:@"" forState:0];
            lb2 .text = orderTime;
        }
        
     
        returnCell = cell;
    } else if (indexPath.section==1) {
        if (indexPath.row==0) {
            //顶
            static NSString *CellIdentifier = @"Cell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell==nil) {
                cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            UILabel *lbHotelName = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 20)];
            lbHotelName.font = [UIFont boldSystemFontOfSize:15.0];
            lbHotelName.textColor = [UIColor blackColor];
            
            UILabel *lbRoomType = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 20)];
            lbRoomType.font = [UIFont boldSystemFontOfSize:14.0];
            lbRoomType.textColor = [UIColor blackColor];
            
            UILabel *lbRoomCount = [[UILabel alloc] initWithFrame:CGRectMake(240, 30, 60, 20)];
            lbRoomCount.font = [UIFont systemFontOfSize:14.0];
            
            
            lbHotelName.textColor = [JJDevice colorWithR:100 G:100 B:100 A:1.0];
            lbRoomType.textColor = [JJDevice colorWithR:100 G:100 B:100 A:1.0];
            lbRoomCount.textColor = [JJDevice colorWithR:100 G:100 B:100 A:1.0];
            if ([roomList count]!=0) {
//                lbHotelName.text = [[roomList objectAtIndex:0] objectForKey:@"catName"];
                lbHotelName.text = _hotelName;
//                lbRoomType.text = [NSString stringWithFormat:@"%@(含%@份早餐)",[[roomList objectAtIndex:0] objectForKey:@"typeName"],[[roomList objectAtIndex:0] objectForKey:@"bf"]];
                lbRoomType.text = [NSString stringWithFormat:@"%@(含%@份早餐)",[[roomList objectAtIndex:0] objectForKey:@"catName"],[[roomList objectAtIndex:0] objectForKey:@"bf"]];
                
                lbRoomCount.text = [NSString stringWithFormat:@"%d 间",[roomList count]];
            }
            
            [cell addSubview:lbHotelName];
            [cell addSubview:lbRoomType];
            [cell addSubview:lbRoomCount];
            
            returnCell = cell;
        }
//        else if (indexPath.row==[roomList count]+1) {
//            //底
//            static NSString *CellIdentifier = @"Cell2";
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//            if (cell==nil) {
//                cell = [[[NSBundle mainBundle] loadNibNamed:@"HotelOrderDetail5" owner:self options:nil] objectAtIndex:0];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            }
//            UILabel *lbPrice = (UILabel *)[cell viewWithTag:1000];
//            UIButton *btTGGD = (UIButton *)[cell viewWithTag:2000];
//            
//
//            lbPrice.text = [NSString stringWithFormat:@"￥%@",hhyPrice];
//            lbPrice.textColor = [JJDevice colorWithR:247 G:144 B:18 A:1.0];
//            [btTGGD addTarget:self action:@selector(tggd:) forControlEvents:UIControlEventTouchUpInside];
//            
//            
//            
//            cell.backgroundColor = [UIColor whiteColor];
//            returnCell = cell;
//        }
        else {
            //中间房间
            static NSString *CellIdentifier = @"HotelOrderDetail2";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"HotelOrderDetail4" owner:self options:nil] objectAtIndex:0];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            UILabel *lbPerson = (UILabel *)[cell viewWithTag:1000];
//            UILabel *lbStartDate = (UILabel *)[cell viewWithTag:1001];
//            UILabel *lbEndDate = (UILabel *)[cell viewWithTag:1002];
            UILabel *inMonth = (UILabel *)[cell viewWithTag:1100];
            UILabel *inDay = (UILabel *)[cell viewWithTag:1101];
            UILabel *outMonth = (UILabel *)[cell viewWithTag:1200];
            UILabel *outDay = (UILabel *)[cell viewWithTag:1201];
            
            inMonth.textColor = [JJDevice colorWithR:54 G:128 B:214 A:1.0];
            inDay.textColor = [JJDevice colorWithR:54 G:128 B:214 A:1.0];
            outMonth.textColor = [JJDevice colorWithR:54 G:128 B:214 A:1.0];
            outDay.textColor = [JJDevice colorWithR:54 G:128 B:214 A:1.0];
            
            /*
            UILabel *lbSelfBF = (UILabel *)[cell viewWithTag:1100];
            UILabel *lbETBF = (UILabel *)[cell viewWithTag:1101];
            UILabel *addBed = (UILabel *)[cell viewWithTag:1102];
            UILabel *lbSelfBFCount = (UILabel *)[cell viewWithTag:1201];
            UILabel *lbETBFCount = (UILabel *)[cell viewWithTag:1202];
            UILabel *lbAddBedCount = (UILabel *)[cell viewWithTag:1203];
            UILabel *lbNeightSelfBF = (UILabel *)[cell viewWithTag:1300];
            UILabel *lbNeightETBF = (UILabel *)[cell viewWithTag:1301];
            UILabel *lbNeightAddBed = (UILabel *)[cell viewWithTag:1302];
            
            UILabel *lb1 = (UILabel *)[cell viewWithTag:1003];
            UILabel *lb2 = (UILabel *)[cell viewWithTag:1004];
            UILabel *lb3 = (UILabel *)[cell viewWithTag:1005];
            UILabel *lb4 = (UILabel *)[cell viewWithTag:1006];
            lb1.textColor = [JJDevice colorWithR:137 G:137 B:137 A:1.0];
            lb2.textColor = [JJDevice colorWithR:137 G:137 B:137 A:1.0];
            lb3.textColor = [JJDevice colorWithR:137 G:137 B:137 A:1.0];
            lb4.textColor = [JJDevice colorWithR:137 G:137 B:137 A:1.0];
            */
            //table 刷新
            if ([roomList count]!=0) {
                NSString *guest = [[[[roomList objectAtIndex:indexPath.row-1] objectForKey:@"guestList"] objectAtIndex:0] objectForKey:@"guest"];
                
                if ((NSNull *)guest==[NSNull null]) {
                    lbPerson.text = [NSString stringWithFormat:@"第%d间入住人：无入住人信息",indexPath.row];
                } else {
                    guest = [guest stringByReplacingOccurrencesOfString:@"\\" withString:@""];
                    NSString *guestName = [guest stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    
                    lbPerson.text = [NSString stringWithFormat:@"第%d间入住人：%@",indexPath.row,guestName];
                }
                
                NSString *startDate = [[roomList objectAtIndex:indexPath.row-1] objectForKey:@"checkIn"];
                NSString *endDate = [[roomList objectAtIndex:indexPath.row-1] objectForKey:@"checkOut"];
                NSArray *array = [startDate componentsSeparatedByString:@"-"];
                NSArray *array1 = [endDate componentsSeparatedByString:@"-"];
                
                inMonth.text = [self stringReplace:[array objectAtIndex:1]];
                inDay.text = [array objectAtIndex:0];
                outMonth.text = [self stringReplace:[array1 objectAtIndex:1]];
                outDay.text = [array1 objectAtIndex:0];
            }
            returnCell = cell;
        }
    } else if (indexPath.section==2) {
        static NSString *CellIdentifier = @"LinkPeopleCell";
        UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HotelOrderDetail3" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        UILabel *lbt = (UILabel *)[cell viewWithTag:1000];
        UITextField *tf = (UITextField *)[cell viewWithTag:4000];
        tf.enabled = YES;
        if (indexPath.row==0) {
            lbt.text = @"姓名";
            tf.text = contact;
            tf.delegate = self;
        } else {
            lbt.text = @"电话";
            tf.text = phoneNumber;
            tf.delegate = self;
        }
        
//        cell.nameTF.text = contact;
//        cell.phoneTF.text = phoneNumber;
//        cell.nameTF.enabled = NO;
//        cell.phoneTF.enabled = NO;
//        cell.emainTF.enabled = NO;
        
        returnCell = cell;
    }
    
    for(UIView *view in returnCell.contentView.subviews)
    {
       if([view isKindOfClass:[CustonLine class]])
       {
           [view removeFromSuperview];
       }
    }
    
    if(indexPath.row == 0)
    {
      
        CustonLine *line1 =[[CustonLine alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
        line1.backgroundColor = kADWColor(200, 200, 200, 1);
        [returnCell.contentView addSubview:line1];
    }
 
    if(indexPath.row == rowNumber - 1)
    {
        CustonLine *line2 = [[CustonLine alloc]initWithFrame:CGRectMake(0, returnCell.contentView.frame.size.height - 1, 320, 1)];
        line2.backgroundColor = kADWColor(200, 200, 200, 1);
        [returnCell.contentView addSubview:line2];
    }
    return returnCell;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)tggd:(UIButton *)sender
{
    UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"退改规定内容" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [altView show];
}

- (IBAction)toPay:(id)sender {
    if (isPay) {
        HotelOrderPayViewController *theView = [[HotelOrderPayViewController alloc] init];
        theView.orderNum = self.orderNum;
        theView.hotelName = self.hotelName;
        theView.price = hhyPrice;
        theView.orderTime = orderTime;
        theView.roomNumber = [NSString stringWithFormat:@"%d",[roomList count]];
        [self.navigationController pushViewController:theView animated:YES];
    } else {
        HotelOrderReturnViewController *theView = [[HotelOrderReturnViewController alloc] init];
        theView.hotelName = _hotelName;
        theView.hotelTime = _hotelTime;
        theView.orderNum = _orderNum;
        theView.orderState = _orderState;
        [self.navigationController pushViewController:theView animated:YES];
    }
}

- (NSString *)stringReplace:(NSString *)str
{
    NSArray *monthArray = [[NSMutableArray alloc] initWithObjects:@"", @"Jan", @"Fer", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];
    NSArray *numMonthArray = [[NSMutableArray alloc] initWithObjects:@"", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", nil];
    NSString *strRet;
    for (int i=0; i<[monthArray count]; i++) {
        NSRange range = [str rangeOfString:[monthArray objectAtIndex:i]];//判断字符串是否包含
        //if (range.location ==NSNotFound)//不包含
        if (range.length >0) {
            //包含
            strRet = [numMonthArray objectAtIndex:i];
            break;
        }
    }
    
    if ([strRet length]==0) {
        strRet = str;
    }
    
    return strRet;
}

@end
