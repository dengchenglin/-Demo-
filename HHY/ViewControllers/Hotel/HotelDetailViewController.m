//
//  HotelDetailViewController.m
//  HHY
//
//  Created by chenguangjiang on 14-11-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HotelDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "SHLUILabel.h"
#import "HotelRoomCell.h"
#import "CheckDateViewController.h"
#import "FillOrderViewController.h"
#import "LoginViewController.h"
@interface HotelDetailViewController ()<UITableViewDataSource,UITableViewDelegate,CheckDateDelegate>
{
    UIScrollView *_scrolView;
    UIView *_introView;
    UIView *_listView;
    UITableView *_tableView;
    SHLUILabel *_hotelIntroduce;
    
    NSArray *_hotelRoomlist;
    CGFloat introlViewHeight;
    
}
@end

@implementation HotelDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    [self createView];
    [self loadlistdata];
}
-(void)createView
{
    [self initNav:@"酒店详情"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, kScreenHeight)];
    _scrolView.backgroundColor = kADWColor(235, 235, 235, 1);
    [self.view addSubview:_scrolView];
    
    _introView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, 320, 128)];
    _introView.backgroundColor = [UIColor whiteColor];
    [_scrolView addSubview:_introView];
    
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    line1.backgroundColor = kADWColor(200, 200, 200, 1);
    [_introView addSubview:line1];
    UILabel *hotelName = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, 230, 18)];
    hotelName.text = [_detailDic objectForKey:@"hotelName"];
    hotelName.textColor = kADWColor(50, 50, 50, 1);
    hotelName.textAlignment = NSTextAlignmentLeft;
    hotelName.font = [UIFont systemFontOfSize:13];
    [_introView addSubview:hotelName];
    
    
    UILabel *typelabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 30, 100, 18)];
    NSString *grade  = [NSString stringWithFormat:@"%@",[_detailDic objectForKey:@"grade"]];
    if([grade isEqualToString:@"5"]){typelabel.text = @"豪华型";}
     if([grade isEqualToString:@"4"]){typelabel.text = @"高端型";}
     if([grade isEqualToString:@"3"]){typelabel.text = @"舒服型";}
     if([grade isEqualToString:@"0"]){typelabel.text = @"经济型";}

    typelabel.font = [UIFont systemFontOfSize:13];
    typelabel.textColor = kADWColor(120, 120, 120, 1);
        [_introView addSubview:typelabel];
    
    
    NSString *adress = [_detailDic objectForKey:@"address"];
    CGSize size = [adress sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(230, 100)];
    introlViewHeight = size.height;
    UILabel *hotelAdress = [[UILabel alloc]initWithFrame:CGRectMake(80, 60, 230, size.height)];
    hotelAdress.text = adress;
    hotelAdress.numberOfLines = 0;
    hotelAdress.font = [UIFont systemFontOfSize:12];
    hotelAdress.textColor = kADWColor(50, 50, 50, 1);
    [_introView addSubview:hotelAdress];
    
    if(size.height > 10)
    {
        [_introView setFrame:CGRectMake(0, 10, 320, 100 + introlViewHeight)];
    }
    UIImageView *hotelImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, (size.height -5)/2, 70, 70)];
    [hotelImage.layer setCornerRadius:5];
    hotelImage.layer.masksToBounds = YES;
    NSString *hotelNum = [_detailDic objectForKey:@"hotel"];
    
    if(hotelNum != nil || hotelNum.length != 0)
    {
        NSString *imageUrl = [NSString stringWithFormat:@"http://www.huamin.com.hk/image/hotel/%@.jpg",hotelNum];
        [hotelImage setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"nopic.jpg"]];
    }
    else
    {
        NSString *imageUrl = @"http://www.huamin.com.hk/image/hotel/nopic.jpg";
        [hotelImage setImageWithURL:[NSURL URLWithString:imageUrl]placeholderImage:[UIImage imageNamed:@"nopic"]];
    }
    
    [_introView addSubview:hotelImage];

    
    
    UIImageView *line3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, size.height + 70, 320, 1)];
    line3.backgroundColor = kADWColor(220, 220, 220, 1);
    [_introView addSubview:line3];
    
    UIButton *introduceBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [introduceBut setFrame:CGRectMake(0, size.height + 71, 85, 25)];
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 25)];
    titlelabel.text = @"酒店简介";
    titlelabel.textColor = kADWColor(44, 172, 230, 1);
    titlelabel.font = [UIFont systemFontOfSize:12];
    [introduceBut addSubview:titlelabel];
    [introduceBut addTarget:self action:@selector(showIntroduce) forControlEvents:UIControlEventTouchUpInside];
    [_introView addSubview:introduceBut];
    
    _hotelIntroduce =[[SHLUILabel alloc]init];
    [_hotelIntroduce setFont:[UIFont systemFontOfSize:11]];
    _hotelIntroduce.text = [_detailDic objectForKey:@"hotelDesc"];
    _hotelIntroduce.textColor = kADWColor(180, 180, 180, 1);
    
    _hotelIntroduce.numberOfLines = 0;
    [_introView addSubview:_hotelIntroduce];
    
    UIImageView *line4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, _introView.frame.size.height -1, 320, 1)];
    line4.tag = 4;
    line4.backgroundColor = kADWColor(210, 210, 210, 1);
    [_introView addSubview:line4];
    
    _listView = [[UIView alloc]initWithFrame:CGRectMake(0, _introView.frame.size.height + 20, 320, 400)];
    _listView.backgroundColor = [UIColor whiteColor];
    UIImageView *line5 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    line5.backgroundColor = kADWColor(200, 200, 200, 1);
    
    [_listView addSubview:line5];
    
    UIImageView *dateImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 19, 16)];
    dateImage.image = [UIImage imageNamed:@"dateImage"];
    [_listView addSubview:dateImage];
    
    UILabel *inputlabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 6, 80, 20)];
    inputlabel.tag = 11;
    inputlabel.text = [NSString stringWithFormat:@"入住%@",[_startDate stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@""]];
    inputlabel.textColor = kADWColor(50, 50, 50, 1);
    inputlabel.font = [UIFont systemFontOfSize:12];

    [_listView addSubview:inputlabel];
    
    
    UILabel *outTakeLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 6, 80, 20)];
    outTakeLabel.tag = 12;
    outTakeLabel.text = [NSString stringWithFormat:@"离店%@",[_endDate stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@""]];
    outTakeLabel.textColor = kADWColor(50, 50, 50, 1);
    outTakeLabel.font = [UIFont systemFontOfSize:12];
    [_listView addSubview:outTakeLabel];
    
  
    UIImageView *line6 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 320, 1)];
    line6.backgroundColor = kADWColor(210, 210, 210, 1);
    [_listView addSubview:line6];
    
    UIButton *checkBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkBut setFrame:CGRectMake(260, 7, 50, 20)];
    checkBut.titleLabel.font = [UIFont systemFontOfSize:12];
    [checkBut setTitle:@"修改" forState:UIControlStateNormal];
    [checkBut setTitleColor:kADWColor(44, 172, 230, 1) forState:UIControlStateNormal];
    [checkBut addTarget:self action:@selector(checkDate) forControlEvents:UIControlEventTouchUpInside];
    [_listView addSubview:checkBut];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 31, 320, 350) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"HotelRoomCell" bundle:nil] forCellReuseIdentifier:@"HotelRoomCell"];
    [_listView addSubview:_tableView];
    
    
    
    [_scrolView addSubview:_listView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenIntroduce)];
    _introView.userInteractionEnabled = YES;
    [_introView addGestureRecognizer:tap];
   
}

