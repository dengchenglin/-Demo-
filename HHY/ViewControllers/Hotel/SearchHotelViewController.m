//
//  SearchHotelViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "SearchHotelViewController.h"
#import "HotelCell.h"
#import "HotelDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "SiftViewController.h"
#import "MapViewController.h"
@interface SearchHotelViewController ()<UIActionSheetDelegate,MJRefreshBaseViewDelegate,SiftCtlDelegate>
{
    NSMutableArray *_hotelList;
   
    UIView *_blotView;
    UIActionSheet *_sortSheet;
    UIActionSheet *_priceSheet;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    BOOL _isloadMore;
    
    
    SiftViewController *_siftVC;
}
@property (nonatomic,copy)NSString *sortType;
@property (nonatomic,copy)NSString *priceMin;
@property (nonatomic,copy)NSString *priceMax;
@property (nonatomic,copy)NSDictionary *siftDic;
@end

@implementation SearchHotelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pageNo = 1;
        _pageSize = 20;
    
        _isloadMore = NO;
        _hotelList = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    [self gethotelList];
 
}
-(void)gethotelList
{
  
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    if(_cityName != nil && _cityName.length !=0)
    {
           [dic setObject:EnCodingNSString(_cityName)  forKey:@"cityName"];
    }
    if(_startDate != nil && _startDate.length !=0)
    {
            [dic setObject:_startDate forKey:@"startDate"];
    }
    if(_endDate != nil && _endDate.length !=0)
    {
            [dic setObject:_endDate forKey:@"endDate"];
    }
    if(_hotelName != nil && _hotelName.length !=0)
    {
            [dic setObject:EnCodingNSString(_hotelName) forKey:@"hotelName"];
    }
    if(_hotelLevel != nil && _hotelLevel.length !=0)
    {
        [dic setObject:_hotelLevel forKey:@"grade"];
    }
    if(_sortType != nil && _sortType.length !=0)
    {
        [dic setObject:_sortType forKey:@"sort"];
    }
    if(_priceMin != nil && _priceMin.length != 0)
    {
        [dic setObject:_priceMin forKey:@"priceMin"];
    }
    if(_priceMax != nil && _priceMax.length != 0)
    {
        [dic setObject:_priceMax forKey:@"priceMax"];
    }
    if(_siftDic != nil)
    {
        for(NSString *key in [_siftDic allKeys])
        {
            [dic setObject:[_siftDic objectForKey:key] forKey:key];
        }
    }
 
    [dic setObject:[NSString stringWithFormat:@"%d",_pageNo] forKey:@"pageNo"];
    [dic setObject:[NSString stringWithFormat:@"%d",_pageSize] forKey:@"pageSize"];


    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] searchHotelDic:dic block:^(NSError *error, id data) {
        [MBProgressHUD hideHUDForView:self.view  animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
           
            NSArray *arr = [data responseJSON];
            if(!_isloadMore)
            {
                [_hotelList removeAllObjects];
             
            }
            for(int i = 0;i < arr.count;i++)
            {
                [_hotelList addObject:[arr objectAtIndex:i]];
            }
           
            _blotView.hidden = NO;
            [_tableView reloadData];
      
        } else {
            [Utils alertWithTitle:error.localizedDescription message:nil];
        }
    }];
}
-(void)createView
{
    [self initNav:[NSString stringWithFormat:@"%@",_cityName]];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50 -64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    [_tableView registerNib:[UINib nibWithNibName:@"HotelCell" bundle:nil] forCellReuseIdentifier:@"HotelCell"];
    [self.view addSubview:_tableView];
    _header = [[MJRefreshHeaderView alloc]init];
    _header.scrollView = _tableView;
    _header.delegate = self;
    _footer = [[MJRefreshFooterView alloc]init];
    _footer.scrollView = _tableView;
    _footer.delegate = self;
    
    
    _blotView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50-64 , 320, 50)];
    _blotView.backgroundColor = [UIColor whiteColor];
    _blotView.alpha = 0.9;
    [_blotView.layer setBorderWidth:1];
    [_blotView.layer setBorderColor:kADWColor(240, 240, 240, 1).CGColor];
    NSArray *arr = @[@"筛选",@"默认顺序",@"价格范围",@"地图"];
    NSArray *imageNormalArr = @[@"blotNormal",@"sortNormal",@"priceNormal",@"mapNormal"];
    NSArray *imageSelectArr = @[@"blotSelect",@"sortSelect",@"priceSelect",@"mapSelect"];
    for(int i = 0;i < arr.count;i++)
    {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.tag = 300 + i;
        [but setFrame:CGRectMake(5+320/arr.count * i, 5, 75, 40)];
        [but setBackgroundImage:[UIImage imageNamed:[imageNormalArr objectAtIndex:i]] forState:UIControlStateNormal];
        [but setBackgroundImage:[UIImage imageNamed:[imageSelectArr objectAtIndex:i]] forState:UIControlStateSelected];
        [but addTarget:self action:@selector(blotClick:) forControlEvents:UIControlEventTouchUpInside];
      
        [_blotView addSubview:but];
    }
    
    [self.view addSubview:_blotView];
    
    _sortSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"默认排序",@"价格 低->高",@"价格 高->低",@"星级 低->高",@"星级 高->低", nil];
    _sortSheet.tag = 100;
    
    _priceSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"不限",@"¥ 0 - ¥ 100",@"¥ 100 - ¥ 150",@"¥ 150 - ¥ 200",@"¥ 200 - ¥ 300",@"¥ 300 - ¥ 400",@"¥ 400 - ¥ 500",@"¥ 500以上", nil];
    _priceSheet.tag = 101;
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [_header endRefreshing];
    [_footer endRefreshing];
    return _hotelList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic =[_hotelList objectAtIndex:indexPath.row];
    NSString *adress = [dic objectForKey:@"address"];
    if(adress && adress.length != 0)
    {
        CGSize size = [adress sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(215, 100)];
        if(size.height > 20)
        {
            return 65 + size.height;
        }
        return 70 + size.height;
    }
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HotelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell"];
    NSDictionary *dic =[_hotelList objectAtIndex:indexPath.row];
 
    NSString *hotelNum = [dic objectForKey:@"hotel"];
  
    if(hotelNum != nil || hotelNum.length != 0)
    {
        NSString *imageUrlStr = [NSString stringWithFormat:@"http://www.huamin.com.hk/image/hotel/%@.jpg",hotelNum];
        
      
        [cell.headImageView setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"nopic.jpg"]];
    
    }
    else
    {
        NSString *imageUrlStr = @"http://www.huamin.com.hk/image/hotel/nopic.jpg";
        
        [cell.headImageView setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"nopic.jpg"]];
    }
    cell.nameLable.text = [dic objectForKey:@"hotelName"];
    cell.DetLable.text = [dic objectForKey:@"address"];
    cell.priceLable.text = [NSString stringWithFormat:@"¥ %@",[dic objectForKey:@"minPrice"]];
    cell.grade = [NSString stringWithFormat:@"%@星",[dic objectForKey:@"grade"]];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark ClickEvent
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotelDetailViewController *dvc = [[HotelDetailViewController alloc] init];
    NSDictionary *dic = [_hotelList objectAtIndex:indexPath.row];
    dvc.detailDic = dic;
    dvc.startDate = _startDate;
    dvc.endDate = _endDate;
    dvc.hotelName = [dic objectForKey:@"hotelName"];
    dvc.cityName = _cityName;
    [self.navigationController pushViewController:dvc animated:YES];
}

