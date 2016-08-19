//
//  MapViewController.h
//  HHY
//
//  Created by chenguangjiang on 14-11-15.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
#import "BMapKit.h"

@interface MapViewController : RootViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>

{
    BMKMapView *_mapView;
    BMKLocationService *_locService;
}
@property (nonatomic,copy)NSArray *hotellist;
@property (nonatomic,copy)NSString *startDate;
@property (nonatomic,copy)NSString *endDate;
@property (nonatomic,copy)NSString *hotelName;
@property (nonatomic,copy)NSString *cityName;


@end
