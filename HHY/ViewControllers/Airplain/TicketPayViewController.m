//
//  TicketPayViewController.m
//  HHY
//
//  Created by jiangjun on 14-5-29.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "TicketPayViewController.h"
#import "CustomView.h"
#import "ZhiFuButton.h"
#import "OrderDetailCell.h"
#import "TicketAndDayModel.h"
#import "DayModel.h"
#import "TicketModel.h"

#import "AlixLibService.h"
#import "AlixPayOrder.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"

#import "ApplyPeopleModel.h"
#import "airplanDetailmodel.h"

@interface TicketPayViewController ()
{
    NSMutableArray *applyPeopleList;
    UIView *backView;
    UIButton *btSubmit;
    UIButton *btCancel;
    
    NSMutableArray *airArray;
}

@end

@implementation TicketPayViewController

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
    [self initNav:@"订单支付"];
    self.isHuiyuan = YES;
    
    airArray = [[NSMutableArray alloc] init];
    if (_detailInfo) {
        [self jieXi:_detailInfo];
    }
    
    _numLable.text = [NSString stringWithFormat:@"订单号:  %@", self.orderNum];
    [self createScreen];
    [self createFootView];
    [self createHeadView];
    
    applyPeopleList = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(AliSuccess:) name: @"aliPaySuccess" object: nil];
    
    [self.view addSubview:_applyPeopletable];
    _applyPeopletable.alpha = 0.0;
}

- (void)jieXi:(NSDictionary *)dic
{

    NSLog(@"%@", [dic description]);
    if ([airArray count]==0) {
        if ([[dic objectForKey:@"flightDetailVO"] isKindOfClass:[NSArray class]]) {
            NSArray *array = [dic objectForKey:@"flightDetailVO"];
            for (int i=0; i<[array count]; i++) {
                airplanDetailmodel *model = [[airplanDetailmodel alloc] init];
                [model jieXi:[array objectAtIndex:i]];
                [airArray addObject:model];
            }
        }
    }
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

-(void)createScreen
{
    self.automaticallyAdjustsScrollViewInsets = NO;
//    UILabel *lable = [AffUIToolBar lableCgrectmake:CGRectMake(0, 0, 320, 40) lableNametext:@"预定成功等待审批(或者支付)"];
//  
//    lable.textAlignment = NSTextAlignmentCenter;
//    lable.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:lable];
    
    
    backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    if (iPhone5) {
        backView .frame = CGRectMake(0, 0, 320, 568-64);
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 324, 568-64) style:UITableViewStylePlain];
        _applyPeopletable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568-64-160)];
    }else{
        backView .frame = CGRectMake(0, 0, 320, 480-64);
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 324, 480-64) style:UITableViewStylePlain];
        _applyPeopletable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-64-160)];
    }

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _applyPeopletable.delegate = self;
    _applyPeopletable.dataSource = self;
    _tableView.backgroundColor = kADWColor(240, 240, 240, 1);
    [self.view addSubview:_tableView];
    
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

#pragma tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int num=0;
    
    if (tableView==_applyPeopletable) {
        num = [applyPeopleList count];
    } else {
        if ([_airPlainArray count]!=0) {
            num = self.airPlainArray.count+1;
        } else {
            num = [airArray count] + 1;
        }
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
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailCell" owner:self options:nil] lastObject];
        }

        if ([_airPlainArray count]!=0) {
            if (indexPath.row==self.airPlainArray.count) {
                [cell.timeLable removeFromSuperview];
                cell.typeLable.textAlignment = NSTextAlignmentRight;
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总额:¥%d",self.allCount]];
                [str addAttribute: NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(3, str.length-3)];
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0] range:NSMakeRange(3, str.length-3)];
                [str addAttribute: NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 3)];
                cell.typeLable.attributedText = str;
            }else{
                cell.timeLable.font = FONT_12;
                cell.typeLable.font = FONT_12;
                
                TicketAndDayModel *model = [self.airPlainArray objectAtIndex:indexPath.row];
                cell.timeLable.text = model.dayModel.description;
                cell.typeLable.text = [NSString stringWithFormat:@"%@%@%@(%@) %@", model.ticketModel.airLineName, model.ticketModel.airLineCode, model.ticketModel.fltNo, model.ticketModel.planeModel, model.palceText];
            }
        } else {
            if (indexPath.row==[airArray count]) {
                [cell.timeLable removeFromSuperview];
                cell.typeLable.textAlignment = NSTextAlignmentRight;
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总额:¥%d",self.allCount]];
                [str addAttribute: NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(3, str.length-3)];
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0] range:NSMakeRange(3, str.length-3)];
                [str addAttribute: NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 3)];
                cell.typeLable.attributedText = str;
            } else {
                if ([airArray count]!=0) {
                    cell.timeLable.font = FONT_12;
                    cell.typeLable.font = FONT_12;
                    airplanDetailmodel *model = [airArray objectAtIndex:indexPath.row];
                    
                    NSString *strDate = [model.departureDate substringToIndex:10];

                    cell.timeLable.text = strDate;
                    
                    cell.typeLable.text = [NSString stringWithFormat:@"%@%@(%@) %@-%@", model.airWayName, model.flightnumber, model.model, model.orgCityCN,model.desCityCN];
                    cell.typeLable.font = FONT_12;
                }
            }
        }
        
        returnCell = cell;
    }
    
    return returnCell;
}
#pragma tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float fl = 30.0f;
    if (tableView==_applyPeopletable) {
        fl = 44.0f;
    }

    return fl;
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

-(void)btnClick:(ZhiFuButton *)button
{
    NSLog(@"%d", button.tag);
}

