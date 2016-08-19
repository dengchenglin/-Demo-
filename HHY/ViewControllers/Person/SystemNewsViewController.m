//
//  SystemNewsViewController.m
//  HHY
//
//  Created by jiangjun on 14-4-25.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "SystemNewsViewController.h"

@interface SystemNewsViewController ()

@end

@implementation SystemNewsViewController

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
    [self initNav:@"系统消息"];
    [self creatView];
}

- (void)creatView
{
    
    [self loadData];
}

- (void)loadData
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 260)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = kADWColor(100, 100, 100, 1);
    label.numberOfLines = 0;
    label.text = @"  最近经常有咋骗电话或短信，编造各种理由诱骗乘客，一定不要轻信，请与航空公司官方客服电话确认，或致电本公司010-8454-9980\n  谨防被骗!!\n各航空公司得官方电话:\n国航 95583\n东航(上航) 95530\n南航 95539\n海航 950718\n山航 400-60-96777\n深航 95080\n厦航 95557\n川航400-830-0999\n\n                         北京和合缘国际旅行社有限公司";
    [self.view addSubview:label];
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
