//
//  CustomAnnotation.m
//  HHY
//
//  Created by chenguangjiang on 14-11-15.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation
-(id)initWithHotelDic:(NSDictionary *)hotelDic
{
    if(self = [super init])
    {
        self.hotelDic = hotelDic;
    }
    return self;
}
-(void)setHotelDic:(NSDictionary *)hotelDic
{
    if(_hotelDic != hotelDic)
    {
        _hotelDic = [hotelDic copy];
    }
    float lat = [[NSString stringWithFormat:@"%@",[_hotelDic objectForKey:@"latitude"]] floatValue];
    float lon = [[NSString stringWithFormat:@"%@",[_hotelDic objectForKey:@"longitude"]] floatValue];
    _coordinate = CLLocationCoordinate2DMake(lat, lon);
    
    self.title = [_hotelDic objectForKey:@"hotelName"];
  
}
@end