-(void)createFootView
{
    UIView *view = nil;
    if (self.isHuiyuan) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 151)];
    }else{
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 121)];
    }
    view.userInteractionEnabled = YES;
    
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
        UIImageView *line1= [[UIImageView alloc]initWithFrame:CGRectMake(0, 50+i*10, 320, 1)];
        line1.backgroundColor = kADWColor(220, 220, 220, 1);
        [view addSubview:line1];
    }
    
    if (self.isHuiyuan) {
        for (int i=0; i<2; i++) {
         
            UIImageView *lineView1= [[UIImageView alloc]initWithFrame:CGRectMake(20, i*30+89, 300, 1)];
            lineView1.backgroundColor = kADWColor(220, 220, 220, 1);
            [view addSubview:lineView1];
        }
    }else{
        UIImageView *lineView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 89, 300, 1)];
         lineView1.backgroundColor = kADWColor(220, 220, 220, 1);
        [view addSubview:lineView1];
    }
    
    NSArray *imageArray = @[@"gongsishenpi", @"zhifubao", @"yinlian"];
    NSArray *titleArray = @[@"公司审批", @"支付宝支付", @"银联支付"];
    if (self.isHuiyuan) {
        for (int i=0; i<3; i++) {
            ZhiFuButton *button = [[ZhiFuButton alloc] initWithFrame:CGRectMake(0, i*30+60, 320, 30)];
            button.tag = 100+i;
            [button setHeadTitle:[titleArray objectAtIndex:i]];
            [button setheadImage:[imageArray objectAtIndex:i]];
            [button addTarget:self action:@selector(chosePayMethod:) forControlEvents:UIControlEventTouchUpInside];
          
            [view addSubview:button];
            
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(30, i*30+60+29, 290, 1)];
            lb.text = @"";
            lb.backgroundColor = [JJDevice colorWithR:232 G:232 B:232 A:1.0];
            [view addSubview:lb];
        }
    }else{
        for (int i=0; i<2; i++) {
            ZhiFuButton *button = [[ZhiFuButton alloc] initWithFrame:CGRectMake(0, i*30+60, 320, 30)];
            button.tag = 101+i;
            [button setHeadTitle:[titleArray objectAtIndex:i+1]];
            [button setheadImage:[imageArray objectAtIndex:i+1]];
            [button addTarget:self action:@selector(chosePayMethod:) forControlEvents:UIControlEventTouchUpInside];
         
            [view addSubview:button];
            
            UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(30, i*30+60+29, 290, 1)];
            lb.text = @"";
            lb.backgroundColor = [JJDevice colorWithR:232 G:232 B:232 A:1.0];
            [view addSubview:lb];
        }
    }
    UIImageView *endLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, view.frame.size.height, 320, 1)];
    [view addSubview:endLine];
    view.backgroundColor = kADWColor(220, 220, 220, 1);
    _tableView.tableFooterView = view;
}

-(void)createHeadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 29)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    if (self.isHuiyuan) {
        titleLable.text = @"预定成功等待审批(或者支付)";
    
    }else{
        titleLable.text = @"预定成功等待支付";
    }
    titleLable.textColor = [JJDevice colorWithR:85 G:148 B:216 A:1];
    titleLable.backgroundColor = [UIColor whiteColor];
    [view addSubview:titleLable];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 28, 320, 1)];
    line.backgroundColor = kADWColor(220, 220, 220, 1);
    [view addSubview:line];
    UIImageView *blueLine = [AffUIToolBar imageviewRect:CGRectMake(0, 30, 320, 1) andimage:nil];
    blueLine.backgroundColor = [UIColor blueColor];
    [view addSubview:blueLine];
    
   _numLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 300, 25)];
    if (!self.orderNum) {
        self.orderNum = @"";
    }
    _numLable.text = [NSString stringWithFormat:@"订单号: %@", self.orderNum];
    _numLable.textColor = [JJDevice colorWithR:243 G:126 B:41 A:1];
    _numLable.font = FONT_14;
    
    UIView *viewGray = [[UIView alloc] initWithFrame:CGRectMake(0, _numLable.frame.origin.y, 320, _numLable.frame.size.height)];
    viewGray.backgroundColor = [JJDevice colorWithR:232 G:232 B:232 A:1.0];
    
    [view addSubview:viewGray];
    [view addSubview:_numLable];
    UIImageView *lineView = [AffUIToolBar imageviewRect:CGRectMake(0, 55, 320, 1) andimage:[UIImage imageNamed:@"xian"]];
    [view addSubview:lineView];
    
    _tableView.tableHeaderView = view;
}

-(void)getLoadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *string = [self.jasonDict jsonEncodedKeyValueString];
    [[HHYNetworkEngine sharedInstance] saveOrder:string block:^(NSError *error, id data) {
        if (!error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([data isKindOfClass:[NSDictionary class]]) {
                self.orderNum = [data objectForKey:@"orderNo"];
            }else if([data isKindOfClass:[NSArray class]]){
                self.orderNum = [[data objectAtIndex:0] objectForKey:@"orderNo"];
            }
            
            _numLable.text = [NSString stringWithFormat:@"订单号:  %@", self.orderNum];
            [_tableView reloadData];
        }
    }];
}

-(void)chosePayMethod:(UIButton *)button
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (button.tag == 100) {
        //流程 1、查询审批人  2、弹出审批人列表  3、选择确认 4、发送
        //第一步、
        
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
                        
                        //第二部，弹出审批人列表
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

    } else if (button.tag==101) {
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
    
    [[HHYNetworkEngine sharedInstance] examineApply:self.orderNum andEmail:email_ture  block:^(NSError *error, id data) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (!error) {
            //
            UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交审批成功，请等待结果！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [altView show];
        } else {
            UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交审批失败，请稍后重试！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [altView show];
        }
    }];


}

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

@end
