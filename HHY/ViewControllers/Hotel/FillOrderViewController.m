//
//  FillOrderViewController.m
//  HHY
//
//  Created by chenguangjiang on 14-11-7.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "FillOrderViewController.h"
#import "OrderHeaderDetailCell.h"
#import "OrderHeaderMsgCell.h"
#import "OrderNoticeCell.h"
#import "OrderCouponCell.h"
#import "OrderFillCell.h"
#import "RemarkCell.h"
#import "OrderServiceCell.h"
#import "HotelOrderParameter.h"
#import "CustomPickView.h"
#import "HotelOrderPayViewController.h"
#import "PersonModel.h"
@interface FillOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
      UIView *_submitView;
    UILabel *_totalAmount;
    
    NSString *orderNumber;
}
@property (nonatomic,retain)PersonModel *model;
@end
static CGFloat orderSevHeight = 0;
@implementation FillOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countTotalAmount:) name:@"countTotalAmount" object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    orderNumber = @"";
 
    [self createView];
    [self createSubmitView];
    [self loadPersonInfo];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"countTotalAmount" object:[NSNumber numberWithFloat:0]];
}

-(void)createSubmitView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _submitView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50 - 64, 320, 50)];
    _submitView.backgroundColor = kADWColor(244, 118, 11, 1);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 30)];
    label.text = @"订单总金额:";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor =[UIColor whiteColor];
    [_submitView addSubview:label];
    _totalAmount = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 80, 30)];
    _totalAmount.text = @"¥ 0";
    _totalAmount.textColor= [UIColor whiteColor];
    _totalAmount.font =[UIFont systemFontOfSize:14];
    [_submitView addSubview:_totalAmount];
    
    UIButton *submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBut.backgroundColor = kADWColor(239, 104, 17, 1);
    [submitBut setFrame:CGRectMake(240, 0, 80, 50)];
    [submitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBut setTitle:@"提交订单" forState:UIControlStateNormal];
    
    submitBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBut addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [_submitView addSubview:submitBut];
    [self.view addSubview:_submitView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resgiterKboard)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];


}
-(void)createView
{
    [self initNav:@"填写订单"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, kScreenHeight - 64 - 50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"OrderHeaderMsgCell" bundle:nil] forCellReuseIdentifier:@"OrderHeaderMsgCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"OrderHeaderDetailCell" bundle:nil] forCellReuseIdentifier:@"OrderHeaderDetailCell"];
     [_tableView registerNib:[UINib nibWithNibName:@"OrderServiceCell" bundle:nil] forCellReuseIdentifier:@"OrderServiceCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"OrderNoticeCell" bundle:nil] forCellReuseIdentifier:@"OrderNoticeCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"OrderFillCell" bundle:nil] forCellReuseIdentifier:@"OrderFillCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"RemarkCell" bundle:nil] forCellReuseIdentifier:@"RemarkCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"OrderCouponCell" bundle:nil] forCellReuseIdentifier:@"OrderCouponCell"];
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    _tableView.delaysContentTouches = NO;
    [self.view addSubview:_tableView];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2)
    {
        return [_roomNum integerValue];
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 60;
    }
    if(indexPath.section == 1)
    {
        return 35;
    }
    if(indexPath.section == 2)
    {
       
        return orderSevHeight;
    }
    if(indexPath.section == 3)
    {
        return 30;
    }
    if(indexPath.section == 4)
    {
        return 50;
    }
    if(indexPath.section == 5)
    {
        return 155;
    }
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0)
    {
        OrderHeaderMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderHeaderMsgCell"];
        cell.hotelName.text = _hotelName;
        cell.startDate.text = _startDate;
        cell.endDate.text = _endDate;

        cell.roomCount.text = [NSString stringWithFormat:@"%@间",_roomNum];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }
    if(indexPath.section == 1)
    {

        OrderHeaderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderHeaderDetailCell"];
        cell.roomType.text = [_roomDic objectForKey:@"catName"];
        cell.bedType.text = [_roomDic objectForKey:@"typeName"];
        if(![[NSString stringWithFormat:@"早餐%@份",[_roomDic objectForKey:@"bf"]] isEqualToString:@"0"])
        {
            cell.breakfast.text = [NSString stringWithFormat:@"早餐%@份",[_roomDic objectForKey:@"bf"]];
        }
        cell.price.text = [NSString stringWithFormat:@"¥ %@",[_roomDic objectForKey:@"roomPrice"]];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }
    if(indexPath.section == 2)
    {
        OrderServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderServiceCell"];
          cell.fillOrderVC = self;
        NSArray *arr = [_roomDic objectForKey:@"hotelServiceList"];
         NSNumber *_numberHeight = [cell performSelector:@selector(refreshView:) withObject:arr withObject:nil];
        NSInteger _intHeight = [_numberHeight integerValue];
         if(orderSevHeight != _intHeight)
         {
             orderSevHeight = _intHeight;
             [_tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
         }
        cell.roomcount = indexPath.row;
        cell.roomCount.text = [NSString stringWithFormat:@"第%d间",indexPath.row + 1];
        cell.serviceList = arr;
        cell.nightCount = [self getNightcount];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }
    if(indexPath.section == 3)
    {
        OrderCouponCell*cell =  [tableView dequeueReusableCellWithIdentifier:@"OrderCouponCell"];
        
        if([NSString stringWithFormat:@"%@",[_roomDic objectForKey:@"boardBand"]].length != 0)
        {
            cell.isWifi.text = [NSString stringWithFormat:@"%@",[_roomDic objectForKey:@"boardBand"]];
        }
        else
        {
            cell.isWifi.text = @"无";
        }
         cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }
    if(indexPath.section == 4)
    {
        OrderNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderNoticeCell"];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }
    if(indexPath.section == 5)
    {
        OrderFillCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"OrderFillCell"];
        cell.fillOrderVC = self;
  
        
        cell.selectionStyle = UITableViewCellAccessoryNone;
        return cell;
    }
 
    RemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RemarkCell"];
     cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}



