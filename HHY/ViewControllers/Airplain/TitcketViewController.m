//
//  TitcketViewController.m
//  HHY
//
//  Created by chenguangjiang on 14-11-19.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "TitcketViewController.h"
#import "TicketModel.h"
#import "TicketCell.h"
#import "WriteOrderViewController.h"
#import "DayModel.h"
@interface TitcketViewController ()

@end

@implementation TitcketViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self initNav:@"查询结果"];
    [self createScreen];
    [self createHttpre];
    
    self.dataArray = [[NSMutableArray alloc] init];
    self.isTimeUp = YES;
    self.isPriceDown = YES;
}

-(void)createScreen
{
  
    _timeLable = [AffUIToolBar lableCgrectmake:CGRectMake(5, 0, 120, 30) lableNametext:self.dateString];
    [self.view addSubview:_timeLable];
    _timeLable.textColor = [JJDevice colorWithR:145 G:145 B:145 A:1];
    _timeLable.textAlignment = NSTextAlignmentLeft;
    _timeLable.font = FONT_14;
    
    UILabel *lable2 = [AffUIToolBar lableCgrectmake:CGRectMake(135, 0, 80, 30) lableNametext:self.start_endPoint];
    [self.view addSubview:lable2];
    lable2.textColor = [JJDevice colorWithR:145 G:145 B:145 A:1];
    lable2.textAlignment = NSTextAlignmentLeft;
    lable2.font = FONT_14;
    
    _countLable = [AffUIToolBar lableCgrectmake:CGRectMake(240, 0, 60, 30) lableNametext:@"共 0班次"];
    [self.view addSubview:_countLable];
    _countLable.textColor = [JJDevice colorWithR:145 G:145 B:145 A:1];
    _countLable.textAlignment = NSTextAlignmentCenter;
    _countLable.font = FONT_14;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (iPhone5) {
        [_tableView setFrame:CGRectMake(0, 30, 320, 568-64-65)];
        
    }else{
        [_tableView setFrame:CGRectMake(0, 30, 320, 480-64-65)];
    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    CGFloat height;
    if (iPhone5) {
        height = 568-64-39;
    }else{
        height = 480-64-39;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, height, 320, 39)];
    view.backgroundColor = [UIColor clearColor];
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
    
    NSArray *array = @[@"timeUp", @"preDay", @"nextDay", @"priceDown"];
    for (int i=0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*80, 0, 80, 39);
        [button setBackgroundImage:[UIImage imageNamed:[array objectAtIndex:i]] forState:UIControlStateNormal];
        //        [button setTitleColor:[JJDevice colorWithR:140 G:140 B:140 A:1] forState:UIControlStateNormal];
        button.tag = 1000+i;
        
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
}

