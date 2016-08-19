//
//  HotelOrderModel.h
//  HHY
//
//  Created by 兵 张 on 14/11/16.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelOrderModel : NSObject

@property(nonatomic, retain)NSString *amount;//合同计价
@property(nonatomic, retain)NSString *bookDate;//订单日期
@property(nonatomic, retain)NSString *bookStatus;//平台订单状态
@property(nonatomic, retain)NSString *contact;//联系人
@property(nonatomic, retain)NSString *contract;//HC10000599--酒店合同
@property(nonatomic, retain)NSString *email;//邮箱
@property(nonatomic, retain)NSString *fax;//传真
@property(nonatomic, retain)NSString *guarantee;//保证入住
@property(nonatomic, retain)NSString *hhyAmount;//和合缘合计价格
@property(nonatomic, retain)NSString *hmcRef;//平台订单号
@property(nonatomic, retain)NSString *hotel;//酒店代码
@property(nonatomic, retain)NSDictionary *hotelHotel;
                        //{hotelName="\U5317\U4eac\U56fd\U8d38\U996d\U5e97";}
@property(nonatomic, retain)NSString *orderNum;//和合缘订单号
@property(nonatomic, retain)NSString *orderStatus;//和合缘订单状态
@property(nonatomic, retain)NSString *orderTime;
@property(nonatomic, retain)NSString *tel;//联系电话
@property(nonatomic, retain)NSString *ver;//合同版本


-(void)jiexiDict:(NSDictionary *)dict;

@end
