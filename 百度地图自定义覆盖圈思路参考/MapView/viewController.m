//
//  jp_co_orbViewController.m
//  MapView
//
//  Created by Michael on 3/3/14.
//  Copyright (c) 2014 Orb. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "viewController.h"
#import "WildcardGestureRecognizer.h"
#import "CustomMapOverlay.h"
#import "CustomOverlayView.h"

@interface viewController ()

@end

@implementation viewController

/* Default radius size in PX*/
double const circleRadius = 0;

/* Default Location */
#define TOKYO_LATITUDE 35.6895
#define TOKYO_LONGITUDE 139.6917
#define ZOOM_DISTANCE 50
#define DEFAULT_RADIUS 100;

double offset;
double oldoffset;
double setRadius = DEFAULT_RADIUS;

bool panEnabled = YES;
CLLocationCoordinate2D droppedAt;
MKMapPoint lastPoint;
CustomMKCircleOverlay *circleView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapView.delegate = self;
    
    droppedAt = CLLocationCoordinate2DMake(TOKYO_LATITUDE, TOKYO_LONGITUDE);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(droppedAt,ZOOM_DISTANCE,ZOOM_DISTANCE);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    /* Add Custom MKCircle with Annotation*/
    [self addCircle];

    /* Setup Touch listener for custom circle */
    WildcardGestureRecognizer * tapInterceptor = [[WildcardGestureRecognizer alloc] init];
    
    
    
    //刚开始触摸时的回调
    tapInterceptor.touchesBeganCallback = ^(NSSet * touches, UIEvent * event) {
        UITouch *touch = [touches anyObject];
        
        //将触摸点先转化成经纬度 再转化成地图坐标
        CGPoint p = [touch locationInView:self.mapView];
        
        CLLocationCoordinate2D coord = [self.mapView convertPoint:p toCoordinateFromView:self.mapView];
        MKMapPoint mapPoint = MKMapPointForCoordinate(coord);
        
        
        
        
        //覆盖物在地图上的范围
        MKMapRect mapRect = [circleView circlebounds];
        
        double xPath = mapPoint.x - mapRect.origin.x;
        double yPath = mapPoint.y - mapRect.origin.y;
        
        
        //判断触摸到的位置是否在圆里面
        /* Test if the touch was within the bounds of the circle */
        if(xPath >= 0 && yPath >= 0 && xPath < mapRect.size.width && yPath < mapRect.size.height){
            NSLog(@"Disable Map Panning");
            
            //手指滑动动时必须确保地图此时是不能被滑动的
            /*
             This block is to ensure scrollEnabled = NO happens before the any move event.
             */
            __block int t = 0;
            dispatch_async(dispatch_get_main_queue(), ^{
                t = 1;
                
                self.mapView.scrollEnabled = NO;//地图此时不能滑动
                panEnabled = NO;//手指此时要能滑动
                
                //获取覆盖物的纬度范围，实际上可以看成覆盖物的直径
                oldoffset = [circleView getCircleOffset];
            });


            NSLog(@"Hit");
        }else{
            self.mapView.scrollEnabled = YES;
        }
        lastPoint = mapPoint;//记录手指移开时的那个点
    };
    
    
    //滑动过程中的回调 会调用很多次
    tapInterceptor.touchesMovedCallback = ^(NSSet * touches, UIEvent * event) {
        if(!panEnabled && [event allTouches].count == 1){
            UITouch *touch = [touches anyObject];
            
            //同上  先拿到触摸点在地图中的坐标
            CGPoint p = [touch locationInView:self.mapView];
            
            CLLocationCoordinate2D coord = [self.mapView convertPoint:p toCoordinateFromView:self.mapView];
            MKMapPoint mapPoint = MKMapPointForCoordinate(coord);
            
            
            
            //当前地图显示的范围
            MKMapRect mRect = self.mapView.visibleMapRect;
            //覆盖物的范围
            MKMapRect circleRect = [circleView circlebounds];
            //NSLog(@"radius: %f", [circleView getCircleRadius]);
            
            
            //滑动时 覆盖物会扩大  当大于当前地图显示范围的0.95倍时 那么就需要扩大当前地图的显示范围
            /* Check if the map needs to zoom */
            if(circleRect.size.width > mRect.size.width *.95){
                MKCoordinateRegion region;
                //Set Zoom level using Span
                MKCoordinateSpan span;
                region.center=droppedAt;
                span.latitudeDelta=self.mapView.region.span.latitudeDelta * 2.0;
                span.longitudeDelta=self.mapView.region.span.longitudeDelta * 2.0;
                region.span=span;
                [_mapView setRegion:region animated:TRUE];
            }
            
            //反之当小于当前地图显示范围的0.25倍时则需要缩小当前地图显示范围
            if(circleRect.size.width < mRect.size.width *.25){
                MKCoordinateRegion region;
                //Set Zoom level using Span
                MKCoordinateSpan span;
                region.center=droppedAt;
                span.latitudeDelta=_mapView.region.span.latitudeDelta /3.0002;
                span.longitudeDelta=_mapView.region.span.longitudeDelta /3.0002;
                region.span=span;
                [_mapView setRegion:region animated:TRUE];
            }
            
            
           
            /* Calculate new offset */
            if((oldoffset + ((mapPoint.x - lastPoint.x)/10)) > 0){
                offset = oldoffset + ((mapPoint.x - lastPoint.x)/10);
                
                 //圆变大或变小后 需要更新圆的半径并重新绘制
                [circleView setCircleOffset:oldoffset + ((mapPoint.x - lastPoint.x)/10)];
            }
            
        }
    };
    
    //滑动结束后 一切还原
    tapInterceptor.touchesEndedCallback = ^(NSSet * touches, UIEvent * event) {
        panEnabled = YES;
        
        NSLog(@"Enable Map Panning");
        
        self.mapView.zoomEnabled = YES;
        self.mapView.scrollEnabled = YES;
        self.mapView.userInteractionEnabled = YES;
    };

    [self.mapView addGestureRecognizer:tapInterceptor];

}

