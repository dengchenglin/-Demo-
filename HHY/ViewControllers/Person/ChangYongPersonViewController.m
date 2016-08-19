//
//  ChangYongPersonViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-24.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "ChangYongPersonViewController.h"
#import "AddPersonAirPlainViewController.h"
#import "CYCJRCell.h"
#import "Passenger.h"

@interface ChangYongPersonViewController ()<AddPersonDelegate>
{
    int longPressNum;
}

@end

@implementation ChangYongPersonViewController

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
    [self initNav:@"常用乘机人"];
    UILabel *lable = [AffUIToolBar lableCgrectmake:CGRectMake(0, 10, 320, 30) lableNametext:@"添加乘机人"];
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    _dataArray = [[NSMutableArray alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80, 10, 160, 30);
    [button setImage:[UIImage imageNamed:@"addPassenger"] forState:0];//13*11
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 127, 0, 0);
//    button.backgroundColor = [UIColor orangeColor];
    
//    button.frame = CGRectMake(210, 10, 10, 10);
    
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(addperson) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 320, self.view.frame.size.height-50-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self createLoadData];
}



-(void)createLoadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HHYNetworkEngine sharedInstance] queryPassengers:^(NSError *error, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!error) {
            self.dataArray = data;
            [_tableView reloadData];
        } else {
            [Utils alertWithTitle:error.localizedDescription message:nil];
        }
    }];
}

#pragma tableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    CYCJRCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[CYCJRCell alloc] init];
        
//        UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)] ;
//        [cell addGestureRecognizer:longPressGesture];
    }
    Passenger *p = [self.dataArray objectAtIndex:indexPath.row];
    cell.userName.text = p.name;
    cell.shenfengzheng.text = p.zjh;

    return cell;
}


//- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        //        NSLog(@"recognizer = %@", [recognizer description]);
//        CGPoint location = [recognizer locationInView:_tableView];
//        NSIndexPath * indexPath = [_tableView indexPathForRowAtPoint:location];
//        longPressNum = indexPath.row;
//        
//        UIAlertView *altView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"将此乘机人信息删除吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//        altView.tag = 124;
//        [altView show];
//    }
//}

#pragma tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isOrderTicket) {
        AddPersonAirPlainViewController *vc = [[AddPersonAirPlainViewController alloc] init];
        vc.editingEnable = YES;
        vc.headTitle = @"编辑常用乘机人";
        vc.userModel = [self.dataArray objectAtIndex:indexPath.row];
    
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self.target addCJR:[self.dataArray objectAtIndex:indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:nil message:@"确定要删除此乘机人" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
        alt.tag = 300 + indexPath.row;
        alt.delegate = self;
        [alt show];
        
    }
}

-(void)addperson
{
    AddPersonAirPlainViewController *avc = [[AddPersonAirPlainViewController alloc] init];
    avc.headTitle = @"新增常用乘机人";
    avc.editingEnable = NO;
    avc.delegate = self;
    [self.navigationController pushViewController:avc animated:YES];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag>=300) {
        //
            if (buttonIndex == 1) {
                //确定删除
                //数据操作
                NSLog(@"%@",self.dataArray);
                    Passenger *p = [self.dataArray objectAtIndex:alertView.tag - 300];
                NSLog(@"%@",p);
                [self.dataArray removeObjectAtIndex:longPressNum];
                NSLog(@"%@",p.ID);
                [[HHYNetworkEngine sharedInstance] deletePassenger:p.ID block:^(NSError *error, id data) {
                    if (!error) {
                        [self createLoadData];
                        [_tableView reloadData];
                    }
                    
                }];
            }
    
        }
  
}

-(void)refreshAirPerson
{
    [self createLoadData];
    [_tableView reloadData];
}

@end


