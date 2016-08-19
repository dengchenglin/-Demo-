//
//  YourOrderViewController.m
//  HHY
//
//  Created by jiangjun on 14-5-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "YourOrderViewController.h"
#import "CustomView.h"
#import "ZhiFuButton.h"

#define LINE_COLOR [JJDevice colorWithR:112.0 G:185.0 B:235.0 A:1.0]
#define TEXT_COLOR [JJDevice colorWithR:216.0 G:110.0 B:0 A:1.0]
@interface YourOrderViewController ()

@end

@implementation YourOrderViewController

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initNav:@"订单详情"];
    self.view.backgroundColor = BG_COLRO;
    //[self createScreen];
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