//计算总金额
-(void)countTotalAmount:(NSNotification *)notifition
{

    NSObject *obj = notifition.object;
    NSNumber *number = (NSNumber *)obj;
    CGFloat servicePrice = [number floatValue];
    CGFloat roomPrice = [[NSString stringWithFormat:@"%@",[_roomDic objectForKey:@"roomPrice"]] floatValue];
    _totalAmount.text = [NSString stringWithFormat:@"¥ %.0f",servicePrice + roomPrice * [_roomNum integerValue]];
}

-(void)submit
{
    

    OrderFillCell *cell = (OrderFillCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:5]];


    if(cell.Contacter.text && cell.Contacter.text.length != 0)
    {
        [[HotelOrderParameter shareOrderParameter].orderDic setObject:EnCodingNSString(cell.Contacter.text) forKey:@"contact"];
        [[NSUserDefaults standardUserDefaults] setObject:cell.Contacter.text forKey:@"contact"];
    }
    else if([[NSUserDefaults standardUserDefaults] objectForKey:@"contact"])
    {
           [[HotelOrderParameter shareOrderParameter].orderDic setObject:EnCodingNSString([[NSUserDefaults standardUserDefaults] objectForKey:@"contact"]) forKey:@"contact"];
    }
    if(cell.phoneNum.text && cell.phoneNum.text.length != 0)
    {
        [[HotelOrderParameter shareOrderParameter].orderDic setObject:cell.phoneNum.text forKey:@"tel"];
          [[NSUserDefaults standardUserDefaults] setObject:cell.phoneNum.text forKey:@"tel"];
    }
    else if([[NSUserDefaults standardUserDefaults] objectForKey:@"tel"]){
          [[HotelOrderParameter shareOrderParameter].orderDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"tel"] forKey:@"tel"];
    }
    if(cell.invoice && cell.invoice.length != 0)
    {
        [[HotelOrderParameter shareOrderParameter].orderDic setObject:cell.invoice forKey:@"invoice"];
    }
    else{
        [[HotelOrderParameter shareOrderParameter].orderDic setObject:@"0" forKey:@"invoice"];
    }
    if(cell.postcode.text && cell.postcode.text.length != 0)
    {
        [[HotelOrderParameter shareOrderParameter].orderDic setObject:cell.postcode.text forKey:@"postCode"];
         [[NSUserDefaults standardUserDefaults] setObject:cell.postcode.text forKey:@"postCode"];
    }
    else if([[NSUserDefaults standardUserDefaults] objectForKey:@"postCode"]){
            [[HotelOrderParameter shareOrderParameter].orderDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"postCode"] forKey:@"postCode"];
    }
    if(cell.adress.text && cell.adress.text.length != 0)
    {
        [[HotelOrderParameter shareOrderParameter].orderDic setObject:EnCodingNSString(cell.adress.text) forKey:@"address"];
          [[NSUserDefaults standardUserDefaults] setObject:cell.adress.text forKey:@"address"];
    }
    else if([[NSUserDefaults standardUserDefaults] objectForKey:@"address"]){
            [[HotelOrderParameter shareOrderParameter].orderDic setObject:EnCodingNSString([[NSUserDefaults standardUserDefaults] objectForKey:@"address"]) forKey:@"address"];
    }
    if([HHYNetworkEngine sharedInstance].userID)
    {
        [[HotelOrderParameter shareOrderParameter].orderDic setObject:[HHYNetworkEngine sharedInstance].userID forKey:@"userId"];
    }
    
    [[HotelOrderParameter shareOrderParameter].orderDic setObject:@"app" forKey:@"source"];
    [[HotelOrderParameter shareOrderParameter].orderDic setObject:_roomID forKey:@"prodRoomId"];
    [[HotelOrderParameter shareOrderParameter].orderDic setObject:_startDate forKey:@"stayDate"];
    [[HotelOrderParameter shareOrderParameter].orderDic setObject:_endDate forKey:@"endDate"];
    [[HotelOrderParameter shareOrderParameter].orderDic setObject:_roomNum forKey:@"roomNum"];
    

   
    if([[HotelOrderParameter shareOrderParameter].orderDic objectForKey:@"userId"] == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"用户id丢失，请重新登录" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }
    
    if([[HotelOrderParameter shareOrderParameter].orderDic objectForKey:@"prodRoomId"] == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"房间id错误，请重新进入" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }
    if([[HotelOrderParameter shareOrderParameter].orderDic objectForKey:@"stayDate"] == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"入住日期错误，请重新设置" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }
    if([[HotelOrderParameter shareOrderParameter].orderDic objectForKey:@"endDate"] == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"退房日期错误，请重新设置" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }
    if([[HotelOrderParameter shareOrderParameter].orderDic objectForKey:@"roomNum"] == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"请选择房间数量" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }
    else if(![self isfillIntaker])
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"请将入住人填写完整" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }

   else if([[HotelOrderParameter shareOrderParameter].orderDic objectForKey:@"contact"] == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"请输入联系人" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }
   else if([[HotelOrderParameter shareOrderParameter].orderDic objectForKey:@"tel"] == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"请输入联系人电话" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }
    else if([[HotelOrderParameter shareOrderParameter].orderDic objectForKey:@"invoice"] == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"请选择是否需要发票" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }
   else if([[HotelOrderParameter shareOrderParameter].orderDic objectForKey:@"postCode"] == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"请输入邮编" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }
    else if([[HotelOrderParameter shareOrderParameter].orderDic objectForKey:@"address"] == nil)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"请输入联系人地址" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alt show];
        return;
    }


    NSLog(@"%@",[HotelOrderParameter shareOrderParameter].orderDic);

   
    [[HHYNetworkEngine sharedInstance] submitHotelMessage:[HotelOrderParameter shareOrderParameter].orderDic block:^(NSError *error,id data){
        if(!error)
        {
            
            NSDictionary *dic = [data responseJSON];
            NSString *status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"success"]];
            if([status isEqualToString:@"1"])
            {
                orderNumber = [dic objectForKey:@"msg"];
               
                UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"提交成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                alt.tag = 131;
                [alt show];
            }
            else if([NSString stringWithFormat:@"%@",[dic objectForKey:@"msg"]].length != 0)
            {
                [Utils alertWithTitle:[dic objectForKey:@"msg"] message:nil];
            }
        }
        else
        {
            [Utils alertWithTitle:error.localizedDescription message:nil];
        }
    }];
    
}

