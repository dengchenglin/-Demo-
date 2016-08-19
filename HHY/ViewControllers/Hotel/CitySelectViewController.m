//
//  CitySelectViewController.m
//  HHY
//
//  Created by chenguangjiang on 14-10-29.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "CitySelectViewController.h"
#import "CityCell.h"

@interface CitySelectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_cityArr;
}
@end

@implementation CitySelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _cityArr = [[NSArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self loadcityData];
}
-(void)initView
{
    [self initNav:@"目的城市"];

    _myTableView.separatorStyle = UITableViewCellAccessoryNone;
    [_myTableView registerNib:[UINib nibWithNibName:@"CityCell" bundle:nil] forCellReuseIdentifier:@"CityCell"];
    if ([_myTableView respondsToSelector:@selector(setSectionIndexBackgroundColor:)]) {
        _myTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }

}
-(void)loadcityData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] getcitylistWithBlock:^(NSError *error,id data){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(!error)
        {
            NSArray *arr = [data responseJSON];
            _cityArr  = [[self getClassCity:arr] copy];
            [_myTableView reloadData];
        }
        else
        {
            NSLog(@"%@",error.description);
        }
    }];
}

//对城市数据进行处理得到新的数组
-(NSMutableArray *)getClassCity:(NSArray *)arr
{
    NSMutableArray *finshArr = [[NSMutableArray alloc]init];
    for(char i = 'A';i < 'Z';i++)
    {
        NSMutableDictionary *d = [[NSMutableDictionary alloc]init];
        NSMutableArray *charArr = [[NSMutableArray alloc]init];
        for(int j = 0;j < arr.count;j++)
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            NSDictionary *dic = [arr objectAtIndex:j];
            NSString *areaName = [dic objectForKey:@"areaName"];
            NSString *cityName = [dic objectForKey:@"cityName"];
            NSString *city =[dic objectForKey:@"city"];
            if(i == [city characterAtIndex:0])
            {
                [dict setObject:cityName forKey:@"cityName"];
                [dict setObject:areaName forKey:@"areaName"];
                [dict setObject:city forKey:@"cityCode"];
                [charArr addObject:dict];
            }
           
        }
        
        [d setValue:[NSString stringWithFormat:@"%c",i] forKey:@"firstC"];
        [d setValue:charArr forKey:@"citylist"];
        [finshArr addObject:d];
    }
    return finshArr;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _cityArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = [_cityArr objectAtIndex:section];
    NSArray *arr = [dic objectForKey:@"citylist"];
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    CityCell *cityCell = [tableView dequeueReusableCellWithIdentifier:@"CityCell"];

    NSDictionary *d = [_cityArr objectAtIndex:indexPath.section];
    NSArray *arr = [d objectForKey:@"citylist"];
    NSDictionary *dic = [arr objectAtIndex:indexPath.row];
    cityCell.cityName.text = [dic objectForKey:@"cityName"];
    cityCell.arreaName.text = [dic objectForKey:@"areaName"];

    return cityCell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    __autoreleasing UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 15)];
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 50, 15)];
    NSDictionary *dic = [_cityArr objectAtIndex:section];
    headLabel.text = [dic objectForKey:@"firstC"];

    headLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:12];
    [v addSubview:headLabel];
    v.backgroundColor = kADWColor(230, 230, 230, 1);
    return v;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_cityArr objectAtIndex:indexPath.section];
    NSArray *arr = [dic objectForKey:@"citylist"];
    NSDictionary *d = [arr objectAtIndex:indexPath.row];
    NSString *cityname = [d objectForKey:@"cityName"];
    NSString *cityCode = [d objectForKey:@"cityCode"];
    if(_delegate && [_delegate respondsToSelector:@selector(selectCity:andCityCode:)])
    {
        [_delegate selectCity:cityname andCityCode:cityCode];
      
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray * arr =[NSMutableArray array];
    for (int i = 0; i < _cityArr.count; i++) {
        NSDictionary *dic = [_cityArr objectAtIndex:i];
        [arr addObject:[dic objectForKey:@"firstC"]];
    }
    return arr;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    
}

@end
