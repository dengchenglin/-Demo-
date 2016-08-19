//
//  AddPlainRangeViewController.m
//  HHY
//
//  Created by jiangjun on 14-5-21.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//
#import "AddPlainRangeViewController.h"
#import "PlainRangeCell.h"
#import "LinkPeopleCell.h"
#import "AirPersonCell.h"
#import "TicketAndDayModel.h"
#import "DayModel.h"
#import "TicketModel.h"
#import "CustomView.h"
#import "AddAirTicketViewController.h"
#import "LoginViewController.h"
#import "Passenger.h"
#import "LinkPeopleModel.h"
#import "TicketPayViewController.h"
#import "MyTicketViewController.h"
#import "PersonModel.h"

/*儿童机票的打折规定：机票价的一半+燃油的一半*/

@interface AddPlainRangeViewController ()
{
    UIButton *numButton;
    LinkPeopleCell *LinkPcell;
    
    double totalPrice;
}
@property (nonatomic,retain)PersonModel *model;
@end

@implementation AddPlainRangeViewController
static NSMutableArray *airPlainRangeArray;
static NSMutableArray *airPeopleArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init
{
    if (self = [super init]) {
        if (!airPlainRangeArray) {
            airPlainRangeArray = [[NSMutableArray alloc] init];
        }
        
        if (!airPeopleArray) {
            airPeopleArray = [[NSMutableArray alloc] init];
        }
        
    }
    return self;
}

-(void)addOneAirPlain:(id)obj
{
    if (![airPlainRangeArray containsObject:obj]) {
        [airPlainRangeArray addObject:obj];
    }
}

-(void)addOneAirPeople:(id)obj
{
    if (![airPeopleArray containsObject:obj]) {
        [airPeopleArray addObject:obj];
    }
}

-(void)removeAllArray
{
    [airPeopleArray removeAllObjects];
    [airPlainRangeArray removeAllObjects];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initNav:@"填写订单"];
    self.allCount = 0;
    totalPrice = 0;

    [self createScreen];
    int count = 0;
    for (TicketAndDayModel *obj in airPlainRangeArray) {
        TicketModel *tkmodel = obj.ticketModel;
        count += [[obj.dictAmi objectForKey:@"disAmt"] intValue];
        count += tkmodel.departFee.intValue;
        count += tkmodel.fuelFee.intValue;
    }
    
    totalPrice += count;
    
    _linkPeople = [[LinkPeopleModel alloc] init];
    
    if ([[LoginModel shareInstace] getOrderTicketState]) {
        [[LoginModel shareInstace] setOrderTicketState:NO];
    }
    
    _priceLable.text = [NSString stringWithFormat:@"订单总价:￥%.2f",totalPrice];
    _priceLable.textColor = [UIColor whiteColor];
    
    [self createData];
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
    if (iPhone5) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568-64-50) style:UITableViewStyleGrouped];
    }else{
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-64-50) style:UITableViewStyleGrouped];
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
 
    
    UIView *view = [[UIView alloc] init];
    view.userInteractionEnabled = YES;
    
    if (iPhone5) {
        view.frame = CGRectMake(0, 568-64-50, 320, 50);
    }else{
        view.frame = CGRectMake(0, 480-64-50, 320, 50);
    }
    
    [self.view addSubview:view];
    view.backgroundColor = [JJDevice colorWithR:224 G:138 B:34 A:1];
    _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 230, 50)];
    _priceLable.textColor = [UIColor whiteColor];
    _priceLable.textAlignment = NSTextAlignmentCenter;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"gaiqi"] forState:UIControlStateNormal];
    button.frame = CGRectMake(230, 0, 90, 50);
    [button setBackgroundImage:[UIImage imageNamed:@"gaiqiBTN"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(getOrder) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_priceLable];
    [view addSubview:button];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resgiterKboard)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
    
}

-(void)createData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] queryOneUser:^(NSError *error, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            self.model = data;
            [_tableView reloadData];
        }
    }];
}

