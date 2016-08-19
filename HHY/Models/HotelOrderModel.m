//
//  HotelOrderModel.m
//  HHY
//
//  Created by 兵 张 on 14/11/16.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HotelOrderModel.h"

@implementation HotelOrderModel
@synthesize amount = _amount;
@synthesize bookDate = _bookDate;
@synthesize bookStatus = _bookStatus;
@synthesize contact = _contact;
@synthesize contract = _contract;
@synthesize email = _email;
@synthesize fax = _fax;
@synthesize guarantee = _guarantee;
@synthesize hhyAmount = _hhyAmount;
@synthesize hmcRef = _hmcRef;
@synthesize hotel = _hotel;
@synthesize hotelHotel = _hotelHotel;
@synthesize orderNum = _orderNum;
@synthesize orderStatus = _orderStatus;
@synthesize orderTime = _orderTime;
@synthesize tel = _tel;
@synthesize ver = _ver;

-(void)jiexiDict:(NSDictionary *)dict
{
    self.amount = [dict objectForKey:@"amount"];
    self.bookDate = [dict objectForKey:@"bookDate"];
    self.bookStatus = [dict objectForKey:@"bookStatus"];
    self.contact = [dict objectForKey:@"contact"];
    self.contract = [dict objectForKey:@"contract"];
    self.email = [dict objectForKey:@"email"];
    self.fax = [dict objectForKey:@"fax"];
    self.guarantee = [dict objectForKey:@"guarantee"];
    self.hhyAmount = [[dict objectForKey:@"hhyAmount"] stringValue];
    self.hmcRef = [dict objectForKey:@"hmcRef"];
    self.hotel = [dict objectForKey:@"hotel"];
    self.hotelHotel = [dict objectForKey:@"hotelHotel"];
    self.orderNum = [dict objectForKey:@"orderNum"];
    self.orderStatus = [dict objectForKey:@"orderStatus"];
    self.orderTime = [dict objectForKey:@"orderTime"];
    self.tel = [dict objectForKey:@"tel"];
    self.ver = [dict objectForKey:@"ver"];
}

@end
