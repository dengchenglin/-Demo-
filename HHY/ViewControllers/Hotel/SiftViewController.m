//
//  SiftViewController.m
//  HHY
//
//  Created by chenguangjiang on 14-11-1.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "SiftViewController.h"
#import "SiftCell.h"
typedef enum _SelectType{
    AreaType = 1,
    LandMarkType,
    StarType,
    BedType,
    OtherType
}SelectType;
@interface SiftViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UIScrollView *_resaultView;
    UIView *_selectView;
    UIView *_selectTypeView;
    UITableView *_selectTableView;
    UIView *_affirmView;
    UIActivityIndicatorView *_acitvityIndicatorView;
    
    NSArray *_arealist;
    NSArray *_landmarklist;
    NSArray *_starlist;
    NSArray *_starCode;
    NSArray *_bedtypelist;
    NSArray *_otherlist;
    NSArray *_otherCode;
    NSMutableDictionary *_selectDic;
    
  
    
    SelectType _selectType;
}
@property (nonatomic,copy)NSString *dist;
@property (nonatomic,copy)NSString *distName;
@property (nonatomic,copy)NSString *landmark;
@property (nonatomic,copy)NSString *grade;
@property (nonatomic,copy)NSString *gradeName;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *typeName;
@property (nonatomic,copy)NSString *isAllot;
@property (nonatomic,copy)NSString *isAllotName;

@property (nonatomic,copy)NSString *areaRecord;
@property (nonatomic,copy)NSString *landmarkRecord;
@property (nonatomic,copy)NSString *gradeRecord;
@property (nonatomic,copy)NSString *bedtypeRecord;
@property (nonatomic,copy)NSString *otherRecord;

@end

@implementation SiftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _selectDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createView];
    [self initValue];
}
-(void)createView
{
    [self initNav:@"筛选"];
    _resaultView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 38)];
    _resaultView.backgroundColor= [UIColor whiteColor];


    [self.view addSubview:_resaultView];
    
    
    _selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, kScreenHeight - 48 - 64)];
    _selectTypeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, _selectView.frame.size.height)];
    _selectTypeView.backgroundColor = [UIColor grayColor];
    [_selectView addSubview:_selectTypeView];
    [self initSleectTypeView];
    
    _selectTableView = [[UITableView alloc]initWithFrame:CGRectMake(80, 0, 240, _selectView.frame.size.height) style:UITableViewStylePlain];
    [_selectTableView registerNib:[UINib nibWithNibName:@"SiftCell" bundle:nil] forCellReuseIdentifier:@"SiftCell"];
    _selectTableView.delegate = self;
    _selectTableView.dataSource = self;
    _selectTableView.separatorStyle = UITableViewCellAccessoryNone;
    UIImageView *lineimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    lineimageview.backgroundColor = kADWColor(200, 200, 200, 1);
    [_selectTableView addSubview:lineimageview];
    [_selectView addSubview:_selectTableView];

    _affirmView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50 - 64, 320, 45)];
    _affirmView.backgroundColor = [UIColor clearColor];
    UIButton *resetBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetBut setFrame:CGRectMake(10, 10, 130, 32)];
    resetBut.backgroundColor = [UIColor grayColor];
    
    [resetBut setTitle:@"重置" forState:UIControlStateNormal];
    [resetBut addTarget:self action:@selector(resetAct)forControlEvents:UIControlEventTouchUpInside];
    [_affirmView addSubview:resetBut];
    UIButton *affirmBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [affirmBut setFrame:CGRectMake(180, 10, 130, 32)];
    affirmBut.backgroundColor = kADWColor(240, 106, 19, 1);
    [affirmBut setTitle:@"确定" forState:UIControlStateNormal];
    [affirmBut addTarget:self action:@selector(finishAffirm) forControlEvents:UIControlEventTouchUpInside];
    [_affirmView addSubview:affirmBut];
    
    [self.view addSubview:_affirmView];
    
    _acitvityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(190, 140, 20, 20)];
    _acitvityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [_acitvityIndicatorView setHidesWhenStopped:YES];
    [_selectView addSubview:_acitvityIndicatorView];

    [self.view addSubview:_selectView];
}