//获取个人信息
-(void)loadPersonInfo
{
    [[HHYNetworkEngine sharedInstance] queryOneUser:^(NSError *error, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            self.model = data;
            [self refreshPersonInfo];
            [_tableView reloadData];
        }
    }];
}
//保存个人信息到填单字典
-(void)refreshPersonInfo
{
    if(self.model)
    {
        if(_model.staffName)
        {
          [[NSUserDefaults standardUserDefaults] setObject:_model.staffName forKey:@"contact"];
        }
        if(_model.mobile)
        {
             [[NSUserDefaults standardUserDefaults] setObject:_model.mobile forKey:@"tel"];
        }


    }
   
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag >=600 && textField.tag < 700)
    {
        if(textField.text && [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length!= 0)
        {
            
            [[HotelOrderParameter shareOrderParameter].intakerDic setObject:textField.text forKey:[NSNumber numberWithInteger:textField.tag - 600]];
            [[HotelOrderParameter shareOrderParameter] refreshIntakerDic];
        }
        else{
            [[HotelOrderParameter shareOrderParameter].intakerDic removeObjectForKey:[NSNumber numberWithInteger:textField.tag - 600]];
            [[HotelOrderParameter shareOrderParameter] refreshIntakerDic];
        }
    }

 
 
        [textField resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
 
    if(textField.tag >=600 && textField.tag < 700)
    {
        
        return YES;
    }
    _tableView.contentOffset = CGPointMake(0,_tableView.contentSize.height - (kScreenHeight - 168) + 35 * (textField.tag - 500));
    return YES;
  
}
-(void)resgiterKboard
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenkeyboard" object:nil];
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==131) {
        NSLog(@"roomDic = %@", self.roomDic);
        NSLog(@"roomNum = %@", self.roomNum);
        NSLog(@"roomID = %@", self.roomID);
        
        NSLog(@"%@", [[HotelOrderParameter shareOrderParameter].orderDic description]);
        NSLog(@"%@",[[HotelOrderParameter shareOrderParameter].serviceDic description]);
        NSLog(@"%@", [[HotelOrderParameter shareOrderParameter].intakerDic description]);
        NSLog(@"%@", [[HotelOrderParameter shareOrderParameter].serviceDic description]);
        
        HotelOrderPayViewController *hopvc = [[HotelOrderPayViewController alloc] init];
        hopvc.orderNum = orderNumber;
        hopvc.hotelName = _hotelName;
        hopvc.roomDic = _roomDic;
        hopvc.roomNumber = _roomNum;
        
        hopvc.startDate = _startDate;
        hopvc.endDate = _endDate;
        self.isSubmitOrder = YES;
        [self.navigationController pushViewController:hopvc animated:YES];
    }
    if(alertView.tag == 999)
    {
        if(buttonIndex == 1)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


//获取间隔天数
-(NSInteger)getNightcount
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date1 = [formatter dateFromString:_startDate];
    NSDate *date2 = [formatter dateFromString:_endDate];
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    return  ((NSInteger)time)/(3600 * 24);
    
}




//判断入住人是否填写完整
-(BOOL)isfillIntaker{
    

    if([HotelOrderParameter shareOrderParameter].intakerDic.count >= [_roomNum integerValue])
    {
        return YES;
    }
    return NO;
}


-(void)reback
{
    
    if(!_isSubmitOrder)
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"您的订单尚未填写完整,确定要退出?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alt.tag = 999;
        alt.delegate = self;
        [alt show];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    

}

- (void)dealloc
{
    [[HotelOrderParameter shareOrderParameter].orderDic removeAllObjects];
    [[HotelOrderParameter shareOrderParameter].intakerDic removeAllObjects];
    [[HotelOrderParameter shareOrderParameter].serviceDic removeAllObjects];
    [[HotelOrderParameter shareOrderParameter].sevpriceDic removeAllObjects];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
