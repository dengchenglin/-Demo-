//
//  BookHotelViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "BookHotelViewController.h"

@interface BookHotelViewController ()

@end

@implementation BookHotelViewController

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
    [self initNav:@"订单填写"];
    [self createScreen];
}

-(void)createScreen
{
    UILabel *nameLable = [AffUIToolBar lableCgrectmake:CGRectMake(0, 0, 200, 30) lableNametext:@"--------------------"];
    [self.view addSubview:nameLable];
    
    UILabel *dateLable = [AffUIToolBar lableCgrectmake:CGRectMake(0, 40, 100, 30) lableNametext:[NSString stringWithFormat:@"入住:%@", @"cevervej"]];
    [self.view addSubview:dateLable];
    
    UILabel *leavingLable = [AffUIToolBar lableCgrectmake:CGRectMake(160, 40, 100, 40) lableNametext:[NSString stringWithFormat:@"离店:%@", @"cevervej"]];
    [self.view addSubview:leavingLable];
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