-(void)initSleectTypeView
{
    for(int i = 0;i < 5;i ++)
    {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.tag = 100 + i;
        but.clipsToBounds = NO;
        [but setFrame:CGRectMake(0 , i*53, 80, 53)];
        but.backgroundColor = [UIColor grayColor];
      
        [but addTarget:self action:@selector(selectTypeEvent:) forControlEvents:UIControlEventTouchUpInside];
     
        [_selectTypeView addSubview:but];
        if(i == 0)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 3, 21, 29)];
            imageView.tag = 200 + i;
            imageView.image = [UIImage imageNamed:@"areaSelect"];
            [but addSubview:imageView];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 60, 15)];
            label.tag = 300 + i;
            label.text = @"区域";
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = kADWColor(80, 190, 240, 1);
             [but addSubview:label];
            UIImageView *lingimageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 52, 80, 1)];
            lingimageview.backgroundColor = kADWColor(170, 170, 170, 1);
            [but addSubview:lingimageview];
            UIImageView *selectedmark = [[UIImageView alloc]initWithFrame:CGRectMake(70, 18, 10, 15)];
            selectedmark.tag = 500 + i;
            selectedmark.image = [UIImage imageNamed:@"selectmark"];
            [but addSubview:selectedmark];
           
        }
        if(i == 1)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 9, 30, 22)];
            imageView.tag = 200 + i;
            imageView.image = [UIImage imageNamed:@"landmarkNormal"];
            [but addSubview:imageView];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 34, 60, 15)];
            label.tag = 300 + i;
            label.text = @"地标";
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
             [but addSubview:label];
            UIImageView *lingimageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 52, 80, 1)];
            lingimageview.backgroundColor = kADWColor(170, 170, 170, 1);
            [but addSubview:lingimageview];
            UIImageView *selectedmark = [[UIImageView alloc]initWithFrame:CGRectMake(70, 18, 10, 15)];
            selectedmark.tag = 500 + i;
            selectedmark.image = [UIImage imageNamed:@"selectmark"];
            selectedmark.hidden = YES;
            [but addSubview:selectedmark];
           
        }
        if(i == 2)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 5, 29, 27)];
            imageView.tag = 200 + i;
            imageView.image = [UIImage imageNamed:@"starNormal"];
            [but addSubview:imageView];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 60, 15)];
            label.tag = 300 + i;
            label.text = @"星级";
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            UIImageView *lingimageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 52, 80, 1)];
            lingimageview.backgroundColor = kADWColor(170, 170, 170, 1);
            [but addSubview:lingimageview];
            [but addSubview:label];
            UIImageView *selectedmark = [[UIImageView alloc]initWithFrame:CGRectMake(70, 18, 10, 15)];
            selectedmark.tag = 500 + i;
            selectedmark.image = [UIImage imageNamed:@"selectmark"];
            selectedmark.hidden = YES;
            [but addSubview:selectedmark];
        }
        if(i == 3)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 29, 20)];
            imageView.tag = 200 + i;
            imageView.image = [UIImage imageNamed:@"bedtypeNormal"];
            [but addSubview:imageView];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 33, 60, 15)];
              label.tag = 300 + i;
            label.text = @"床型";
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            UIImageView *lingimageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 52, 80, 1)];
            lingimageview.backgroundColor = kADWColor(170, 170, 170, 1);
            [but addSubview:lingimageview];
            [but addSubview:label];
            UIImageView *selectedmark = [[UIImageView alloc]initWithFrame:CGRectMake(70, 18, 10, 15)];
            selectedmark.tag = 500 + i;
            selectedmark.image = [UIImage imageNamed:@"selectmark"];
            selectedmark.hidden = YES;
            [but addSubview:selectedmark];
        }
        if(i == 4)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, 15, 30, 8)];
            imageView.tag = 200 + i;
            imageView.image = [UIImage imageNamed:@"otherNormal"];
            [but addSubview:imageView];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 33, 60, 15)];
              label.tag = 300 + i;
            label.text = @"其它";
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            UIImageView *lingimageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 52, 80, 1)];
            lingimageview.backgroundColor = kADWColor(170, 170, 170, 1);
            [but addSubview:lingimageview];
            [but addSubview:label];
            UIImageView *selectedmark = [[UIImageView alloc]initWithFrame:CGRectMake(70, 18, 10, 15)];
            selectedmark.tag = 500 + i;
            selectedmark.image = [UIImage imageNamed:@"selectmark"];
            selectedmark.hidden = YES;
            [but addSubview:selectedmark];
        }
        
    }
}
-(void)initValue
{
    _selectType = AreaType;
    [self getAreaList];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_selectType == AreaType)
    {
        if(_arealist != nil)
        {
            return _arealist.count;
        }
    }
    if(_selectType == LandMarkType)
    {
    
        if(_landmarklist != nil)
        {
            return _landmarklist.count;
        }
    }
    if(_selectType == StarType)
    {
        if(_starlist != nil)
        {
            return _starlist.count;
        }
    }
    if(_selectType == BedType)
    {
        if(_bedtypelist != nil)
        {
            return _bedtypelist.count;
        }
    }
    if(_selectType == OtherType)
    {
        if(_otherlist != nil)
        {
            return _otherlist.count;
        }
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    SiftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SiftCell"];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    if(_selectType == AreaType)
    {
        NSDictionary *dic = [_arealist objectAtIndex:indexPath.row];
        cell.siftName.text = [dic objectForKey:@"distName"];
        if(_areaRecord)
        {
            if(indexPath.row == [_areaRecord integerValue])
            {
                cell.selectBut.selected = YES;
            }
            else
            {
                 cell.selectBut.selected = NO;
            }
        }
        else
        {
            cell.selectBut.selected = NO;
        }
    }
    if(_selectType == LandMarkType)
    {
        cell.siftName.text = [_landmarklist objectAtIndex:indexPath.row];
        if(_landmarkRecord)
        {
            if(indexPath.row == [_landmarkRecord integerValue])
            {
                cell.selectBut.selected = YES;
            }
            else
            {
                 cell.selectBut.selected = NO;
            }
        }
        else
        {
            cell.selectBut.selected = NO;
        }
    }
    if(_selectType == StarType)
    {
        cell.siftName.text = [_starlist objectAtIndex:indexPath.row];
        if(_gradeRecord)
        {
            if(indexPath.row == [_gradeRecord integerValue])
            {
                cell.selectBut.selected = YES;
            }
            else
            {
                 cell.selectBut.selected = NO;
            }
        }
        else
        {
            cell.selectBut.selected = NO;
        }
    }
    if(_selectType == BedType)
    {
        NSDictionary *dic = [_bedtypelist objectAtIndex:indexPath.row];
        cell.siftName.text = [dic objectForKey:@"typeName"];
        if(_bedtypeRecord)
        {
            if(indexPath.row == [_bedtypeRecord integerValue])
            {
                cell.selectBut.selected = YES;
            }
            else
            {
                 cell.selectBut.selected = NO;
            }
        }
        else
        {
            cell.selectBut.selected = NO;
        }
    }
    if(_selectType == OtherType)
    {
        cell.siftName.text = [_otherlist objectAtIndex:indexPath.row];
        if(_otherRecord)
        {
            if(indexPath.row == [_otherRecord integerValue])
            {
                cell.selectBut.selected = YES;
            }
            else
            {
                 cell.selectBut.selected = NO;
            }
        }
        else
        {
            cell.selectBut.selected = NO;
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_selectType == AreaType)
    {
        for(int i = 0;i < _arealist.count;i++)
        {
            NSIndexPath *index  = [NSIndexPath indexPathForRow:i inSection:0];
            SiftCell *cell = (SiftCell *)[tableView cellForRowAtIndexPath:index];
            if(index.row == indexPath.row)
            {
                if(cell.selectBut.selected)
                {
                    cell.selectBut.selected = NO;
                    self.dist = nil;
                    self.distName = nil;
                    self.areaRecord = nil;
                }
                else
                {
                    cell.selectBut.selected = YES;
                    NSDictionary *dic = [_arealist objectAtIndex:indexPath.row];
                    self.dist = [dic objectForKey:@"dist"];
                    self.distName = [dic objectForKey:@"distName"];
                    self.areaRecord = [NSString stringWithFormat:@"%d",indexPath.row];
                }
            }
            else
            {
                cell.selectBut.selected = NO;
            }
        }
    }
    if(_selectType == LandMarkType)
    {
        for(int i = 0;i < _landmarklist.count;i++)
        {
            NSIndexPath *index  = [NSIndexPath indexPathForRow:i inSection:0];
            SiftCell *cell = (SiftCell *)[tableView cellForRowAtIndexPath:index];
            if(index.row == indexPath.row)
            {
                if(cell.selectBut.selected)
                {
                    cell.selectBut.selected = NO;
                    self.landmark = nil;
                    self.landmarkRecord = nil;
                }
                else
                {
                    cell.selectBut.selected = YES;
                    self.landmark = [_landmarklist objectAtIndex:indexPath.row];
                    self.landmarkRecord = [NSString stringWithFormat:@"%d",indexPath.row];
                }
            }
            else
            {
                cell.selectBut.selected = NO;
            }
        }

    }
    if(_selectType == StarType)
    {
        
        for(int i = 0;i < _starlist.count;i++)
        {
            NSIndexPath *index  = [NSIndexPath indexPathForRow:i inSection:0];
            SiftCell *cell = (SiftCell *)[tableView cellForRowAtIndexPath:index];
            if(index.row == indexPath.row)
            {
                if(cell.selectBut.selected)
                {
                    cell.selectBut.selected = NO;
                    self.grade = nil;
                    self.gradeName = nil;
                    self.gradeRecord = nil;
                }
                else
                {
                    cell.selectBut.selected = YES;
                    if(indexPath.row != 0)
                    {
                        self.grade = [_starCode objectAtIndex:indexPath.row];
                        self.gradeName = [_starlist objectAtIndex:indexPath.row];
                    }
                    else
                    {
                        self.grade = nil;
                        self.gradeName = nil;
                    }
                    self.gradeRecord = [NSString stringWithFormat:@"%d",indexPath.row];

                }
            }
            else
            {
                cell.selectBut.selected = NO;
            }
        }
        
            }
    if(_selectType == BedType)
    {
        for(int i = 0;i < _bedtypelist.count;i++)
        {
            NSIndexPath *index  = [NSIndexPath indexPathForRow:i inSection:0];
            SiftCell *cell = (SiftCell *)[tableView cellForRowAtIndexPath:index];
            if(index.row == indexPath.row)
            {
                if(cell.selectBut.selected)
                {
                    cell.selectBut.selected = NO;
                    self.type = nil;
                    self.typeName = nil;
                    self.bedtypeRecord = nil;
                }
                else
                {
                    cell.selectBut.selected = YES;
                    NSDictionary *dic = [_bedtypelist objectAtIndex:indexPath.row];
                    self.type = [dic objectForKey:@"type"];
                    self.typeName = [dic objectForKey:@"typeName"];
                    self.bedtypeRecord = [NSString stringWithFormat:@"%d",indexPath.row];
                }
            }
            else
            {
                cell.selectBut.selected = NO;
            }
        }


    }
    if(_selectType == OtherType)
    {
        
        for(int i = 0;i < _otherlist.count;i++)
        {
            NSIndexPath *index  = [NSIndexPath indexPathForRow:i inSection:0];
            SiftCell *cell = (SiftCell *)[tableView cellForRowAtIndexPath:index];
            if(index.row == indexPath.row)
            {
                if(cell.selectBut.selected)
                {
                    cell.selectBut.selected = NO;
                    self.isAllot = nil;
                    self.isAllotName = nil;
                    self.otherRecord = nil;
                }
                else
                {
                    cell.selectBut.selected = YES;
                    
                    if(indexPath.row != 0)
                    {
                        self.isAllot = [_otherCode objectAtIndex:indexPath.row];
                        self.isAllotName =[_otherlist objectAtIndex:indexPath.row];
                    }
                    else
                    {
                        self.isAllot = nil;
                        self.isAllotName = nil;
                    }
                    self.otherRecord = [NSString stringWithFormat:@"%d",indexPath.row];
                }
            }
            else
            {
                cell.selectBut.selected = NO;
            }
        }
    }
    
    [self affirmAct];
}
-(void)refreshResaultView
{
    for(UIView *v in _resaultView.subviews)
    {
        [v removeFromSuperview];
    }
    if(_selectDic.count != 0)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [_selectView setFrame:CGRectMake(0, 38, 320, kScreenHeight - 50 - 35 - 64)];
        [_selectTypeView setFrame:CGRectMake(0, 0, 80, _selectView.frame.size.height)];
        [_selectTableView setFrame:CGRectMake(80, 0, 240, _selectView.frame.size.height)];
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        [_selectView setFrame:CGRectMake(0, 0, 320, kScreenHeight - 48 - 64)];
        [_selectTypeView setFrame:CGRectMake(0, 0, 80, _selectView.frame.size.height)];
        [_selectTableView setFrame:CGRectMake(80, 0, 240, _selectView.frame.size.height)];
        [UIView commitAnimations];
    }

    NSMutableArray *selectArr = [NSMutableArray array];
    
    for(NSString *dicName in [_selectDic allKeys])
    {
       
        if([dicName isEqualToString:@"distDic"])
        {
            [selectArr addObject:[_selectDic objectForKey:@"distDic"]];
        }
    }
    for(NSString *dicName in [_selectDic allKeys])
    {
        
        if([dicName isEqualToString:@"landmarkDic"])
        {
            [selectArr addObject:[_selectDic objectForKey:@"landmarkDic"]];
        }
    }
    for(NSString *dicName in [_selectDic allKeys])
    {
        
        if([dicName isEqualToString:@"gradeDic"])
        {
            [selectArr addObject:[_selectDic objectForKey:@"gradeDic"]];
        }
    }
    for(NSString *dicName in [_selectDic allKeys])
    {
        
        if([dicName isEqualToString:@"typeDic"])
        {
            [selectArr addObject:[_selectDic objectForKey:@"typeDic"]];
        }
    }
    for(NSString *dicName in [_selectDic allKeys])
    {
        
        if([dicName isEqualToString:@"isAllotDic"])
        {
            [selectArr addObject:[_selectDic objectForKey:@"isAllotDic"]];
        }
    }

    CGFloat width = 0;
    for(int i = 0;i < selectArr.count;i++)
    {
     
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = kADWColor(220, 220, 220, 1);
        UILabel *label = [[UILabel alloc]init];
        label.text = [[selectArr objectAtIndex:i] objectForKey:@"name"];
        label.textColor = kADWColor(100, 100, 100, 1);
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        CGSize size = [label.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(300, 25)];
        [label setFrame:CGRectMake(5, 4, size.width, 30)];
        [view setFrame:CGRectMake(width, 0, size.width + 20, 38)];
        width = 2+ width + view.frame.size.width;
        [view addSubview:label];
        
        UIButton *removeBut =[UIButton buttonWithType:UIButtonTypeCustom];
        removeBut.tag = 400 + i;
        [removeBut setFrame:CGRectMake(view.frame.size.width - 12, 0, 12, 12)];
        [removeBut setBackgroundImage:[UIImage imageNamed:@"removeSift"] forState:UIControlStateNormal];
        [removeBut addTarget:self action:@selector(removeSift:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:removeBut];
        [_resaultView addSubview:view];
      
        
    }
    _resaultView.contentSize = CGSizeMake(10 +width, 38);
    if(_resaultView.contentSize.width > 320 && (_selectType == BedType ||_selectType == OtherType))
    {
        _resaultView.contentOffset = CGPointMake(_resaultView.contentSize.width - 320, 0);
    }
    else
    {
         _resaultView.contentOffset = CGPointMake(0, 0);
    }

}

#pragma mark getListData
//获取区域
-(void)getAreaList
{
    if(_cityCode != nil && _cityCode.length != 0)
    {
        [_acitvityIndicatorView startAnimating];
        [[HHYNetworkEngine sharedInstance] getArealistCity:_cityCode block:^(NSError *error,id data){
            [_acitvityIndicatorView stopAnimating];
            if(!error)
            {
                NSArray *arr = [data responseJSON];
                if(arr.count != 0)
                {
                    _arealist = [arr copy];
                    [_selectTableView reloadData];
                }
            }
      
        }];
    }
    else
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"城市代码失效,请重新选择城市" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
   
        [alt show];
        
    }
}