-(void)loadlistdata
{
    _hotelRoomlist = [[_detailDic objectForKey:@"hotelRoomList"] copy];
    [_tableView reloadData];
}
-(void)refreshListData
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

    [dic setObject:@"1" forKey:@"pageNo"];
    [dic setObject:@"1" forKey:@"pageSize"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] searchHotelDic:dic block:^(NSError *error, id data) {
        [MBProgressHUD hideHUDForView:self.view  animated:YES];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            NSLog(@"%@",[data responseJSON]);
            NSArray *arr =[data responseJSON];
            if(arr.count != 0)
            {
                NSDictionary *dic =[arr objectAtIndex:0];
                _hotelRoomlist = [[dic objectForKey:@"hotelRoomList"] copy];
                [_tableView reloadData];
            }
          
        }
    }];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     _scrolView.contentSize = CGSizeMake(kScreenWidth, 700);
    if(_hotelRoomlist)
    {
        return _hotelRoomlist.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotelRoomCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"HotelRoomCell"];
    cell.hotelDetailVC = self;
    NSDictionary *dic =[_hotelRoomlist objectAtIndex:indexPath.row];
    cell.startDate = _startDate;
    cell.roomDic = dic;

    cell.hotelName = [_detailDic objectForKey:@"hotelName"];
    cell.catType.text = [dic objectForKey:@"catName"];
    cell.bedType.text = [dic objectForKey:@"typeName"];
    cell.bf = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bf"]];
    cell.price.text = [NSString stringWithFormat:@"¥ %@",[dic objectForKey:@"roomPrice"]];
    cell.roomID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"prodRoomId"]];

    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}


