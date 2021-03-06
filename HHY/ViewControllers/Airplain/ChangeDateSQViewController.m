//
//  ChangeDateSQViewController.m
//  HHY
//
//  Created by jiangjun on 14-6-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "ChangeDateSQViewController.h"
#import "FootView.h"
#import "GaiQiOrderCell.h"
#import "AirPlainSelectedCell.h"
#import "PassengerSelectCell.h"
#import "OrderDetailModel.h"
#import "PassengerDetailModel.h"
#import "FlightsDetailModel.h"

@interface ChangeDateSQViewController ()<UITextViewDelegate>

@end

@implementation ChangeDateSQViewController

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
    self.edgesForExtendedLayout = UIRectEdgeNone;    [self initNav:@"改期申请"];
    [self createScreen];
    [self createFootView];
}

-(void)createScreen
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (iPhone5) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -10, 320, 568-64) style:UITableViewStyleGrouped];
    }else{
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -10, 320, 480-64) style:UITableViewStyleGrouped];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddentextView)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
}


-(void)createFootView
{
    _footView = [[FootView alloc] initWithFrame:CGRectMake(0, 0, 320, 160)];
    [_footView.button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    _footView.textView.delegate = self;
    _footView.lable1.text = @"改期原因";
    [_footView.button setTitle:@"提交改期申请" forState:UIControlStateNormal];
    _tableView.tableFooterView = _footView;
}

#pragma tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.dataModel.flightArray.count;
    }else if (section == 2){
        return self.dataModel.passengerArray.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GaiQiOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GaiQiOrderCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GaiQiOrderCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.orderNum.text = self.dataModel.orderNumber;
        cell.priceLable.text = [NSString stringWithFormat:@"¥ %@", self.allCountPrice];
        return cell;
    }else if (indexPath.section ==1){
        AirPlainSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AirPlainSelectedCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AirPlainSelectedCell" owner:self options:nil] lastObject];
            [cell.cellSelect setBackgroundImage:[UIImage imageNamed:@"notrember"] forState:UIControlStateNormal];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        FlightsDetailModel *model = [self.dataModel.flightArray objectAtIndex:indexPath.row];
        cell.startDate.text = [NSString stringWithFormat:@"%@  %@%@  %@", [[model.departureTime componentsSeparatedByString:@" "] objectAtIndex:0], model.airWayName, model.flightnumber, [JJDevice shipType:model.cabin]];
        cell.placeLable.text = [NSString stringWithFormat:@"%@ %@  --  %@ %@", model.orgCityCN, model.departureTime, model.desCityCN, model.arrivalTime];
        cell.jipiaoPlace.text = [NSString stringWithFormat:@"¥ %d", model.ticketPrice.intValue];
        cell.suiPlace.text = [NSString stringWithFormat:@"¥ %@", model.tax];
//        [cell.cellSelect addTarget:self action:@selector(selectFligth:) forControlEvents:UIControlEventTouchUpInside];
        cell.cellSelect.tag = 1000+indexPath.row;
        return cell;
    }else {
        PassengerSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PassengerSelectCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PassengerSelectCell" owner:self options:nil] lastObject];
            [cell.cellSelect setBackgroundImage:[UIImage imageNamed:@"notrember"] forState:UIControlStateNormal];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        PassengerDetailModel *model = [self.dataModel.passengerArray objectAtIndex:indexPath.row];
        cell.nameLable.text = model.name;
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"航空意外保险  %d份  共%@元", [model.insurance intValue]/20, model.insurance]];
        NSString *tempStr = [NSString stringWithFormat:@"航空意外保险  %d份  共", [model.insurance intValue]/20];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(tempStr.length, str.length-tempStr.length-1)];
        cell.pricelable.attributedText = str;
//        [cell.cellSelect addTarget:self action:@selector(selectPassenger:) forControlEvents:UIControlEventTouchUpInside];
        cell.cellSelect.tag = 2000+indexPath.row;
        return cell;
    }
}

