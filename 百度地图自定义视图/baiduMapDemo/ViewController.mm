//
//  ViewController.m
//  baiduMapDemo
//
//  Created by 杨晓龙 on 13-3-29.
//  Copyright (c) 2013年 yangxiaolong. All rights reserved.
//

#import "ViewController.h"
#import "CustomPointAnnotation.h"
#import "CallOutAnnotationView.h"
#import "BusPointCell.h"
#import "CalloutMapAnnotation.h"


@interface ViewController (){

    CalloutMapAnnotation *_calloutMapAnnotation;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self initMapView];
    

    
    
}

-(void)delloc{


    [mymapview release];
    
    [super dealloc];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


-(void) initMapView{

    mymapview = [[BMKMapView alloc] initWithFrame:CGRectMake(0,0,320,460+(iPhone5?88:0))];
    mymapview.delegate = self;
    self.view = mymapview;
   

    
    //添加自定义Annotation
     CLLocationCoordinate2D center = {39.91669,116.39716};
    
    CustomPointAnnotation *pointAnnotation = [[CustomPointAnnotation alloc] init];
//    pointAnnotation.title = @"我是中国人";//因为继承了BMKPointAnnotation，所以这些title,subtitle都可以设置
//    pointAnnotation.subtitle = @"我爱自己的祖国";
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"拍照",@"alias",@"速度",@"speed",@"方位",@"degree",@"位置",@"name",nil];
    pointAnnotation.pointCalloutInfo =dict;
    
    pointAnnotation.coordinate = center;
    [mymapview addAnnotation:pointAnnotation];
    [pointAnnotation release];
    
    BMKCoordinateSpan span = {0.04,0.03};
    BMKCoordinateRegion region = {center,span};
    [mymapview setRegion:region animated:NO];

//    [mymapview setShowsUserLocation:YES];

}




#pragma mark
#pragma mark - BMKMapview delegate
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    
    static NSString *annotationIdentifier = @"customAnnotation";
    if ([annotation isKindOfClass:[CustomPointAnnotation class]]) {
        
        BMKPinAnnotationView *annotationview = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        
        annotationview.image = [UIImage imageNamed:@"marker"];
//        [annotationview setPinColor:BMKPinAnnotationColorGreen];
        [annotationview setAnimatesDrop:YES];
        annotationview.canShowCallout = NO;
        
        return annotationview;
        
    }
    else if ([annotation isKindOfClass:[CalloutMapAnnotation class]]){
        
        //此时annotation就是我们calloutview的annotation
        CalloutMapAnnotation *ann = (CalloutMapAnnotation*)annotation;
        
        //如果可以重用
        CallOutAnnotationView *calloutannotationview = (CallOutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"calloutview"];
        
        //否则创建新的calloutView
        if (!calloutannotationview) {
            calloutannotationview = [[[CallOutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"calloutview"] autorelease];

            BusPointCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"BusPointCell" owner:self options:nil] objectAtIndex:0];
            
            [calloutannotationview.contentView addSubview:cell];
            calloutannotationview.busInfoView = cell;
        }
        
        //开始设置添加marker时的赋值
        calloutannotationview.busInfoView.aliasLabel.text = [ann.locationInfo objectForKey:@"alias"];
        calloutannotationview.busInfoView.speedLabel.text = [ann.locationInfo objectForKey:@"speed"];
        calloutannotationview.busInfoView.degreeLabel.text =[ann.locationInfo objectForKey:@"degree"];
        calloutannotationview.busInfoView.nameLabel.text =  [ann.locationInfo objectForKey:@"name"];
        
        return calloutannotationview;
        
    }
    
    return nil;
    
}

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    
    NSLog(@"didSelectAnnotationView");
    //CustomPointAnnotation 是自定义的marker标注点，通过这个来得到添加marker时设置的pointCalloutInfo属性
    CustomPointAnnotation *annn = (CustomPointAnnotation*)view.annotation;
    
    
    if ([view.annotation isKindOfClass:[CustomPointAnnotation class]]) {
        
        //如果点到了这个marker点，什么也不做
        if (_calloutMapAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutMapAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        //如果当前显示着calloutview，又触发了select方法，删除这个calloutview annotation
        if (_calloutMapAnnotation) {
            [mapView removeAnnotation:_calloutMapAnnotation];
            _calloutMapAnnotation=nil;
            
        }
        //创建搭载自定义calloutview的annotation
        _calloutMapAnnotation = [[[CalloutMapAnnotation alloc] initWithLatitude:view.annotation.coordinate.latitude andLongitude:view.annotation.coordinate.longitude] autorelease];
        
        //把通过marker(ZNBCPointAnnotation)设置的pointCalloutInfo信息赋值给CalloutMapAnnotation
        _calloutMapAnnotation.locationInfo = annn.pointCalloutInfo;
        
        [mapView addAnnotation:_calloutMapAnnotation];

        
        
        [mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
        
    }
    
    
}


-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    
    if (_calloutMapAnnotation&&![view isKindOfClass:[CallOutAnnotationView class]]) {

        if (_calloutMapAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            _calloutMapAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            [mapView removeAnnotation:_calloutMapAnnotation];
            _calloutMapAnnotation = nil;
        }
        
        
    }

}












@end
