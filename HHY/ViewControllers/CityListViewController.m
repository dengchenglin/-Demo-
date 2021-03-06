//
//  CityListViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-28.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "CityListViewController.h"
#import "CustomButton.h"
#import "cityModel.h"
#define tempColor [JJDevice colorWithR:43 G:134 B:234 A:1]


@interface CityListViewController ()

@end

@implementation CityListViewController

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
    [self initNav:self.titleString];
    self.cityCNArray = [NSMutableArray array];
    self.cityCJArray = [NSMutableArray array];
    self.lableCJArray = [NSMutableArray array];
    self.lableCNArray = [NSMutableArray array];
    [self createScreen];
    isCN = YES;
    [self aslyArray];
    [self loadget];
    
}

-(void)aslyArray
{
    [self.lableCNArray addObject:@"当前城市"];
    [self.lableCNArray addObject:@"热门城市"];
    [self.lableCJArray addObject:@"当前城市"];
    [self.lableCJArray addObject:@"热门城市"];
    NSArray *nameArray1 = @[@"北京", @"上海", @"深圳", @"武汉", @"广州"];
    NSArray *codeArray1 = @[@"PEK", @"PVG", @"SZX", @"WUH", @"CAN"];
    NSArray *countryArray1 = @[@"China", @"China", @"China", @"China", @"China"];
    
    NSArray *nameArray2 = @[@"香港", @"东京", @"首尔", @"伦敦", @"吉隆坡"];
    NSArray *codeArray2 = @[@"HKG", @"TYO", @"SEL", @"LON", @"KUL"];
    NSArray *countryArray2 = @[@"China", @"Japan", @"Korea", @"UK", @"Malaysia"];
    
    NSMutableArray *tempArrayCN = [[NSMutableArray alloc] init];
    NSMutableArray *tempArrayCJ = [[NSMutableArray alloc] init];
    NSArray *temp = nil;
    if (self.needCity==nil) {
        CityModel *model = [[CityModel alloc] init];
        model.cityName = @"";
        model.codeName = @"";
        model.country = @"";
        temp = [[NSArray alloc] initWithObjects:self.needCity, nil];
    }else
        temp = [NSArray arrayWithObject:self.needCity];
    
    [self.cityCNArray addObject:temp];
    [self.cityCJArray addObject:temp];
    for (int i=0; i<5; i++) {
        CityModel *model1 = [[CityModel alloc] init];
        CityModel *model2 = [[CityModel alloc] init];
        model1.cityName = [nameArray1 objectAtIndex:i];
        model1.codeName = [codeArray1 objectAtIndex:i];
        model1.country = [countryArray1 objectAtIndex:i];
        model2.cityName = [nameArray2 objectAtIndex:i];
        model2.codeName = [codeArray2 objectAtIndex:i];
        model2.country = [countryArray2 objectAtIndex:i];
        [tempArrayCN addObject:model1];
        [tempArrayCJ addObject:model2];
    }
    [self.cityCNArray addObject:tempArrayCN];
    [self.cityCJArray addObject:tempArrayCJ];
}

-(void)createScreen
{
    NSArray *nameArray = @[@"国内城市", @"国际城市"];
    for (int i=0; i<2; i++) {
        CustomButton *button = [[CustomButton alloc] initWithFrame:CGRectMake(i*160, 0, 160, 40)];
        button.nameLable.text = [nameArray objectAtIndex:i];
        [self.view addSubview:button];
        button.tag = 100+i;
        if (i==0) {
            button.nameLable.textColor = tempColor;
            button.lineView.backgroundColor = tempColor;
        }
        [button addTarget:self action:@selector(changeLine:) forControlEvents:UIControlEventTouchUpInside];
        JJRelease(button);
    }
    if (iPhone5) {
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 568-50-65) style:UITableViewStyleGrouped];
    }else
        _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 480-50-65) style:UITableViewStyleGrouped];
    
    _tabView.delegate = self;
    _tabView.dataSource = self;
    [self.view addSubview:_tabView];
}

