//
//  CalloutMapAnnotation.m
//  ZNBC
//
//  Created by 杨晓龙 on 13-4-11.
//  Copyright (c) 2013年 yangxiaolong. All rights reserved.
//

#import "CalloutMapAnnotation.h"

@implementation CalloutMapAnnotation


@synthesize latitude;
@synthesize longitude;
@synthesize locationInfo;

- (id)initWithLatitude:(CLLocationDegrees)lat
		  andLongitude:(CLLocationDegrees)lon {
	if (self = [super init]) {
		self.latitude = lat;
		self.longitude = lon;
	}
	return self;
}


-(CLLocationCoordinate2D)coordinate{

	CLLocationCoordinate2D coordinate;
	coordinate.latitude = self.latitude;
	coordinate.longitude = self.longitude;
	return coordinate;
    

}


@end
