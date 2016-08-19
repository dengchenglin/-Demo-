//
//  HotelDetailViewController.h
//  HHY
//
//  Created by chenguangjiang on 14-11-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface HotelDetailViewController : RootViewController
@property (nonatomic,copy)NSDictionary *detailDic;
@property (nonatomic,copy)NSString *hotelName;
@property (nonatomic,copy)NSString *cityName;
@property (nonatomic,copy)NSString *startDate;
@property (nonatomic,copy)NSString *endDate;
//@property (nonatomic,copy)NSString *hotelName;
//@property (nonatomic,copy)NSString *cityName;
//@property (nonatomic,copy)NSString *hotelLevel;
//@property (nonatomic,assign)NSInteger pageNo;
//@property (nonatomic,assign)NSInteger pageSize;
//@property (nonatomic,copy)NSString *cityCode;
//@property (nonatomic,copy)NSString *sortType;
//@property (nonatomic,copy)NSString *priceMin;
//@property (nonatomic,copy)NSString *priceMax;
//@property (nonatomic,copy)NSDictionary *siftDic;


-(void)reserveWithRoomID:(NSString *)roomID andRoomNum:(NSString *)roomNum andRoomDic:(NSDictionary *)roomDic andHotelName:(NSString *)hotelName;
@end