#pragma mark -- tableViewDatasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (isCN) {
        if (self.cityCNArray.count > 2) {
            return self.cityCNArray.count;
        }else{
            return 2;
        }
    }else{
        if (self.cityCJArray.count > 2) {
            return [self.cityCJArray count];
        }else{
            return 2;
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isCN) {
        return [[self.cityCNArray objectAtIndex:section] count];
    }else{
        return [[self.cityCJArray objectAtIndex:section] count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    CityModel *city = nil;
    if (isCN) {
        city = [[self.cityCNArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }else{
        city = [[self.cityCJArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    if ([city.country isEqualToString:@"China"]) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@(%@\\中国)", city.cityName, city.codeName];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@(%@\\%@)", city.cityName, city.codeName, city.country];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0f;
}

#pragma cellSelection
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isCN)
        self.currentCity = [[self.cityCNArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    else
        self.currentCity = [[self.cityCJArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (self.isStarting) {
        [self.target staringCity:self.currentCity];
    }else{
        [self.target endingCity:self.currentCity];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (isCN) {
        return [self.lableCNArray objectAtIndex:section];
    }else{
        return [self.lableCJArray objectAtIndex:section];
    }
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self addThreeObject:array];
    if (isCN) {
        for (int i=2; i<self.lableCNArray.count; i++) {
            [array addObject:[self.lableCNArray objectAtIndex:i]];
        }
    }else{
        for (int i=2; i<self.lableCJArray.count; i++) {
            [array addObject:[self.lableCJArray objectAtIndex:i]];
        }
    }
    return array;
}

-(void)addThreeObject:(NSMutableArray *)array
{
    [array removeAllObjects];
    for (int i=0; i<3; i++) {
        [array addObject:@""];
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

-(void)changeLine:(CustomButton *)button
{
    BOOL temp = isCN;
    if (button.tag == 100) {
        button.nameLable.textColor = tempColor;
        button.lineView.backgroundColor = tempColor;
        CustomButton *tempButton = (CustomButton *)[self.view viewWithTag:101];
        tempButton.nameLable.textColor = [UIColor blackColor];
        tempButton.lineView.backgroundColor = [UIColor clearColor];
        isCN = YES;
    }else{
        button.nameLable.textColor = tempColor;
        button.lineView.backgroundColor = tempColor;
        CustomButton *tempButton = (CustomButton *)[self.view viewWithTag:100];
        tempButton.nameLable.textColor = [UIColor blackColor];
        tempButton.lineView.backgroundColor = [UIColor clearColor];
        isCN = NO;
    }
    
    if (temp != isCN) {
        [_tabView reloadData];
    }
}

-(void)anasyDict:(NSArray *)dataArray andMutableArray:(NSMutableArray *)dateArray andArray2:(NSMutableArray *)lableArray
{
    NSArray *array = dataArray;
    for (int i=0; i<array.count; i++) {
        NSDictionary *tempDict = [array objectAtIndex:i];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        [lableArray addObject:[tempDict objectForKey:@"code"]];
        for (NSDictionary *obj in [tempDict objectForKey:@"city"]) {
            CityModel *model = [[CityModel alloc] initWithDictionary:obj error:nil];
            if ([obj objectForKey:@"cityName"]) {
                model.cityName = [obj objectForKey:@"cityName"];
            } else {
                model.cityName = @"";
            }
            
            if ([obj objectForKey:@"cityCode"]) {
                model.codeName = [obj objectForKey:@"cityCode"];
            } else {
                model.codeName = @"";
            }
            
            if (![[obj objectForKey:@"country"] isEqualToString:@"null"]) {
                model.country = [obj objectForKey:@"country"];
            } else {
                model.country = @"";
            }
            [tempArray addObject:model];
        }
        [dateArray addObject:tempArray];
    }
}

-(void)loadget
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] queryCities:1 block:^(NSError *error, id data) {
        if (!error) {
            [self anasyDict:data andMutableArray:self.cityCNArray andArray2:self.lableCNArray];
            [_tabView reloadData];
        }
    }];
    [[HHYNetworkEngine sharedInstance] queryCities:2 block:^(NSError *error, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            [self anasyDict:data andMutableArray:self.cityCJArray andArray2:self.lableCJArray];
        }
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

@end
