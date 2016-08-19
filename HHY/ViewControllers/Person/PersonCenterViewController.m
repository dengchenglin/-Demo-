//
//  PersonCenterViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-24.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "CustomView.h"
#import "SelectTypeButton.h"
#import "MyTicketViewController.h"
#import "ChangYongPersonViewController.h"
#import "SystemNewsViewController.h"
#import "FeedBackViewController.h"
#import "ApplyTicktsViewController.h"
#import "PersonalInformationViewController.h"

@interface PersonCenterViewController ()
{
    BOOL isLeader;
    float addHeight;
}

@end

@implementation PersonCenterViewController

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
    [self initNav:@"个人中心"];
    [self createScreen];
    NSLog(@"%@", self.token);
}

-(void)createScreen
{
    NSUserDefaults *appDefault = [NSUserDefaults standardUserDefaults];
    NSString *level = [appDefault objectForKey:@"level"];
    if (([level isEqualToString:@"2"]) ||[level isEqualToString:@"3"]){//领导
        //
        isLeader = YES;
        addHeight = 30.0;
    } else {
        isLeader = NO;
        addHeight = 0.0;
    }
    
    
    
    CustomView *view1 = [[CustomView alloc] initWithFrame:CGRectMake(0, 40, 320, 180 + addHeight)];
    [self.view addSubview:view1];
    
    NSArray *titleArray;
    NSArray *imageArray;
    if (isLeader) {
        titleArray = @[@"我的订单", @"个人信息", @"常用乘机人", @"审批订单",@"系统消息", @"反馈"];
        imageArray = @[@"wodedingdan", @"gerenxinxi", @"changyongchengjiren", @"changyongchengjiren",@"xitongxiaoxi", @"fankui"];
    } else {
        titleArray = @[@"我的订单", @"个人信息", @"常用乘机人", @"系统消息", @"反馈"];
        imageArray = @[@"wodedingdan", @"gerenxinxi", @"changyongchengjiren", @"xitongxiaoxi", @"fankui"];
    }
    
    for (int i=0; i<[titleArray count]; i++) {
        if (i!=0) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, i*35, 280, 1)];
            imageView.image = [UIImage imageNamed:@"xian"];
            [view1 addSubview:imageView];
        }

        SelectTypeButton *button = [[SelectTypeButton alloc] initWithFrame:CGRectMake(40, i*35+4, 280, 29)];
        button.tag = 200+i;
        [view1 addSubview:button];
        button.typeLable.text = [titleArray objectAtIndex:i];
        [button addTarget:self action:@selector(choseNum:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageView = [AffUIToolBar imageviewRect:CGRectMake(15, 10+i*35, 16, 16) andimage:[UIImage imageNamed:[imageArray objectAtIndex:i]]];
        [view1 addSubview:imageView];
    }
}

-(void)choseNum:(UIButton *)button
{
    if (!isLeader) {
        switch (button.tag-200) {
            case 0:{
                MyTicketViewController *mvc = [[MyTicketViewController alloc] init];
                [self.navigationController pushViewController:mvc animated:YES];
                break;
            }case 1:{
                PersonalInformationViewController *pvc = [[PersonalInformationViewController alloc] init];
                [self.navigationController pushViewController:pvc animated:YES];
                break;
            }case 2:{
                ChangYongPersonViewController *vc =[[ChangYongPersonViewController alloc] init];
                vc.isOrderTicket = NO;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 3:{
                SystemNewsViewController *vc = [[SystemNewsViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 4:{
                FeedBackViewController *fvc = [[FeedBackViewController alloc] init];
                [self.navigationController pushViewController:fvc animated:YES];
                break;
            }
            default:
                break;
        }
        
    } else {
    
        switch (button.tag-200) {
            case 0:{
                MyTicketViewController *mvc = [[MyTicketViewController alloc] init];
                [self.navigationController pushViewController:mvc animated:YES];
                break;
            }case 1:{
                PersonalInformationViewController *pvc = [[PersonalInformationViewController alloc] init];
                [self.navigationController pushViewController:pvc animated:YES];
                break;
            }case 2:{
                ChangYongPersonViewController *vc =[[ChangYongPersonViewController alloc] init];
                vc.isOrderTicket = NO;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 3:{
                //订单审批
                ApplyTicktsViewController *theView = [[ApplyTicktsViewController alloc] init];
                [self.navigationController pushViewController:theView animated:YES];
                break;
            }
                
            case 4:{
                SystemNewsViewController *vc = [[SystemNewsViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 5:{
                FeedBackViewController *fvc = [[FeedBackViewController alloc] init];
                [self.navigationController pushViewController:fvc animated:YES];
                break;
            }
            default:
                break;
        }
    }
}

-(void)reback
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)rightClick
{
    
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