#pragma mark EvevtClick
-(void)showIntroduce
{
    if(_hotelIntroduce.frame.size.height == 0)
    {
        CGSize size = [_hotelIntroduce.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(300, 1000)];
        [_hotelIntroduce setFrame:CGRectMake(10, 100 + introlViewHeight, 300, size.height)];
        [_introView setFrame:CGRectMake(0, 10, 320, 100 + introlViewHeight + size.height)];

    }
    else
    {
        [_hotelIntroduce setFrame:CGRectMake(0, 0, 0, 0)];
        [_introView setFrame:CGRectMake(0, 10, 320, 100 + introlViewHeight)];
      
        
    }
    UIImageView *line4 =(UIImageView *)[self.view viewWithTag:4];
    [line4 setFrame:CGRectMake(0, _introView.frame.size.height -1, 320, 1)];
    [_listView setFrame:CGRectMake(0, _introView.frame.size.height + 20, 320, 400)];
    _scrolView.contentSize = CGSizeMake(kScreenWidth, 500 + _introView.frame.size.height);
}
-(void)hiddenIntroduce
{
    [_hotelIntroduce setFrame:CGRectMake(0, 0, 0, 0)];
    [_introView setFrame:CGRectMake(0, 10, 320, 100 + introlViewHeight)];
    
    
    UIImageView *line4 =(UIImageView *)[self.view viewWithTag:4];
    [line4 setFrame:CGRectMake(0, _introView.frame.size.height -1, 320, 1)];
    [_listView setFrame:CGRectMake(0, _introView.frame.size.height + 20, 320, 400)];
    _scrolView.contentSize = CGSizeMake(kScreenWidth, 500 + _introView.frame.size.height);
}


-(void)checkDate
{
    CheckDateViewController *ctl =[[CheckDateViewController alloc]init];
    ctl.startDate = _startDate;
    ctl.endDate = _endDate;
    ctl.delegate = self;
    [self presentViewController:ctl animated:YES completion:nil];
    
}


#pragma mark CheckDateDelegate
-(void)changeDate:(NSString *)startdate andEnddate:(NSString *)endate
{
    self.startDate = startdate;
    self.endDate = endate;
    UILabel *inputLabel = (UILabel *)[self.view viewWithTag:11];
   inputLabel.text = [NSString stringWithFormat:@"入住%@",[_startDate stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@""]];
    UILabel *outakeLabel = (UILabel *)[self.view viewWithTag:12];
    outakeLabel.text = [NSString stringWithFormat:@"离店%@",[_endDate stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@""]];
    
    [self refreshListData];
    

}

-(void)reserveWithRoomID:(NSString *)roomID andRoomNum:(NSString *)roomNum andRoomDic:(NSDictionary *)roomDic andHotelName:(NSString *)hotelName
{
    if([[HHYNetworkEngine sharedInstance] checkLogin])
    {
        FillOrderViewController *ctl = [[FillOrderViewController alloc]init];
        ctl.roomID = roomID;
        ctl.startDate = _startDate;
        ctl.endDate = _endDate;
        ctl.roomNum = roomNum;
        ctl.roomDic = roomDic;
        ctl.hotelName = hotelName;
        ctl.startDate = _startDate;
        ctl.endDate = _endDate;
    
        [self.navigationController pushViewController:ctl animated:YES];
    }
    else
    {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        UINavigationController *lnc = [[UINavigationController alloc] initWithRootViewController:lvc];
        lvc.isDismiss = YES;
    
        [self presentViewController:lnc animated:YES completion:nil];

    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
