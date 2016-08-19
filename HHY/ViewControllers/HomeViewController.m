//
//  HomeViewController.m
//  HeheyuanDemo
//
//  Created by jiangjun on 14-4-22.
//  Copyright (c) 2014年 jiangjun. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "GNHotelViewController.h"
#import "AirTicketViewController.h"
#import "Person/PersonCenterViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
-(void)dealloc
{
    JJRelease(_hotelBT);
    JJRelease(_personBT);
    JJRelease(_plainBT);
    JJSuperDealloc;
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
    // Do any additional setup after loading the view.
    [self createScreen];
}

-(void)createScreen
{
    UIImageView *imageView = [AffUIToolBar imageviewRect:CGRectMake(50, 20, 220, 40) andimage:[UIImage imageNamed:@"logo"]];
    if (iPhone5) {
        imageView.frame = CGRectMake(50, 64, 220, 40);
    }
    [self.view addSubview:imageView];
    NSArray *imageArray = @[@"airplain", @"hotel", @"person"];
    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i!=2) {
            if (iPhone5) {
                button.frame = CGRectMake(20, 70+i*155+44, 280, 140);
            }else{
                button.frame = CGRectMake(20, 70+i*155, 280, 140);
            }
        }else{
            if (iPhone5) {
                button.frame = CGRectMake(20, 114+155*2, 280, 90);
            }else{
                button.frame = CGRectMake(20, 70+155*2, 280, 90);
            }
        }
        [button setBackgroundImage:[UIImage imageNamed:[imageArray objectAtIndex:i]] forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
}



-(void)btnClick:(UIButton *)button
{
    self.navigationController.navigationBar.hidden = NO;
    if (button.tag == 102) {
        if ([[HHYNetworkEngine sharedInstance] checkLogin]) {
            PersonCenterViewController *personVC = [[PersonCenterViewController alloc] init];
            [self.navigationController pushViewController:personVC animated:YES];
        } else {
            LoginViewController *lvc = [[LoginViewController alloc] init];
            lvc.isNormalLogin = YES;
            [self.navigationController pushViewController:lvc animated:YES];
        }
        
    }else if(button.tag == 101){
        GNHotelViewController *hvc = [[GNHotelViewController alloc] init];
        [self.navigationController pushViewController:hvc animated:YES];
    }else if(button.tag == 100){
        AirTicketViewController *tc = [[AirTicketViewController alloc] init];
        [self.navigationController pushViewController:tc animated:YES];
    }
        
}



-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
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