-(void)btnClick:(UIButton *)button
{
    NSInteger index = button.tag - 1000;
    
    if (index == 0) {
        if (self.isTimeUp) {
            [self sortTimeArray:0];
            [button setBackgroundImage:[UIImage imageNamed:@"timeDown"] forState:UIControlStateNormal];
        }else{
            [self sortTimeArray:1];
            [button setBackgroundImage:[UIImage imageNamed:@"timeUp"] forState:UIControlStateNormal];
        }
        self.isTimeUp = !self.isTimeUp;
    }else if (index == 1){
        NSString* timeStr = [NSString stringWithFormat:@"%@ 00:00:00", self.dateModel.description];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:timeStr];
        double time = -16*3600;
        NSDate *xuyaoDate = [[NSDate alloc] initWithTimeInterval:time sinceDate:date];
        [self.dateModel anayse:xuyaoDate];
        
        NSDate *nowDate = [NSDate date];
        DayModel *tempModel = [[DayModel alloc] init];
        [tempModel anayse:nowDate];
        NSLog(@"%d", [self.dateModel comPareOtherDay:tempModel]);
        if ([self.dateModel comPareOtherDay:tempModel] == UIDayModelBefore) {
            [Utils alertWithTitle:@"不能比当前时间更早" message:nil];
            return;
        }
        
        if ([[LoginModel shareInstace] getIsWangfan] && [[LoginModel shareInstace] getISSelectTicket]) {
            if ([self.dateModel comPareOtherDay:[[LoginModel shareInstace] getStartDateModel]] == UIDayModelBefore) {
                [Utils alertWithTitle:@"返程时间不能比开始时间更早" message:nil];
                return;
            }
        }
        
        
        NSMutableString *str = [[NSMutableString alloc] initWithString:self.ticketURL];
        [str replaceCharactersInRange:NSMakeRange(str.length-2-self.dateModel.time.length, self.dateModel.time.length) withString:self.dateModel.time];
        self.ticketURL = str;
        [self createHttpre];
    }else if (index == 2){
        NSString* timeStr = [NSString stringWithFormat:@"%@ 00:00:00", self.dateModel.description];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:timeStr];
        NSDate *xuyaoDate = [[NSDate alloc] initWithTimeInterval:(double)32*3600 sinceDate:date];
        [self.dateModel anayse:xuyaoDate];
        
        if ([[LoginModel shareInstace] getIsWangfan] && [[LoginModel shareInstace] getISSelectTicket]==NO) {
            if ([self.dateModel comPareOtherDay:[[LoginModel shareInstace] getDateModel]] == UIDayModelAfter) {
                [Utils alertWithTitle:@"返程开始时间不能超过返程日期" message:nil];
                return;
            }
        }
        NSMutableString *str = [[NSMutableString alloc] initWithString:self.ticketURL];
        [str replaceCharactersInRange:NSMakeRange(str.length-2-self.dateModel.time.length, self.dateModel.time.length) withString:self.dateModel.time];
        self.ticketURL = str;
        [self createHttpre];
    }else if (index == 3){
        if (self.isPriceDown) {
            [self sortPriceArray:1];
            [button setBackgroundImage:[UIImage imageNamed:@"priceUp"] forState:UIControlStateNormal];
        }else{
            [self sortPriceArray:0];
            [button setBackgroundImage:[UIImage imageNamed:@"priceDown"] forState:UIControlStateNormal];
        }
        self.isPriceDown = !self.isPriceDown;
    }
    [_tableView reloadData];
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


-(void)createHttpre
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] queryAirTicket:self.ticketURL block:^(NSError *error, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            [self.dataArray removeAllObjects];
            [self jiexishuju:data];
            if (self.dataArray && self.dataArray.count>0) {
                _countLable.text = [NSString stringWithFormat:@"共%d班次", self.dataArray.count];
                NSArray *array = [self.dateModel.description componentsSeparatedByString:@"-"];
                _timeLable.text = [NSString stringWithFormat:@"%@年%@月%@日",[array objectAtIndex:0], [array objectAtIndex:1], [array objectAtIndex:2]];
            }
            [_tableView reloadData];
        }
    }];
}