#pragma tableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return airPlainRangeArray.count;
    }else if(section == 1){
        return airPeopleArray.count;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    
    if (indexPath.section == 0) {
        PlainRangeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PlainRangeCell" owner:self options:nil] lastObject];
            [cell initialization];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        TicketAndDayModel *model = [airPlainRangeArray objectAtIndex:indexPath.row];
        DayModel *dayModel = model.dayModel;
        TicketModel *tkModel = model.ticketModel;
        cell.dateLable.text = dayModel.description;
        cell.comPanyLable.text = [NSString stringWithFormat:@"%@%@%@(%@)", tkModel.airLineName, tkModel.airLineCode, tkModel.fltNo, tkModel.planeModel];
        cell.startTimeLable.text = tkModel.flyTime;
        cell.endTimeLable.text = tkModel.arriveTime;
        cell.startAirLable.text = [NSString stringWithFormat:@"%@  %@", tkModel.adepName, tkModel.arriveTerminal];
        cell.endAirPlain.text = [NSString stringWithFormat:@"%@  %@", tkModel.destName, tkModel.departTerminal];
        NSString *strShipType = nil;
        if ([model.shipType isEqualToString:@"Y"]) {
            strShipType = @"经济舱";
        }else if ([model.shipType isEqualToString:@"C"]){
            strShipType = @"商务舱";
        }else if ([model.shipType isEqualToString:@"F"]){
            strShipType = @"头等舱";
        }
        float value = [[model.dictAmi objectForKey:@"disAmt"] floatValue]/[[tkModel.maxPrice objectForKey:@"disAmt"] floatValue]*10;
        if (value!=10) {
            cell.priceAndTypeLable.text = [NSString stringWithFormat:@"%@ %.1f折", strShipType, value];
        }else{
            cell.priceAndTypeLable.text = [NSString stringWithFormat:@"%@ 全价", strShipType];
        }
        
        cell.priceLable.text = [NSString stringWithFormat:@"¥%@",[model.dictAmi objectForKey:@"disAmt"]];
        cell.suifeiValue.text = [NSString stringWithFormat:@"¥%d", [tkModel.fuelFee intValue]+[tkModel.departFee intValue]];
        cell.addAirRangeBTN.tag = indexPath.row;
        [cell.addAirRangeBTN addTarget:self action:@selector(deleteAirRange:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if(indexPath.section ==1){
        AirPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AirPersonCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell chushihua];
        }
        Passenger *model = [airPeopleArray objectAtIndex:indexPath.row];
        cell.nameText.text = model.name;
        cell.inderfidyLable.text = model.zjh;
        [cell.numberBt addTarget:self action:@selector(selectNumber:) forControlEvents:UIControlEventTouchUpInside];
        cell.numberBt.tag = indexPath.row + 3000;
        cell.priceLable.text = [NSString stringWithFormat:@"¥%d", [model getbaoxianfei]];

        
        [cell.numberBt setTitle:[NSString stringWithFormat:@"%d", [model getbaoxianfei]/20] forState:0];


        cell.deleteAirpBt.tag = indexPath.row + 200;
        [cell.deleteAirpBt addTarget:self action:@selector(deleteOneAirpeople:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        LinkPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LinkPeopleCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            LinkPcell = cell;
        }
        cell.nameTF.delegate = self;
        cell.phoneTF.delegate = self;
        cell.emainTF.delegate = self;
        
  
    if(self.model)
    {
        cell.nameTF.text = [_model.staffName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        cell.phoneTF.text = _model.mobile;
        cell.emainTF.text = _model.email;
    }
        
        if ([_linkPeople.name length]) {
            cell.nameTF.text = _linkPeople.name;
        }
        
        if ([_linkPeople.mobile length]) {
            cell.phoneTF.text = _linkPeople.mobile;
        }
        
        if ([_linkPeople.email length]) {
            cell.emainTF.text = _linkPeople.email;
        }
     
        _linkPeople.name = cell.nameTF.text;
        _linkPeople.mobile = cell.phoneTF.text;
        _linkPeople.email = cell.emainTF.text;

        return cell;
    }
}

#pragma tableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 105.0f;
    }else if(indexPath.section == 1){
        return 77.0f;
    }else{
        return 90.0f;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    UILabel *lable = [AffUIToolBar lableCgrectmake:CGRectMake(10, 0, 100, 25) lableNametext:@""];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.textColor = [JJDevice colorWithR:145 G:133 B:120 A:1];
    lable.font = [UIFont systemFontOfSize:18];
    [view addSubview:lable];
    view.userInteractionEnabled = YES;
    view.backgroundColor = [UIColor clearColor];
    
    if (section==1) {
        lable.text = @"乘机人信息";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(280, 7, 25, 19);
        [button addTarget:self action:@selector(addAirPlainPeople) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[UIImage imageNamed:@"air_fillorder_commonadd"] forState:UIControlStateNormal];
        [view addSubview:button];
        return view;
    }else if(section == 0){
        lable.text = @"航班信息";
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(250, 1, 50, 25);
        [button setTitle:@"+航班" forState:UIControlStateNormal];
        button.titleLabel.font = FONT_14;
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addAirRange) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }else{
        lable.text = @"联系人信息";
    }
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0f;
}

-(void)addAirPlainPeople
{
    if ([[HHYNetworkEngine sharedInstance] checkLogin]) {
        ChangYongPersonViewController *chvc = [[ChangYongPersonViewController alloc] init];
        chvc.isOrderTicket = YES;
        chvc.target = self;
        [self.navigationController pushViewController:chvc animated:YES];
    }else{
        LoginViewController *lvc = [[LoginViewController alloc] init];
        UINavigationController *lnc = [[UINavigationController alloc] initWithRootViewController:lvc];
        lvc.isDismiss = YES;
        [self presentViewController:lnc animated:YES completion:nil];
    }
}

-(void)deleteAirRange:(UIButton *)button
{
    
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"确定要删除此航班" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alt.tag = button.tag + 200;
    alt.delegate = self;
    [alt show];

}

-(void)deleteOneAirpeople:(UIButton *)button
{
   
    
    
    [airPeopleArray removeObjectAtIndex:button.tag-200];
    [_tableView reloadData];
    
    //总价计算
    self.allCount = 0;
    [self countPrice];
    
    _priceLable.text = [NSString stringWithFormat:@"订单总价:￥%.2f",(double)self.allCount];
}

-(void)addAirRange
{
    [_tableView reloadData];
    AddAirTicketViewController *avc = [[AddAirTicketViewController alloc] init];
    [self.navigationController pushViewController:avc animated:YES];
}

-(void)addCJR:(Passenger *)model
{
    BOOL haveThisOne = NO;
    for (Passenger *model1 in airPeopleArray) {
        if ([model.zjh isEqualToString:model1.zjh]) {
            haveThisOne = YES;
            
            break;
        }
    }
    
    if (!haveThisOne) {
        [airPeopleArray addObject:model];
        
        [_tableView reloadData];
    }
    
    /*
    for (int i=[baoxianFee count]; i<[airPeopleArray count]; i++) {
        [baoxianFee addObject:@"0"];
    }*/
    //总价计算
    self.allCount = 0;
    [self countPrice];
    
    _priceLable.text = [NSString stringWithFormat:@"订单总价:￥%.2f",(double)self.allCount];
}

-(void)playPhone
{
    
}


- (NSDictionary *)dicMake
{
    NSDictionary *dicCont = [[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"company",@"0",@"dept",@"fgbcgh@qq.clom",@"email",@"15686555555",@"mobile",@"成就感",@"name",@"10",@"orderNature",@"0",@"otherNeed",@"0",@"payType",@"0",@"phoneNo",@"11",@"profession",@"0",@"reason",@"0",@"secondDept",@"311",@"source", nil];
    
//    NSDictionary *dicCont1 = [[NSDictionary alloc] initWithObjectsAndKeys:dicCont,@"contact", nil];
    
    NSDictionary *dicAir = [[NSDictionary alloc] initWithObjectsAndKeys:@"NN",@"actionCode",@"PEK",@"adepCity",@"07:35",@"adepTime",@"MU",@"airCode",@"480",@"bookPrice",@"50",@"capexFee",@"1",@"country",@"PVG",@"deptCity",@"09:40",@"deptTime",@"2015-3-19",@"flightDate",@"0",@"flyMileage",@"MU5183",@"flyNo",@"70",@"fuelFee",@"1130",@"fullPrice",@"1130",@"issuePrice",@"480",@"lowPrice",@"0",@"notLowReason",@"Numberofpeople",@"number",@"Y",@"parentSpace",@"321",@"planeModel",@"Z",@"space",@"0",@"stop",@"T2--T1",@"terminal", nil];
    
    NSArray *array = [[NSArray alloc] initWithObjects:dicAir, nil];
//    NSDictionary *dicAir1 = [[NSDictionary alloc] initWithObjectsAndKeys:array,@"airWay", nil];
    
    
    NSDictionary *dicP = [[NSDictionary alloc] initWithObjectsAndKeys:@"1990-14-17",@"birthday",@"50",@"capexFee",@"0",@"costCenter",@"0",@"empno",@"70",@"fuelFee",@"142322195612141247",@"idNo",@"40",@"insureFee",@"0",@"mileageCard",@"15683893589",@"mobile",@"测试",@"name",@"0",@"prefer",@"1130",@"price",@"CR",@"type", nil];
    NSArray *array1 = [[NSArray alloc] initWithObjects:dicP, nil];
//    NSDictionary *dicp1 = [[NSDictionary alloc] initWithObjectsAndKeys:array1,@"passenger", nil];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:dicCont,@"contact",array,@"airWay",array1,@"passenger", nil];

    return dic;
}

-(void)getOrder
{
//    string = [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSDictionary *dicJson = [self getJasonDict];
    
    if (!dicJson) {
        return ;
    }
    
    NSString *string = [dicJson jsonEncodedKeyValueString];

    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:string,@"jsonOrder", nil];
    NSLog(@"dic = %@", [dic description]);
    
    
 
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] saveOrder:string block:^(NSError *error, id data) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [[LoginModel shareInstace] setOrderTicketState:YES];
        if (!error) {
            NSLog(@"data = %@", [data description]);
            NSString *orderNumber = [data objectForKey:@"orderNo"];
            

            if ([orderNumber rangeOfString:@","].length > 0) {
                
                MyTicketViewController *tvc = [[MyTicketViewController alloc] init];
                [self.navigationController pushViewController:tvc animated:YES];
            }else{
                TicketPayViewController *tpvc = [[TicketPayViewController alloc] init];
                tpvc.jasonDict = dicJson;
                tpvc.airPlainArray = airPlainRangeArray;
                tpvc.passengerArray = airPeopleArray;
                tpvc.allCount = self.allCount;
                self.allCount = 0;
                tpvc.orderNum = orderNumber;
                [self.navigationController pushViewController:tpvc animated:YES];
            }
        } else {
            UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"订单提交失败，请稍候再试" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [altView show];
        
        }
    }];
}

