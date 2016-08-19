//
//  LoginModel.h
//  HHY
//
//  Created by jiangjun on 14-5-28.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject
+shareInstace;
-(void)setWangfan:(BOOL)value;
-(void)setInterNational:(BOOL)value;
-(void)setWangfanURL:(NSString *)string;
-(NSString *)getWangfanURL;
-(BOOL)getIsWangfan;
-(BOOL)getIsInterNational;
-(void)addOneRange:(id)obj;
-(NSMutableArray *)getRangeArray;
-(void)removeAllRange;
-(void)setIsSelectTicket:(BOOL)value;
-(BOOL)getISSelectTicket;
-(void)setDateString:(NSString *)string;
-(NSString *)getDateString;
-(void)setShippingspaceType:(NSString *)string;
-(NSString *)getshippingspaceType;
-(void)setStartEndPoint:(NSString *)string;
-(NSString *)getStartEndPoint;
-(void)setDateModel:(id)obj;
-(id)getDateModel;
-(void)setStartDateModel:(id)obj;
-(id)getStartDateModel;
-(void)setOrderTicketState:(BOOL)value;
-(BOOL)getOrderTicketState;
@end
