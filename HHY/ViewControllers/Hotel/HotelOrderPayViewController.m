//
//  HotelOrderPayViewController.m
//  HHY
//
//  Created by 兵 张 on 14/11/15.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HotelOrderPayViewController.h"
#import "ZhiFuButton.h"
#import "HotelPayCell.h"

#import "AlixLibService.h"
#import "AlixPayOrder.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"

#import "ApplyPeopleModel.h"

@interface HotelOrderPayViewController ()
{
    HotelPayCell *Hcell;
    
    NSMutableArray *applyPeopleList;
    UIView *backView;
    UIButton *btSubmit;
    UIButton *btCancel;

}

@end

@implementation HotelOrderPayViewController
@synthesize isHuiYuan = _isHuiYuan;
@synthesize orderNum = _orderNum;
@synthesize hotelName = _hotelName;
@synthesize roomDic = _roomDic;
@synthesize roomNumber = _roomNumber;
@synthesize addBedCount = _addBedCount;
@synthesize addBedMoney = _addBedMoney;
@synthesize breckfirstCount = _breckfirstCount;
@synthesize breckfirstMoney = _breckfirstMoney;
@synthesize startDate = _startDate;
@synthesize endDate = _endDate;
@synthesize price = _price;
@synthesize orderTime = _orderTime;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    applyPeopleList = [[NSMutableArray alloc] init];
    [self initNav:@"订单支付"];
    self.isHuiYuan = YES;
    [self creatScreen];
    [self creatHeaderView];
    [self createFooterView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(AliSuccess:) name: @"aliPaySuccess" object: nil];
}

- (void)creatHeaderView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UILabel *lbT = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    lbT.backgroundColor = [UIColor whiteColor];
    lbT.textColor = [JJDevice colorWithR:54 G:128 B:214 A:1.0];
    lbT.text = @"预订成功等待审批(或者支付)";
    lbT.textAlignment = NSTextAlignmentCenter;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 29, 320, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:lbT];
    [view addSubview:line];
    
    _tableView.tableHeaderView = view;
}

- (void)creatScreen
{
    backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] init ];
//WithFrame:CGRectMake(0, 0, 320, 500)];
    if (iPhone5) {
        backView .frame = CGRectMake(0, 0, 320, 568-64);

        _tableView.frame = CGRectMake(0, 0, 320, 500);
        _applyPeopletable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568-64-160)];
    } else {
        backView .frame = CGRectMake(0, 0, 320, 480-64);

        
        _tableView.frame = CGRectMake(0, 0, 320, 440);
        _applyPeopletable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-64-160)];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _applyPeopletable.delegate = self;
    _applyPeopletable.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = kADWColor(235, 235, 235, 1);
    
    //提交按钮
    
    btSubmit = [[UIButton alloc] init];
    btSubmit.backgroundColor = [JJDevice colorWithR:247 G:114 B:18 A:1.0];
    [btSubmit setTitleColor:[UIColor whiteColor] forState:0];
    [btSubmit setTitle:@"提交" forState:0];
    [btSubmit addTarget:self action:@selector(submitAppay:) forControlEvents:UIControlEventTouchUpInside];
    
    btCancel = [[UIButton alloc] init];
    btCancel.backgroundColor = [JJDevice colorWithR:54 G:128 B:214 A:1.0];
    [btCancel setTitleColor:[UIColor whiteColor] forState:0];
    [btCancel setTitle:@"取消" forState:0];
    [btCancel addTarget:self action:@selector(applyPeopleDisAppear) forControlEvents:UIControlEventTouchUpInside];
    
    if (iPhone5) {
        btSubmit.frame = CGRectMake(180, 344, 120, 35);
        btCancel.frame = CGRectMake(20, 344, 120, 35);
    } else {
        btSubmit.frame = CGRectMake(180, 346, 120, 35);
        btCancel.frame = CGRectMake(20, 346, 120, 35);
    }
    
    [backView addSubview:_applyPeopletable];
    [backView addSubview:btSubmit];
    [backView addSubview:btCancel];
    [self.view addSubview:backView];
 
   
    [self applyPeopleDisAppear];
}

