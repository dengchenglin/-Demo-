//
//  HotelOrderParameter.h
//  HHY
//
//  Created by chenguangjiang on 14-11-10.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelOrderParameter : NSObject
@property (nonatomic,retain)NSMutableDictionary *orderDic;
@property (nonatomic,retain)NSMutableDictionary *serviceDic;
@property (nonatomic,retain)NSMutableDictionary *intakerDic;
@property (nonatomic,retain)NSMutableDictionary *sevpriceDic;
+(HotelOrderParameter *)shareOrderParameter;


-(void)refreshServiceDic;
-(void)refreshIntakerDic;
-(void)refreshSerPriceDic;
@end
