//
//  RootViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"

@interface RootViewController ()<UIAlertViewDelegate>

@end

@implementation RootViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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
    self.edgesForExtendedLayout = UIRectEdgeNone;    self.view.backgroundColor = BG_COLRO;
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbg"] forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(reback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    [self createRighteItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startLogin) name:kNeedLogin object:nil];
}

-(void)createRighteItem
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(260, 6, 20, 20);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"fhsy"]forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(returnRoot) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(232, 0, 30, 44);
    [phoneButton setImage:[UIImage imageNamed:@"playPhone"]forState:UIControlStateNormal];
    [phoneButton addTarget:self action:@selector(playPhone) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *tempItem = [[UIBarButtonItem alloc] initWithCustomView:phoneButton];
    self.navigationItem.rightBarButtonItems = @[rightItem,tempItem];
}
-(void)playPhone
{
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"呼叫" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alt.tag = 9;
    alt.delegate = self;
    [alt show];
}
-(void)returnRoot
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)startLogin
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.isTokenError = YES;
    UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    [self.navigationController pushViewController:navCon animated:YES];
    [self presentViewController:navCon animated:YES completion:nil];
}

-(void)initNav:(NSString *)title
{
    UILabel *textLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 120, 44)];
    textLable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = textLable;
    textLable.backgroundColor = [UIColor clearColor];
    textLable.textColor = [UIColor whiteColor];
    textLable.text = title;
    textLable.font = [UIFont systemFontOfSize:20];
}

-(void)reback
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 9)
    {
        if(buttonIndex == 1)
        {
           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:010-84549980"]];
        }
    }
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