//获取城市地标
-(void)getlandMarklist
{
    [_acitvityIndicatorView startAnimating];
    [[HHYNetworkEngine sharedInstance] getlandMarklistCity:_cityCode block:^(NSError *error,id data){
           [_acitvityIndicatorView stopAnimating];
        if(!error){
         
            
            NSArray *arr = [data responseJSON];
            _landmarklist = [arr copy];
            if(arr.count != 0)
            {
                [_selectTableView reloadData];
            }
        }
    }];
}

//获取星级等级
-(void)getStarlevel
{
    _starlist = @[@"星级不限",@"五星",@"四星",@"三星",@"三星以下"];
    _starCode = @[@"－1",@"5",@"4",@"3",@"0"];
    [_selectTableView reloadData];
}
//获取床型
-(void)getbedlist
{
    [_acitvityIndicatorView startAnimating];
    [[HHYNetworkEngine sharedInstance] getbedTypelistWithblock:^(NSError *error,id data){
        [_acitvityIndicatorView stopAnimating];
        if(!error)
        {
       
            NSArray *arr = [data responseJSON];
          
            if(arr.count != 0)
            {
                _bedtypelist = [arr copy];
                [_selectTableView reloadData];
            }
        }
    
    }];
}
//获取其它
-(void)getOtherlist
{
    _otherlist = @[@"不限",@"即时确认",@"等待回复"];
    _otherCode = @[@"O",@"Y",@"N"];
    
    [_selectTableView reloadData];
}