- (void)applyPeopleAppear
{
    [UIView animateWithDuration:0.3 animations:^{
        _applyPeopletable.alpha = 1.0;
        btSubmit.alpha = 1.0;
        backView.alpha = 1.0;
        btCancel.alpha = 1.0;
    }];
}

- (void)applyPeopleDisAppear
{
    [UIView animateWithDuration:0.3 animations:^{
        _applyPeopletable.alpha = 0.0;
        backView.alpha = 0.0;
        btSubmit.alpha = 0.0;
        btCancel.alpha = 0.0;
    }];
}

-(void)createFooterView
{
    UIView *view = nil;
    if (self.isHuiYuan) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 151)];
    }else{
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 121)];
    }
    view.userInteractionEnabled = YES;
//    view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];

    for( int i=0; i<2; i++){
        UIImageView *lineView1 = [AffUIToolBar imageviewRect:CGRectMake(0, i*19, 320, 1) andimage:[UIImage imageNamed:@"xian"]];
        [view addSubview:lineView1];
    }
    
    UILabel *lable = [AffUIToolBar lableCgrectmake:CGRectMake(0, 20, 320, 29) lableNametext:@"选择您的支付方式"];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor whiteColor];
    lable.textColor = [JJDevice colorWithR:89 G:149 B:216 A:1];
    [view addSubview:lable];
    
    for (int i=0; i<2; i++) {
        UIImageView *line1= [AffUIToolBar imageviewRect:CGRectMake(0, 49+i*12, 320, 1) andimage:[UIImage imageNamed:@"xian"]];
        [view addSubview:line1];
    }
    
    if (self.isHuiYuan) {
        for (int i=0; i<2; i++) {
            UIImageView *lineView1 = [AffUIToolBar imageviewRect:CGRectMake(20, i*30+89, 300, 1) andimage:[UIImage imageNamed:@"xian"]];
            [view addSubview:lineView1];
        }
    }else{
        UIImageView *lineView1 = [AffUIToolBar imageviewRect:CGRectMake(20, 89, 300, 1) andimage:[UIImage imageNamed:@"xian"]];
        [view addSubview:lineView1];
    }
    UIImageView *backview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 60, 320, 100)];
    backview.backgroundColor = [UIColor whiteColor];
    [view addSubview:backview];
    NSArray *imageArray = @[@"gongsishenpi", @"zhifubao", @"yinlian"];
    NSArray *titleArray = @[@"公司审批", @"支付宝支付", @"银联支付"];
    if (self.isHuiYuan) {
        for (int i=0; i<3; i++) {
            ZhiFuButton *button = [[ZhiFuButton alloc] initWithFrame:CGRectMake(0, i*30+60, 320, 30)];
            button.tag = 100+i;
            [button setHeadTitle:[titleArray objectAtIndex:i]];
            [button setheadImage:[imageArray objectAtIndex:i]];
            [button addTarget:self action:@selector(chosePayMethod:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        
            UIImageView *line =[[UIImageView alloc]initWithFrame:CGRectMake(20, i*30 + 89, 300, 1)];
            if(i == 2)
            {
                [line setFrame:CGRectMake(0, i * 30 + 100, 320, 1)];
            }
            line.backgroundColor = kADWColor(200, 200, 200, 1);
            [view addSubview:line];
        }
    }else{
        for (int i=0; i<2; i++) {
            ZhiFuButton *button = [[ZhiFuButton alloc] initWithFrame:CGRectMake(0, i*30+60, 320, 30)];
            button.tag = 101+i;
            [button setHeadTitle:[titleArray objectAtIndex:i+1]];
            [button setheadImage:[imageArray objectAtIndex:i+1]];
            [button addTarget:self action:@selector(chosePayMethod:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
    }
//    UIImageView *endLine = [AffUIToolBar imageviewRect:CGRectMake(0, view.frame.size.height, 320, 1) andimage:[UIImage imageNamed:@"xian"]];
//    [view addSubview:endLine];

    _tableView.tableFooterView = view;
}

#pragma tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int num=0;
    
    if (tableView==_applyPeopletable) {
        num = [applyPeopleList count];
    } else {
        num = 1;
    }
    
    return num;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *returnCell;
    if (tableView==_applyPeopletable) {
        //
        static NSString *cellID = @"applyPeople";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ApplyPeopleCell" owner:self options:nil] lastObject];
        }
        
        UILabel *lbApplyPeo = (UILabel *)[cell viewWithTag:1000];
        UIButton *bt = (UIButton *)[cell viewWithTag:2000];
        
        if ([applyPeopleList count]) {
            ApplyPeopleModel *model = [applyPeopleList objectAtIndex:indexPath.row];
            
            NSString *name = [NSString stringWithFormat:@"%@%@", model.fname,model.sname];
            lbApplyPeo.text = name;
            if (model.isChooesd) {
                [bt setImage:[UIImage imageNamed:@"icon-单选1"] forState:0];
            } else {
                [bt setImage:[UIImage imageNamed:@"icon-单选"] forState:0];
            }
        }
        
        returnCell = cell;
    } else {
        static NSString *cellId = @"cell";
//
        Hcell = [tableView dequeueReusableCellWithIdentifier:cellId];

        if (!Hcell) {
            Hcell = [[[NSBundle mainBundle] loadNibNamed:@"HotelPayCell" owner:self options:nil] lastObject];
        }
    
        Hcell.lbOrderNum.textColor = [JJDevice colorWithR:247 G:114 B:18 A:1.0];
        Hcell.lbOrderNum.text = [NSString stringWithFormat:@"订  单  号:%@",_orderNum];
        Hcell.lbhotelName.text = _hotelName;
        Hcell.lbRoomType.text = [NSString stringWithFormat:@"%@-%@",[self.roomDic objectForKey:@"catName"], [self.roomDic objectForKey:@"typeName"]];
        if (_orderTime) {
            Hcell.lbTime.text = _orderTime;
        } else {
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            Hcell.lbTime.text = [formatter stringFromDate:date];
        }
    
        if (_roomDic) {
            Hcell.lbPrice.text = [NSString stringWithFormat:@"￥%@", [self.roomDic objectForKey:@"roomPrice"]];
        } else {
            Hcell.lbPrice.text = [NSString stringWithFormat:@"￥%@", _price];
        }

        Hcell.lbRoomCount.text = [NSString stringWithFormat:@"%@间",_roomNumber];
    
        returnCell = Hcell;
    }
    
    returnCell.selectionStyle = UITableViewCellAccessoryNone;
    return returnCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _applyPeopletable) {
        
        for (int i=0; i<[applyPeopleList count]; i++) {
            ApplyPeopleModel *model = [applyPeopleList objectAtIndex:i];
            if (i==indexPath.row) {
                model.isChooesd = YES;
            } else {
                model.isChooesd = NO;
            }
            
            [_applyPeopletable reloadData];
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

#pragma tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_applyPeopletable) {
        return 44.0;
    }
    return 105;
}


- (void)chosePayMethod:(UIButton *)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (sender.tag == 100) {
        
        if ([applyPeopleList count]==0) {
            [[HHYNetworkEngine sharedInstance] searchApplyPeople: ^(NSError *error, id data){
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (!error) {
                    if ([data isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *dic in data) {
                            ApplyPeopleModel *model = [[ApplyPeopleModel alloc] init];
                            [model jieXi:dic];
                            [applyPeopleList addObject:model];
                        }
                        
                        //第二步，弹出审批人列表
                        [_applyPeopletable reloadData];
                        [self applyPeopleAppear];
                        
                    } else {
                        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数据格式错误" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [altView show];
                    }
                } else {
                    [Utils alertWithTitle:data message:nil];
                }
            }];
        } else {
            //直接进行第二步
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self applyPeopleAppear];
        }

        /*
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入公司邮箱！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        altView.alertViewStyle = UIAlertViewStylePlainTextInput;
        altView.tag = 125;
        [altView show];*/
        
    } else if (sender.tag==101) {
        //支付宝
        [[HHYNetworkEngine sharedInstance] getPayURL:self.orderNum  block:^(NSError *error, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            NSLog(@"data = %@", data);
            if (!error) {
                [self aliPay:data];
            } else {
                UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"获取支付信息失败，请稍后再试!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [altView show];
            }
        }];
    } else {
        //银联
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"银联支付方式暂不支持，请选择其他支付方式!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
    }
}

