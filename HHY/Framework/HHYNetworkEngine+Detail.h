//
//  HHYNetworkEngine+Detail.h
//  HHY
//
//  Created by 谈文钊 on 14-5-31.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HHYNetworkEngine.h"

@interface HHYNetworkEngine (Detail)

- (NSString *)getToken;


#pragma mark - User

- (BOOL)checkLogin;

- (void)logOut:(HHYResponseBlock)block;

- (void)login:(NSString *)username password:(NSString *)password block:(HHYResponseBlock)block;

- (void)registerUser:(NSDictionary *)dict block:(HHYResponseBlock)block;

- (void)queryOneUser:(HHYResponseBlock)block;

- (void)updateUserInfo:(NSDictionary *)userInfo block:(HHYResponseBlock)block;



#pragma mark - Passenger

- (void)queryPassengers:(HHYResponseBlock)block;

- (void)findOnePassenger:(NSString *)passengerId block:(HHYResponseBlock)block;

- (void)addPassenger:(NSDictionary *)passengerInfo block:(HHYResponseBlock)block;

- (void)updatePassenger:(NSDictionary *)passengerInfo block:(HHYResponseBlock)block;

- (void)deletePassenger:(NSString *)passengerId block:(HHYResponseBlock)block;



#pragma mark - Cities

//type为1代表国内，type为2代表国际
- (void)queryCities:(NSInteger)type block:(HHYResponseBlock)block;

#pragma mark -AirPlain
//机票查询
-(void)queryAirTicket:(NSString *)tickUrl block:(HHYResponseBlock)block;
//生成订单
-(void)saveOrder:(NSString *)string block:(HHYResponseBlock)block;
//订单列表
-(void)queryAirPlainOrder:(HHYResponseBlock)block;

//订单详情
-(void)queryOrderDetail:(NSString *)orderNum block:(HHYResponseBlock)block;
//订单退改
-(void)orderChange:(NSDictionary *)dict block:(HHYResponseBlock)block;

//退改规定
-(void)tgqrule:(NSString *)airCode andSpace:(NSString *)space block:(HHYResponseBlock)block;

//反馈
- (void)feedBack: (NSDictionary *)connent
           block:(HHYResponseBlock)block;

//提交公司审批
-(void)examineApply:(NSString *)orderNum
           andEmail:(NSString *)email
              block:(HHYResponseBlock)block;
//获取支付链接
- (void)getPayURL:(NSString *)orderNum block:(HHYResponseBlock)block;

//查询审批人
- (void)searchApplyPeople:(HHYResponseBlock)block;

//查询需要审批的订单
- (void)searchAirOrderNeedApply:(NSString *)email   block:(HHYResponseBlock)block;

//机票领导审批
- (void)airOrderLeaderApply:(NSDictionary *)orderInfo block: (HHYResponseBlock )block;

#pragma mark (开始接手酒店)
//获取城市列表
-(void)getcitylistWithBlock:(HHYResponseBlock)block;

//酒店查询
-(void)searchHotelDic:(NSDictionary *)dic block:(HHYResponseBlock)block;


//获取城市区域
-(void)getArealistCity:(NSString *)city block:(HHYResponseBlock)block;
//获取城市地标
-(void)getlandMarklistCity:(NSString *)city block:(HHYResponseBlock)block;

//获取床型
-(void)getbedTypelistWithblock:(HHYResponseBlock)block;

//获取酒店服务项(决定如何初始化填写订单页面)
-(void)getHotelSevDic:(NSDictionary *)dic block:(HHYResponseBlock)block;

//提交酒店订单
-(void)submitHotelMessage:(NSDictionary *)dic block:(HHYResponseBlock)block;

//酒店订单列表
-(void)hotelOrderList:(NSDictionary *)dic block:(HHYResponseBlock)block;

//酒店订单取消
- (void)hotelOrderCacle:(NSString *)orderNum block:(HHYResponseBlock)block;

//酒店订单详情
- (void)HotelOrderDetail:(NSString *)orderNum block:(HHYResponseBlock)block;


//酒店提交审批
- (void)HotelOrderApply:(NSString *)orderNum
               andEmail:(NSString *)email
                  block:(HHYResponseBlock)block;

//退改规定
-(void)getQuitRuleWithAirCode:(NSString *)airCode andSpace:(NSString *)space block:(HHYResponseBlock)block;

//查询需要审批的酒店订单
- (void)searchHotelOrderNeedApply:(NSString *)email block:(HHYResponseBlock)block;

//审批通过
- (void)hotelOrderApplyPass:(NSString *)orderNum block:(HHYResponseBlock)block;

//审批拒绝
- (void)hotelOrderApplyRefuse:(NSString *)ordernum block:(HHYResponseBlock)block;
@end