#pragma mark ClickEvent
-(void)selectTypeEvent:(UIButton *)button
{
    NSArray *imageNormalArr = @[@"areaNormal",@"landmarkNormal",@"starNormal",@"bedtypeNormal",@"otherNormal"];
    NSArray *imageSelectArr = @[@"areaSelect",@"landmarkSelect",@"starSelect",@"bedtypeSelect",@"otherSelect"];
    for(int i = 0;i < 5;i++)
    {
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:200 + i];
        UILabel *label = (UILabel *)[self.view viewWithTag:300 + i];
        UIImageView *selectmark = (UIImageView *)[self.view viewWithTag:500 + i];
        if(button.tag - 100 == i)
        {
            imageView.image = [UIImage imageNamed:[imageSelectArr objectAtIndex:i]];
            [label setTextColor:kADWColor(80, 190, 240, 1)];
            selectmark.hidden = NO;
        }
        else
        {
            imageView.image = [UIImage imageNamed:[imageNormalArr objectAtIndex:i]];
            [label setTextColor:[UIColor whiteColor]];
             selectmark.hidden = YES;
        }
        
    }
    if(button.tag == 100)
    {
        _selectType = AreaType;
        if(_arealist == nil || _arealist.count == 0)
        {
            [self getAreaList];
        }
       
    }
    if(button.tag == 101)
    {
        _selectType = LandMarkType;
        if(_landmarklist == nil || _landmarklist.count == 0)
        {
            [self getlandMarklist];
        }
    }
    if(button.tag == 102)
    {
        _selectType = StarType;
        [self getStarlevel];
     
    }
    if(button.tag == 103)
    {
        _selectType = BedType;
        if(_bedtypelist == nil || _bedtypelist.count == 0)
        {
            [self getbedlist];
        }
    }
    if(button.tag == 104)
    {
        _selectType = OtherType;
        [self getOtherlist];
    }
    [_selectTableView reloadData];
}

