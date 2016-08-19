//
//  MapViewController.m
//  HHY
//
//  Created by chenguangjiang on 14-11-15.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//


#import "MapViewController.h"
#import "BMKLocationService.h"
#import "CustomAnnotation.h"
#import "CustomAnnotationView.h"
#import "HotelDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "BKCustomBut.h"
@interface MapViewController ()
{
    NSTimer *_timer;
    CGFloat paopaoHeight;
    BMKActionPaopaoView *_selectPaopaoView;
    BMKAnnotationView *_selectAnnotationView;
    CustomAnnotation *_selctAnnotation;
}
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav:@"地图"];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, kScreenHeight - 64)];
    [self.view addSubview:_mapView];
    
    _locService = [[BMKLocationService alloc]init];
    _mapView.delegate = self;
    
    _locService.delegate = self;
      [self addannotation];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate = self;
    isfirst = YES;
    [self startLocation];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1000 target:self selector:@selector(timerLocation) userInfo:nil repeats:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;
    [_locService stopUserLocationService];
    [_timer invalidate];
    
}
-(void)addannotation
{
    
    
    for(NSDictionary *dic in _hotellist)
    {
        CustomAnnotation* annotation = [[CustomAnnotation alloc]initWithHotelDic:dic];
    
        [_mapView addAnnotation:annotation];
    }
    
}
static bool isfirst = YES;
-(void)timerLocation
{
    isfirst = NO;
    [self startLocation];
}
- (void)startLocation{
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
  
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    
    CLLocationCoordinate2D currentCLLocation = _mapView.centerCoordinate;
    [_mapView updateLocationData:userLocation];
    if(isfirst)
    {
        CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
        BMKCoordinateSpan span = {0.1,0.1};
        BMKCoordinateRegion region = {coordinate,span};
        [_mapView setRegion:region];
    }
    else
    {
        [_mapView setCenterCoordinate:currentCLLocation];
    }
    
    
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    [_locService stopUserLocationService];
}


-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    
    
    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
   
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        newAnnotationView.canShowCallout = YES;
        newAnnotationView.centerOffset = CGPointMake(20, 15);
        return newAnnotationView;
    }
    return nil;
}

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
  

    CustomAnnotation *annotation = (CustomAnnotation *)view.annotation;
    NSDictionary *dic = annotation.hotelDic;
    BKCustomBut *but =[BKCustomBut buttonWithType:UIButtonTypeCustom];
    [but setFrame:CGRectMake(-20, -10, 230, 60)];
 
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, but.frame.size.width, 60)];

    [backImageView.layer setCornerRadius:4];
    [backImageView.layer setBorderWidth:1];
    backImageView.backgroundColor = [UIColor blackColor];
    backImageView.alpha = 0.5;
  
    [but addSubview:backImageView];
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];

    NSString *hotelNum = [dic objectForKey:@"hotel"];
    
    if(hotelNum != nil || hotelNum.length != 0)
    {
        NSString *imageUrlStr = [NSString stringWithFormat:@"http://www.huamin.com.hk/image/hotel/%@.jpg",hotelNum];
        
        
        [imageView setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"nopic.jpg"]];
        
    }
    else
    {
        NSString *imageUrlStr = @"http://www.huamin.com.hk/image/hotel/nopic.jpg";
        
        [imageView setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"nopic.jpg"]];
    }
    [but addSubview:imageView];
    UILabel *hotelName = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 160, 15)];
    hotelName.text = [dic objectForKey:@"hotelName"];
    CGSize size1 = [hotelName.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(500, 15)];
    [hotelName setFrame:CGRectMake(60, 5, size1.width, 15)];
    [but setFrame:CGRectMake(-20, -10, size1.width + 65, 60)];
    [backImageView setFrame:CGRectMake(0, 0, but.frame.size.width, 60)];
    hotelName.textColor = kADWColor(255, 255, 255, 1);
    hotelName.font = [UIFont systemFontOfSize:13];
    [but addSubview:hotelName];
    UILabel *typeName =[[UILabel alloc]initWithFrame:CGRectMake(60, 25, 160, 15)];
    NSString *grade = [NSString stringWithFormat:@"%@",[dic objectForKey:@"grade"]];
    if([grade isEqualToString:@"5"]){typeName.text = @"豪华型";}
   else if([grade isEqualToString:@"4"]){typeName.text = @"高端型";}
   else if([grade isEqualToString:@"3"]){typeName.text = @"舒服型";}
   else if([grade isEqualToString:@"0"]){typeName.text = @"经济型";}
    typeName.font =[UIFont systemFontOfSize:12];
    typeName.textColor = kADWColor(255, 255, 255, 1);
    [but addSubview:typeName];
    
    NSString *address = [dic objectForKey:@"address"];
    CGSize size = [address sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(500, 15)];
    UILabel *addresslabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 40, size.width, 15)];
    addresslabel.numberOfLines = 0;
    addresslabel.text = address;
    addresslabel.font =[UIFont systemFontOfSize:12];
    addresslabel.textColor = kADWColor(255, 255, 255, 1);
    [but addSubview:addresslabel];
    
    
    

    if(size.width > size1.width)
    {
        [but setFrame:CGRectMake(-20, -10, 70 + size.width, 60)];
        [backImageView setFrame:CGRectMake(0, 0, but.frame.size.width, 60)];

    }
    for(UIView *v in view.paopaoView.subviews)
    {
        v.hidden = YES;
        if([v isKindOfClass:[BKCustomBut class]])
        {
            [v removeFromSuperview];
            
        }
            
    }
    _selectPaopaoView = view.paopaoView;
    _selectAnnotationView = view;
    _selctAnnotation = (CustomAnnotation *)view.annotation;
    [but addTarget:self action:@selector(goDetail) forControlEvents:UIControlEventTouchUpInside];
    [view.paopaoView addSubview:but];
}
-(void)goDetail
{
    if(_selctAnnotation)
    {
        HotelDetailViewController *ctl = [[HotelDetailViewController alloc]init];
        ctl.detailDic = _selctAnnotation.hotelDic;
        ctl.startDate = _startDate;
        ctl.endDate = _endDate;
        ctl.hotelName = [_selctAnnotation.hotelDic objectForKey:@"hotelName"];
        ctl.cityName = _cityName;
      
        [self.navigationController pushViewController:ctl animated:YES];
    }
}
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{

}
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi
{

}
-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    
    
    
}
-(void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
  
    
}





- (void)dealloc
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