-(NSDictionary *)getJasonDict
{
    
    self.allCount = 0;
    
    _linkPeople.name = LinkPcell.nameTF.text;
    _linkPeople.mobile = LinkPcell.phoneTF.text;
    _linkPeople.email = LinkPcell.emainTF.text;
    
    if ([_linkPeople.name length]==0) {
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请补全联系人信息" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        altView.tag = 121;
        [altView show];
        
        return nil;
    }
    
    if ([_linkPeople.mobile length]==0) {
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请补全联系人信息" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        altView.tag = 122;
        [altView show];
        
        return nil;
    }
    
    if ([_linkPeople.email length]==0) {
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请补全联系人信息" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        altView.tag = 123;
        [altView show];
        
        return nil;
    }
    
    NSMutableDictionary *retdict = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *allWayDict = [[NSMutableDictionary alloc] init];
    NSDictionary *linkPeopleDict = [self.linkPeople getJason];
    NSMutableArray *airWayArray = [[NSMutableArray alloc] init];
    NSMutableArray *passengerArray = [[NSMutableArray alloc] init];
    
    if ([airPlainRangeArray count]==0) {
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未选择机票，请选择航班！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altView show];
        
        return nil;
    }
    
    //航班信息
    for (TicketAndDayModel *model in airPlainRangeArray) {
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[model getJasonDict]];
        [airWayArray addObject:dict];
    }

    
    if ([airPeopleArray count]==0) {
        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请添加乘机人信息!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        altView .tag = 133;
        [altView show];
        return nil;
    }
    for (Passenger *model in airPeopleArray) {
        if ([model.note isEqualToString:@"CHIRD"]  || [model.note isEqualToString:@"CHILD"]) {
            NSInteger allPriceCount = 0;
            NSInteger allFuelFeeCount = 0;
            for (TicketAndDayModel *model in airPlainRangeArray) {
                allFuelFeeCount += [self changeNumTo10:[model.ticketModel.fuelFee intValue]];
                allPriceCount += [self changeNumTo10:[[model.ticketModel.maxPrice objectForKey:@"disAmt"] intValue]];
            }
            
            self.allCount += (allPriceCount + allFuelFeeCount);
            
            NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[model getJson:@"0" andAllfuel:[NSString stringWithFormat:@"%ld", (long)allFuelFeeCount] andAirPrice:[NSString stringWithFormat:@"%ld", (long)allPriceCount]]];
            [passengerArray addObject:dict];
        }else{
            NSInteger departFeeCount = 0;
            NSInteger fuelFeeCount = 0;
            NSInteger priceCount = 0;
            
            for (TicketAndDayModel *model in airPlainRangeArray) {
                departFeeCount += [model.ticketModel.departFee intValue];//基建
                fuelFeeCount += [model.ticketModel.fuelFee intValue];//燃油
                priceCount += [[model.dictAmi objectForKey:@"disAmt"] intValue];//机票
            }
            
            self.allCount += (departFeeCount + fuelFeeCount + priceCount);

            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:[model getJson:[NSString stringWithFormat:@"%ld", (long)departFeeCount] andAllfuel:[NSString stringWithFormat:@"%ld", (long)fuelFeeCount] andAirPrice:[NSString stringWithFormat:@"%ld", (long)priceCount]]];
            