#pragma tableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *array = @[@"", @"航班信息", @"乘机人信息"];
    if (section) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 20)];
        lable.text = [array objectAtIndex:section];
        lable.font = FONT_14;
        [view addSubview:lable];
        return view;
    }else
        return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section) {
        return 20.0f;
    }else
        return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 35.0f;
    }else if (indexPath.section == 1){
        return 110.0f;
    }else if (indexPath.section == 2){
        return 50.0f;
    }else
        return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //
    } else if (indexPath.section==1) {
        UIButton *bt = [[UIButton alloc] init];
        bt.tag = 1000 + indexPath.row;
        [self selectFligth:bt];
    } else if(indexPath.section==2){
        UIButton *bt = [[UIButton alloc] init];
        bt.tag = 2000 +indexPath.row;
        
        [self selectPassenger:bt];
    } else {
        
    }
    
    NSLog(@"%@%d",@"wuhah",indexPath.section);
}


#pragma mark -- TextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)selectFligth:(UIButton *)button
{
    FlightsDetailModel *model = [self.dataModel.flightArray objectAtIndex:button.tag-1000];
    if ([model getStateValue]) {
        [button setBackgroundImage:[UIImage imageNamed:@"notrember"] forState:UIControlStateNormal];
        [model setStateValue:NO];
    }else{
        [model setStateValue:YES];
        [button setBackgroundImage:[UIImage imageNamed:@"blueRemenber"] forState:UIControlStateNormal];
    }
}

-(void)selectPassenger:(UIButton *)button
{
    PassengerDetailModel *model = [self.dataModel.passengerArray objectAtIndex:button.tag-2000];
    if ([model getStateValue]) {
        [button setBackgroundImage:[UIImage imageNamed:@"notrember"] forState:UIControlStateNormal];
        [model setStateValue:NO];
    }else{
        [model setStateValue:YES];
        [button setBackgroundImage:[UIImage imageNamed:@"blueRemenber"] forState:UIControlStateNormal];
    }
}

-(void)btnClick
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:self.dataModel.orderNumber forKey:@"orderNo"];
    [dict setValue:self.dataModel.ticketState forKey:@"sid"];
    [dict setValue:self.footView.textView.text forKey:@"reason"];
    [dict setValue:@"" forKey:@"description"];
    [dict setValue:self.dataModel.email forKey:@"temail"];
    NSMutableString *passengerStr = [[NSMutableString alloc] init];
    for (PassengerDetailModel *model in self.dataModel.passengerArray) {
        if ([model getStateValue]) {
            [passengerStr appendString:model.sn];
            [passengerStr appendString:@"*"];
            
            NSLog(@"sn = %@", model.sn);
        }
    }
    
    if ([passengerStr length]==0) {
        //未选中乘机人--暂时默认选第一个
        PassengerDetailModel *model = [self.dataModel.passengerArray objectAtIndex:0];
        [passengerStr appendString:model.sn];
    }
    [dict setValue:[passengerStr substringToIndex:passengerStr.length-1] forKey:@"passenger"];
    
    NSMutableString *flightStr = [[NSMutableString alloc] init];
    for (FlightsDetailModel *model in self.dataModel.flightArray) {
        if ([model getStateValue]) {
            [flightStr appendString:model.sn];
            [flightStr appendString:@"*"];
        }
    }
    
    if ([flightStr length]==0) {
        //未选中改期机票
        FlightsDetailModel *model = [self.dataModel.flightArray objectAtIndex:0];
        [flightStr appendString:model.sn];
    }
    
    [dict setValue:[flightStr substringToIndex:flightStr.length-1] forKey:@"route"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] orderChange:dict block:^(NSError *error, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            NSLog(@"%@", data);
            
            if ([data isEqualToString:@"成功"]) {
                UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"提交申请成功，请等待审核结果！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [altView show];
            } else {
                UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"申请失败，请稍候再试！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [altView show];
            }
        } else {
            UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"申请失败，请稍候再试！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [altView show];
        }
    }];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(kScreenHeight < 568)
    {
        _tableView.contentOffset = CGPointMake(0, 240);
    }
    else
    {
        _tableView.contentOffset = CGPointMake(0, 150);
    }
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hiddentextView
{
    [_footView.textView resignFirstResponder];
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
