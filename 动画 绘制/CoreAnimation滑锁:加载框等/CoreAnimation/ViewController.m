//
//  ViewController.m
//  CoreAnimation
//
//  Created by chenguangjiang on 15/9/29.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "ViewController.h"
#import "ShimmerView.h"
#import "CAShapeView.h"
#import "ConerView.h"
#import "CAShapeGroupView.h"
#import "CAReplicatorView.h"
#import "RefreshView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    //滑锁效果
    ShimmerView *shimmerView = [[ShimmerView alloc]initWithFrame:CGRectMake(0, 40, 320, 40)];
    [self.view addSubview:shimmerView];
    
    //加载框
    CAShapeView *shapeView = [[CAShapeView alloc]initWithFrame:CGRectMake(20, 200, 60, 60)];
    [self.view addSubview:shapeView];
    //组动画
    CAShapeGroupView *shapeGroupView = [[CAShapeGroupView alloc]initWithFrame:CGRectMake(100, 200, 60, 60)];
    [self.view addSubview:shapeGroupView];
    
        // 圆角
    ConerView *conerView = [[ConerView alloc]initWithFrame:CGRectMake(0, 80, 100, 100)];
    [self.view addSubview:conerView];
    
    //音效条
    CAReplicatorView *replicatorView = [[CAReplicatorView alloc]initWithFrame:CGRectMake(30, 265, 130, 120)];
    [self.view addSubview:replicatorView];
    
    RefreshView *refreshView = [[RefreshView alloc]initWithFrame:CGRectMake(30, 400, 100, 100)];
    [self.view addSubview:refreshView];
    
}


@end