//            [dict setValue:@"160" forKey:@"tax"];
            
            [passengerArray addObject:dict];
        }
        
        double baoxianFee1 = [model getbaoxianfei];
        self.allCount += baoxianFee1;
    }
    
    [allWayDict setValue:airWayArray forKeyPath:@"airWay"];
    [allWayDict setValue:passengerArray forKeyPath:@"passenger"];
    [allWayDict setValue:linkPeopleDict forKeyPath:@"contact"];
    [retdict setValue:allWayDict forKeyPath:@"jsonOrder"];
    return allWayDict;
}


- (void)countPrice
{
    for (Passenger *model in airPeopleArray) {
        if ([model.note isEqualToString:@"CHILD"]) {
            NSInteger allPriceCount = 0;
            NSInteger allFuelFeeCount = 0;
            for (TicketAndDayModel *model in airPlainRangeArray) {
//                allFuelFeeCount += [model.ticketModel.fuelFee intValue] /2;
//                allPriceCount += [[model.ticketModel.maxPrice objectForKey:@"disAmt"] intValue]/2;
                allFuelFeeCount += [self changeNumTo10:[model.ticketModel.fuelFee intValue]];
                allPriceCount += [self changeNumTo10:[[model.ticketModel.maxPrice objectForKey:@"disAmt"] intValue]];
            }
            self.allCount += (allPriceCount + allFuelFeeCount);
        }else{
            NSInteger departFeeCount = 0;
            NSInteger fuelFeeCount = 0;
            NSInteger priceCount = 0;
            
            for (TicketAndDayModel *model in airPlainRangeArray) {
                departFeeCount += [model.ticketModel.departFee intValue];//基建
                fuelFeeCount += [model.ticketModel.fuelFee intValue];//燃油
                priceCount += [[model.dictAmi objectForKey:@"disAmt"] intValue];//机票
            }
            
            self.allCount += (departFeeCount + fuelFeeCount + priceCount);
        }
        
        double baoxianFee1 = [model getbaoxianfei];
        self.allCount += baoxianFee1;
    }
}