//重置
-(void)resetAct
{
    [_selectDic removeAllObjects];
    self.areaRecord = nil;
    self.landmarkRecord = nil;
    self.gradeRecord = nil;
    self.bedtypeRecord = nil;
    self.otherRecord = nil;
    self.dist = nil;
     self.distName = nil;
     self.landmark = nil;
     self.grade = nil;
    self.gradeName = nil;
    self.type = nil;
     self.typeName = nil;
     self.isAllot = nil;
    self.isAllotName = nil;
    [self refreshResaultView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [_selectView setFrame:CGRectMake(0, 0, 320, kScreenHeight - 48 - 64)];
    [UIView commitAnimations];
}
-(void)removeSift:(UIButton *)button
{
    NSMutableArray *selectArr = [NSMutableArray array];
    
    for(NSString *dicName in [_selectDic allKeys])
    {
        
        if([dicName isEqualToString:@"distDic"])
        {
            [selectArr addObject:dicName];
        }
    }
    for(NSString *dicName in [_selectDic allKeys])
    {
        
        if([dicName isEqualToString:@"landmarkDic"])
        {
            [selectArr addObject:dicName];
        }
    }
    for(NSString *dicName in [_selectDic allKeys])
    {
        
        if([dicName isEqualToString:@"gradeDic"])
        {
           [selectArr addObject:dicName];
        }
    }
    for(NSString *dicName in [_selectDic allKeys])
    {
        
        if([dicName isEqualToString:@"typeDic"])
        {
           [selectArr addObject:dicName];
        }
    }
    for(NSString *dicName in [_selectDic allKeys])
    {
        
        if([dicName isEqualToString:@"isAllotDic"])
        {
            [selectArr addObject:dicName];
        }
    }
    
    if([[selectArr objectAtIndex:button.tag - 400] isEqualToString:@"distDic"])
    {
        self.areaRecord = nil;
        self.dist = nil;
        self.distName = nil;
    }
    if([[selectArr objectAtIndex:button.tag - 400] isEqualToString:@"landmarkDic"])
    {
        self.landmarkRecord = nil;
        self.landmark = nil;
    
    }
    if([[selectArr objectAtIndex:button.tag - 400] isEqualToString:@"gradeDic"])
    {
        self.gradeRecord = nil;
        self.grade = nil;
        self.gradeName = nil;
    }
    if([[selectArr objectAtIndex:button.tag - 400] isEqualToString:@"typeDic"])
    {
        self.bedtypeRecord = nil;
        self.type = nil;
        self.typeName = nil;
    }
    if([[selectArr objectAtIndex:button.tag - 400] isEqualToString:@"isAllotDic"])
    {
        self.otherRecord = nil;
        self.isAllot = nil;
        self.isAllotName = nil;
    }
    
    
    [_selectDic removeObjectForKey:[selectArr objectAtIndex:button.tag - 400]];
    
  
    [self refreshResaultView];
 
}
//确认
-(void)affirmAct
{
    
    if(self.dist)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:_dist forKey:@"code"];
        [dic setObject:_distName forKey:@"name"];
        [_selectDic setObject:dic forKey:@"distDic"];
    }
    else
    {
         [_selectDic removeObjectForKey:@"distDic"];
    }
    if(self.landmark)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:_landmark forKey:@"code"];
        [dic setObject:_landmark forKey:@"name"];
        [_selectDic setObject:dic forKey:@"landmarkDic"];
    }
    else
    {
        [_selectDic removeObjectForKey:@"landmarkDic"];
    }
    if(self.grade)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:_grade forKey:@"code"];
        [dic setObject:_gradeName forKey:@"name"];
        [_selectDic setObject:dic forKey:@"gradeDic"];
    }
    else
    {
       
        [_selectDic removeObjectForKey:@"gradeDic"];
   
    }
    if(self.type)
    {
         NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:_type forKey:@"code"];
        [dic setObject:_typeName forKey:@"name"];
        [_selectDic setObject:dic forKey:@"typeDic"];
    }
    else
    {
        [_selectDic removeObjectForKey:@"typeDic"];
    }
    if(self.isAllot)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:_isAllot forKey:@"code"];
        [dic setObject:_isAllotName forKey:@"name"];
        [_selectDic setObject:dic forKey:@"isAllotDic"];
    }
    else
    {
       [_selectDic removeObjectForKey:@"isAllotDic"];
    }
    
 

    [self refreshResaultView];
}