-(void)jiexishuju:(NSArray *)array
{
    if (array.count>0) {
        for (int i=0; i<array.count; i++) {
            NSDictionary *temp = [array objectAtIndex:i];
            TicketModel *tickmodel = [[TicketModel alloc] initWithDictionary:temp error:nil];
            //[tickmodel anasyDict:temp];
            [tickmodel paixu];
            [self.dataArray addObject:tickmodel];
        }
    }
}
#pragma tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TicketCell" owner:nil options:nil] lastObject];
    }
    TicketModel *model = [self.dataArray objectAtIndex:indexPath.row];
    model.flyTime = [[[model.flyTime substringToIndex:2] stringByAppendingString:@":"] stringByAppendingString:[model.flyTime substringFromIndex:model.flyTime.length-2]];
    model.arriveTime = [[[model.arriveTime substringToIndex:2] stringByAppendingString:@":"] stringByAppendingString:[model.arriveTime substringFromIndex:model.arriveTime.length-2]];
    cell.timeLable.text = [[model.flyTime stringByAppendingString:@"-"] stringByAppendingString:model.arriveTime];
    cell.timeLable.font = FONT_14;
    cell.destLable.text = [[[model.adepName substringToIndex:model.adepName.length-2] stringByAppendingString:@"-"] stringByAppendingString:[model.destName substringToIndex:model.destName.length-2]];
    cell.destLable.textColor = [JJDevice colorWithR:81 G:81 B:81 A:1];
    cell.destLable.font = FONT_12;
    
    cell.nameLable.text = [NSString stringWithFormat:@"%@  %@%@", model.airLineName, model.airLineCode, model.fltNo];
    cell.nameLable.textColor = [JJDevice colorWithR:151 G:151 B:151 A:1];
    cell.nameLable.font = FONT_12;
    
    cell.typeLable.text = model.planeModel;
    cell.typeLable.textColor = [JJDevice colorWithR:151 G:151 B:151 A:1];
    cell.typeLable.font = FONT_12;
    
    if ([self.shippingspaceType isEqualToString:@"Y"]) {
        cell.zekouLable.text = @"经济舱";
    }else if([self.shippingspaceType isEqualToString:@"C"]){
        cell.zekouLable.text = @"商务舱";
    }else{
        cell.zekouLable.text = @"头等舱";
    }
    
    cell.zekouLable.textColor = [JJDevice colorWithR:151 G:151 B:151 A:1];
    cell.zekouLable.font = FONT_12;
    
    
    //判断价格信息是否为空
    if([model.minPrice objectForKey:@"disAmt"]) {
        cell.priceLable.text = [NSString stringWithFormat:@"¥ %@",[model.minPrice objectForKey:@"disAmt"]];
    } else {
        cell.priceLable.text = @"价格出错";
    }
    cell.priceLable.textColor = [JJDevice colorWithR:102 G:155 B:217 A:1];
    cell.priceLable.font = FONT_14;
    
    float num = [[model.minPrice objectForKey:@"disAmt"] floatValue]/[[model.maxPrice objectForKey:@"disAmt"] floatValue];
    if (num==1) {
        cell.dazheLable.text = @"全价";
    }else if (isnan(num)) {
        cell.dazheLable.text = @"";
    } else
        cell.dazheLable.text = [NSString stringWithFormat:@"%.1f折", num*10];
    
    cell.dazheLable.textColor = [JJDevice colorWithR:166 G:18 B:18 A:1];
    cell.dazheLable.font = FONT_14;
    return cell;
}

#pragma tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WriteOrderViewController *wvc = [[WriteOrderViewController alloc] init];
    wvc.currentModel = [self.dataArray objectAtIndex:indexPath.row];
    wvc.start_endPoint = self.start_endPoint;
    wvc.dateModel = self.dateModel;
    wvc.shippingspaceType = self.shippingspaceType;
    [self.navigationController pushViewController:wvc animated:YES];
}

#pragma mark -- sort dataArray
//0为升序 1为降序
-(void)sortTimeArray:(NSInteger)index
{
    NSLog(@"%ld", (unsigned long)self.dataArray.count);
    for (int i=0; i<self.dataArray.count-1; i++) {
        for (int j=0; j<self.dataArray.count-i-1; j++) {
            TicketModel *model1 = [self.dataArray objectAtIndex:j];
            TicketModel *model2 = [self.dataArray objectAtIndex:j+1];
            if (index==0) {
                if ([self changeTimeToInt:model1.flyTime] > [self changeTimeToInt:model2.flyTime]) {
                    [self.dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }else{
                if ([self changeTimeToInt:model1.flyTime] < [self changeTimeToInt:model2.flyTime]) {
                    [self.dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
    }
}

-(void)sortPriceArray:(NSInteger)index
{
    for (int i=0; i<self.dataArray.count-1; i++) {
        for (int j=0; j<self.dataArray.count-i-1; j++) {
            TicketModel *model1 = [self.dataArray objectAtIndex:j];
            TicketModel *model2 = [self.dataArray objectAtIndex:j+1];
            if (index==0) {
                if ([[model1.minPrice objectForKey:@"disAmt"] integerValue] > [[model2.minPrice objectForKey:@"disAmt"] integerValue]) {
                    [self.dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }else{
                if ([[model1.minPrice objectForKey:@"disAmt"] integerValue] < [[model2.minPrice objectForKey:@"disAmt"] integerValue]) {
                    [self.dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
    }
}
-(NSInteger)changeTimeToInt:(NSString *)string
{
    NSInteger count = 0;
    if ([string rangeOfString:@":"].length > 0) {
        NSArray *array = [string componentsSeparatedByString:@":"];
        count = [[array objectAtIndex:0] integerValue]*100+[[array objectAtIndex:1] integerValue];
    }else{
        count = [string integerValue];
    }
    return count;
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
