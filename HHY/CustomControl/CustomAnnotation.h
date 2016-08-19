//
//  CustomAnnotation.h
//  HHY
//
//  Created by chenguangjiang on 14-11-15.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"
@interface CustomAnnotation : NSObject<BMKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy)NSDictionary *hotelDic;
@property (nonatomic,copy)NSString *title;
-(id)initWithHotelDic:(NSDictionary *)hotelDic;
@end
