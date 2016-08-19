//
//  CustomOverlayRenderer.h
//  MapView
//
//  Created by chenguangjiang on 14-12-29.
//  Copyright (c) 2014年 Orb. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CustomOverlayRenderer : MKOverlayPathRenderer
-(id)initWithCircle:(MKCircle *) circle withRadius:(double)radius;
@end