-(NSInteger)changeNumTo10:(NSInteger)num
{
    if (num%20==0) {
        return num;
    }else{
        return (num/20+1)*10;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITableViewCell *cell;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        cell = (UITableViewCell *) textField.superview.superview;
        
    } else {
        // Load resources for iOS 7 or later
        cell = (UITableViewCell *) textField.superview.superview.superview;
        // TextField -> UITableVieCellContentView -> (in iOS 7!)ScrollView -> Cell!
    }
    self.textFieldIndexPath = [_tableView indexPathForCell:cell];
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    NSValue* keyboardFrameValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrame = [keyboardFrameValue CGRectValue];
    keyboardFrame = [self.view convertRect:keyboardFrame fromView:nil];
    
    CGFloat tableViewHeight = CGRectGetMinY(keyboardFrame) - CGRectGetMinY(self.view.bounds);
    
    // Get the duration of the animation.
    NSValue* animationDurationValue = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGRect cellRect = [_tableView rectForRowAtIndexPath:self.textFieldIndexPath];
    CGFloat minCellOffsetY = CGRectGetMaxY(cellRect) - tableViewHeight + 10.0; // Add a small margin below the row
    CGFloat maxCellOffsetY = CGRectGetMinY(cellRect) - 10.0; // Add a small margin above the row
    maxCellOffsetY = MAX(0.0, maxCellOffsetY);
    CGFloat maxContentOffsetY = _tableView.contentSize.height - tableViewHeight;
    CGFloat scrollOffsetY = _tableView.contentOffset.y;
    if (scrollOffsetY < minCellOffsetY)
    {
        scrollOffsetY = minCellOffsetY;
    }
    else if (scrollOffsetY > maxCellOffsetY)
    {
        scrollOffsetY = maxCellOffsetY;
    }
    scrollOffsetY = MIN(scrollOffsetY, maxContentOffsetY);
    CGPoint updatedContentOffset = CGPointMake(_tableView.contentOffset.x, scrollOffsetY);
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         _tableView.contentOffset = updatedContentOffset;
                     }
                     completion:^(BOOL finished) {
                         _tableView.frame = CGRectMake(CGRectGetMinX(_tableView.frame), CGRectGetMinY(_tableView.frame),
                                                           CGRectGetWidth(_tableView.frame), tableViewHeight);
                     }];
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    // Get the duration of the animation.
    NSValue *animationDurationValue = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    CGPoint updatedContentOffset = _tableView.contentOffset;
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView animateWithDuration:animationDuration
                     animations:^{
                     }
                     completion:^(BOOL finished) {
                         //_tableView.frame = self.view.bounds;
                         if (iPhone5) {
                             _tableView.frame = CGRectMake(0, 0, 320, 568-64-70);
                         }else{
                             _tableView.frame = CGRectMake(0, 0, 320, 480-64-70);
                         }
                         _tableView.contentOffset = updatedContentOffset;
                     }
     ];
}

