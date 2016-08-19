//
//  ViewController.m
//  RefreshDemo
//
//  Created by chenguangjiang on 15/10/27.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "RefreshHeader.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface ViewController ()<RefreshDelegate,BMKMapViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong) BMKMapView* mapView ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
//    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 20);
//    _scrollView.backgroundColor = [UIColor brownColor];
//    [self.view addSubview:_scrollView];
//    
//    
//    RefreshHeader *header = [[RefreshHeader alloc]init];
//    header.delegate = self;
//    header.scrollView = _scrollView;
    
    
}


@end