- (void)submitAppay:(NSString *)email
{
    NSString *email_ture;
    for (ApplyPeopleModel *model in applyPeopleList) {
        if (model.isChooesd) {
            email_ture = model.email;
        }
    }
    
    if ([email_ture length]==0) {
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择审批人" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        
        return ;
    }
    
    [self applyPeopleDisAppear];
    
//    [[HHYNetworkEngine sharedInstance] examineApply:self.orderNum andEmail:email_ture  block:^(NSError *error, id data) {
    [[HHYNetworkEngine sharedInstance] HotelOrderApply:self.orderNum andEmail:email_ture block:^(NSError *error,id data){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (!error) {
            //
            if ([[data objectForKey:@"success"] boolValue]) {
                UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交审批成功，请等待结果！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [altView show];
            } else {
                UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交审批失败!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [altView show];
            }
        } else {
            UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交审批失败，请稍后重试！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [altView show];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark aliPay

- (void)aliPay:(NSString*)orderString
{
    
    NSString *appScheme = @"HHY";
    //    NSString* orderInfo = [self getOrderInfo:1];
    //    NSString* signedStr = [self doRsa:orderInfo];
    
    //    NSLog(@"signedstr = %@",signedStr);
    
    //    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderInfo, signedStr, @"RSA"];
    
    [AlixLibService  payOrder:orderString AndScheme:appScheme seletor:@selector(paymentResult:) target:self];
}

-(void)paymentResult:(NSString *)resultd
{
    //结果处理
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
    NSLog(@"支付 result = %@", [result description]);
    
    if (result)
    {
        NSLog(@"支付 result = %@", [result description]);
        
        if (result.statusCode == 9000)
        {
            NSLog(@"支付 result = %@", [result description]);
            
            /*
             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
             */
            
            /*
             //交易成功
             NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
             id<DataVerifier> verifier;
             verifier = CreateRSADataVerifier(key);
             
             if ([verifier verifyString:result.resultString withSign:result.signString])
             {
             //验证签名成功，交易结果无篡改
             }*/
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}


- (void)AliSuccess:(NSNotification *)notification
{
    id obj = [notification object];
    
    //    NSUserDefaults *appDefault = [NSUserDefaults standardUserDefaults];
    //    NSString *username = [appDefault objectForKey:@"username"];
    //    NSString *password = [appDefault objectForKey:@"password"];
    //    NSString *UUID = [appDefault objectForKey:@"UUID"];
    
    
    //    NSDictionary *dic = nil;
    if ([obj isEqualToString:@"1"]) {
        //支付成功===调用对接接口
        
        //        NSDictionary *dic = [dt ResultOfPay:@"1006007" inmode:@"4" orderNum:_orderNumber payType:@"1" payState:obj username:username password:password UUID:UUID];
        //        NSLog(@"dic = %@", [dic description]);
        
        UIAlertView *altview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"付款成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        altview .tag = 900;
        [altview show];
        
    } else {
        //支付失败
        UIAlertView *altview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"付款失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [altview show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==125) {
        if (buttonIndex==0) {
            //取消
        } else {
            //确认
            UITextField *tf = [alertView textFieldAtIndex:0];
            NSString *email = tf.text;
            
            [self submitAppay:email];
        }
    }
}

@end
