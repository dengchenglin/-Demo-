//
//  IntakerViewController.m
//  HHY
//
//  Created by chenguangjiang on 14-11-11.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "IntakerViewController.h"
#import "AddIntakerCell.h"
#import "EitIntakerCell.h"
#import "IntakerNoticeCell.h"
@interface IntakerViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_intakerArr;
    NSNumber *_selectIntaker;
}
@end

@implementation IntakerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self refreshIntakerList];
}

-(void)createView
{
    
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initNav:@"添加入住人"];
    

    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(232, 0, 40, 44);
    [phoneButton setTitle:@"完成" forState:UIControlStateNormal];
    [phoneButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *tempItem = [[UIBarButtonItem alloc] initWithCustomView:phoneButton];
    self.navigationItem.rightBarButtonItems = @[tempItem];

    
    
    [_tableView registerNib:[UINib nibWithNibName:@"AddIntakerCell" bundle:nil] forCellReuseIdentifier:@"AddIntakerCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"EitIntakerCell" bundle:nil] forCellReuseIdentifier:@"EitIntakerCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"IntakerNoticeCell" bundle:nil] forCellReuseIdentifier:@"IntakerNoticeCell"];
    
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    
}


-(void)refreshIntakerList
{
    NSArray *arr =[NSArray arrayWithContentsOfFile:[self getIntakerPath]];
    if(arr != nil)
    {
        _intakerArr = [arr mutableCopy];
        [_tableView reloadData];
    }

    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section== 1)
    {
        if(_intakerArr != nil)
        {
            return _intakerArr.count;
        }
        return 0;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 100;
    }
    if(indexPath.section == 1)
    {
        return 35;
    }
  
    return 50;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
       
        AddIntakerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddIntakerCell"];
      cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.intakerVC = self;
        return cell;
    }
    if(indexPath.section == 1)
    {
        NSDictionary *dic = [_intakerArr objectAtIndex:indexPath.row];
        EitIntakerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EitIntakerCell"];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.intakerVC = self;
        cell.intakerDic = dic;
        cell.index = indexPath.row;
        return cell;
    }
    
    IntakerNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntakerNoticeCell"];
       cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
       
        NSIndexPath *index;
        
        for(int i = 0;i < _intakerArr.count;i++)
        {
            index = [NSIndexPath indexPathForRow:i inSection:1];
            EitIntakerCell *cell = (EitIntakerCell *)[tableView cellForRowAtIndexPath:index];
       
            if(indexPath.row == index.row)
            {
                cell.selectBut.selected = YES;
                cell.intakeName.textColor = kADWColor(44, 172, 230, 1);
                cell.eitBut.selected = YES;
            }
            else
            {
                cell.selectBut.selected = NO;
                cell.intakeName.textColor = kADWColor(80, 80, 80, 1);
                cell.eitBut.selected = NO;
            }
           
        }
        
        _selectIntaker = [NSNumber numberWithInteger:indexPath.row];
    }
}




-(void)rightButtonClick
{
    if(_selectIntaker != nil)
    {
        NSDictionary *dic = [_intakerArr objectAtIndex:[_selectIntaker integerValue]];
        NSString *name =[dic objectForKey:@"name"];
        
        if(_delegate && [_delegate respondsToSelector:@selector(didSelectIntaker:)])
        {
            [_delegate didSelectIntaker:name];
        }
    }
  
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString *)getIntakerPath
{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingPathComponent:@"intaker.plist"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