-(void)selectNumber:(UIButton *)button
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"0", @"1", @"2", @"3", @"4", @"5", nil];
    sheet.tag = button.tag + 1000;
    [sheet showInView:self.view];
    numButton = button;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSArray *array = @[@"0", @"1", @"2", @"3", @"4", @"5"];
    Passenger *passenger = [airPeopleArray objectAtIndex:actionSheet.tag-4000];
    [passenger setBaoxianfei:[[array objectAtIndex:buttonIndex] integerValue]*20];
    [_tableView reloadData];
    
    [numButton setTitle:[array objectAtIndex:buttonIndex]  forState:0];
    
    
    //总价计算
    self.allCount = 0;
    [self countPrice];
    
    _priceLable.text = [NSString stringWithFormat:@"订单总价:￥%.2f",(double)self.allCount];
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
    if (alertView.tag==133) {
        //添加乘机人
        [self addAirPlainPeople];
    } else if (alertView.tag==121) {
        [LinkPcell.nameTF becomeFirstResponder];
    } else if (alertView.tag==122) {
        [LinkPcell.phoneTF becomeFirstResponder];
    } else if (alertView.tag==123) {
        [LinkPcell.emainTF becomeFirstResponder];
    } else if (alertView.tag==181) {
        if (buttonIndex==0) {
            [airPlainRangeArray removeAllObjects];
            [airPeopleArray removeAllObjects];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if (alertView.tag==182) {
        if (buttonIndex==0) {
            [airPlainRangeArray removeAllObjects];
            [airPeopleArray removeAllObjects];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    if(alertView.tag >= 200)
    {
        if(buttonIndex == 1)
        {
            if(airPlainRangeArray.count > alertView.tag - 200)
            {
                [airPlainRangeArray removeObjectAtIndex:alertView.tag - 200];
                [_tableView reloadData];
            
        
                //总价计算
                self.allCount = 0;
                [self countPrice];
        
                _priceLable.text = [NSString    stringWithFormat:@"订单总价:￥%.2f",(double)self.allCount];
            }
        }
    }

}

-(void)resgiterKboard
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"airHiddenkeyboard" object:nil];
}


//重写
-(void)reback
{
    UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您有订单尚未写完，是否离开当前界面？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    altView.tag = 181;
    [altView show];
}

- (void)returnRoot
{
    UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您有订单尚未写完，是否离开当前界面？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    altView.tag = 182;
    [altView show];
}

@end