-(void)blotClick:(UIButton *)button
{
    for(int i = 0;i < 4;i++)
    {
        UIButton *but = (UIButton *)[_blotView viewWithTag:300 + i];
  
        if(but.tag == button.tag)
        {
         
            but.selected = YES;
        }
        else
        {
            but.selected = NO;
        }
    }
    if(button.tag == 300)
    {
        if(_siftVC == nil)
        {
            _siftVC = [[SiftViewController alloc]init];
     
        }
        _siftVC.cityCode = _cityCode;
        _siftVC.delegate = self;
        [self.navigationController pushViewController:_siftVC animated:YES];
    }
    if(button.tag == 301)
    {
        [_sortSheet showInView:self.view];
    }
    if(button.tag == 302)
    {
        [_priceSheet showInView:self.view];
    }
    if(button.tag == 303)
    {
        MapViewController *ctl = [[MapViewController alloc]init];
        ctl.hotellist = _hotelList;
        ctl.startDate = _startDate;
        ctl.endDate = _endDate;
        ctl.cityName = _cityName;
        [self.navigationController pushViewController:ctl animated:YES];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 100)
    {
        if(buttonIndex == 0)
        {
            self.sortType = nil;
        }
        if(buttonIndex == 1)
        {
            self.sortType = @"price_asc";
        }
        if(buttonIndex == 2)
        {
            self.sortType = @"price_desc";
        }
        if(buttonIndex == 3)
        {
            self.sortType = @"grade_asc";
        }
        if(buttonIndex == 4)
        {
            self.sortType = @"grade_desc";
        }
        if(buttonIndex == 5)
        {
            return;
        }
    }
    if(actionSheet.tag == 101)
    {
        if(buttonIndex == 0)
        {
            self.priceMin = nil;
            self.priceMax = nil;
        }
        if(buttonIndex == 1)
        {
            self.priceMin = @"0";
            self.priceMax = @"100";
        }
        if(buttonIndex == 2)
        {
            self.priceMin = @"100";
            self.priceMax = @"150";
        }
        if(buttonIndex == 3)
        {
            self.priceMin = @"150";
            self.priceMax = @"200";
        }
        if(buttonIndex == 4)
        {
            self.priceMin = @"200";
            self.priceMax = @"300";
        }
        if(buttonIndex == 5)
        {
            self.priceMin = @"300";
            self.priceMax = @"400";
        }
        if(buttonIndex == 6)
        {
            self.priceMin = @"400";
            self.priceMax = @"500";
        }
        if(buttonIndex == 7)
        {
            self.priceMin = @"500";
            self.priceMax = nil;
        }
        if(buttonIndex == 8)
        {
            return;
        }
    }
    _isloadMore = NO;
    _pageNo = 1;
    _pageSize = 20;
 
    [self gethotelList];
    
}

#pragma mark SiftDelegate
-(void)getSiftDic:(NSDictionary *)dic
{
    self.siftDic = dic;
    _isloadMore = NO;
    _pageNo = 1;
    _pageSize = 20;
 
    [self gethotelList];
}

#pragma mark RefreshDelegate
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if(refreshView == _header)
    {
       
        _pageNo = 1;
        _pageSize = 20;
        _isloadMore = NO;
        self.sortType = nil;
        self.priceMin = nil;
        self.priceMax = nil;
        self.siftDic = nil;
        [self gethotelList];
    }
    if(refreshView == _footer)
    {
        _pageNo++;
        _pageSize = 20;
     
        _isloadMore = YES;
        [self gethotelList];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_header free];
    [_footer free];
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