- (void)mapView:(MKMapView *)mapView
        annotationView:(MKAnnotationView *)annotationView
        didChangeDragState:(MKAnnotationViewDragState)newState
        fromOldState:(MKAnnotationViewDragState)oldState {
    if(newState == MKAnnotationViewDragStateStarting){
        panEnabled = YES;
    }
    if (newState == MKAnnotationViewDragStateEnding) {
        droppedAt = annotationView.annotation.coordinate;
        NSLog(@"dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
        [self addCircle];
    }

  
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    [annotationView setDraggable:YES];
    annotationView.pinColor = MKPinAnnotationColorPurple;
    
    [annotationView setSelected:YES animated:YES];
    return [annotationView init];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay{
 
  
    circleView = [[[CustomMKCircleOverlay alloc] initWithCircle:(MKCircle *)overlay withRadius:200] init];
    circleView.delegate = self;
   // CustomOverlayView *customView = [[CustomOverlayView alloc]initWithOverlay:overlay withMapRaduis:500];
    return circleView;
}

-(void)onRadiusChange:(double)radius{
    setRadius = radius;
    
    NSString *distance;
    if(radius > 1000){
        radius /= 1000;
        distance = [NSString stringWithFormat:@"%.02f km", radius];
    }else{
        distance = [NSString stringWithFormat:@"%.f m", radius];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.distanceLabel setText:distance];
    });
}

-(void)addCircle{
    if(point == nil){
        point = [[MKPointAnnotation alloc] init];
        point.coordinate = droppedAt;
        [self.mapView addAnnotation:point];
    }
    if(circle != nil)
        [self.mapView removeOverlay:circle];
    circle = [MKCircle circleWithCenterCoordinate:droppedAt radius:circleRadius];
    [self.mapView addOverlay: circle];
    [circleView setCircleOffset:offset];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