-(void)finishAffirm
{
    NSMutableDictionary *siftDic = [NSMutableDictionary dictionary];
    if([[_selectDic allKeys]containsObject:@"distDic"])
    {
        NSDictionary *dic = [_selectDic objectForKey:@"distDic"];
        NSString *distcode =[dic objectForKey:@"code"];
        [siftDic setObject:distcode forKey:@"dist"];
    }
    if([[_selectDic allKeys]containsObject:@"landmarkDic"])
    {
        NSDictionary *dic = [_selectDic objectForKey:@"landmarkDic"];
        NSString *distcode =[dic objectForKey:@"code"];
        [siftDic setObject:distcode forKey:@"landmark"];
    }
    if([[_selectDic allKeys]containsObject:@"gradeDic"])
    {
        NSDictionary *dic = [_selectDic objectForKey:@"gradeDic"];
        NSString *distcode =[dic objectForKey:@"code"];
        [siftDic setObject:distcode forKey:@"grade"];
    }
    if([[_selectDic allKeys]containsObject:@"typeDic"])
    {
        NSDictionary *dic = [_selectDic objectForKey:@"typeDic"];
        NSString *distcode =[dic objectForKey:@"code"];
        [siftDic setObject:distcode forKey:@"type"];
    }
    if([[_selectDic allKeys]containsObject:@"isAllotDic"])
    {
        NSDictionary *dic = [_selectDic objectForKey:@"isAllotDic"];
        NSString *distcode =[dic objectForKey:@"code"];
        [siftDic setObject:distcode forKey:@"isAllot"];
    }
  
    if(_delegate &&[_delegate respondsToSelector:@selector(getSiftDic:)])
    {
        [_delegate getSiftDic:siftDic];
        [self.navigationController popViewControllerAnimated:YES];
    }
    NSLog(@"%@",siftDic);
   
}

- (void)dealloc
{
    self.dist = nil;
    self.landmark = nil;
    self.grade = nil;
    self.type = nil;
    self.isAllot = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
