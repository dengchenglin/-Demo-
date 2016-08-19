//
//  HHYNetworkEngine+Detail.m
//  HHY
//
//  Created by 谈文钊 on 14-5-31.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HHYNetworkEngine+Detail.h"
#import "Passenger.h"
#import "PersonModel.h"

#define kTokenSaveKey   @"HHY-Token"
#define kNormalBaseUrl  @"http://www.hhytours.com/interface/"

@implementation HHYNetworkEngine (Detail)

- (NSString *)getToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kTokenSaveKey];
}

- (void)saveToken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kTokenSaveKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)path:(NSString *)path needToken:(BOOL)needToken
{
    return needToken ? [NSString stringWithFormat:@"%@/%@", path, [self getToken]] : path;
}

- (BOOL)checkLogin
{
    return [self getToken] != nil;
}

- (void)logOut:(HHYResponseBlock)block
{
    [self saveToken:nil];
    [self saveUserID:nil];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"level"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"applyEmail"];
    
    block(nil, nil);
}

- (void)login:(NSString *)username password:(NSString *)password block:(HHYResponseBlock)block
{
    
    
 
    NSString *path = [@"user/login" stringByAppendingFormat:@"/%@/%@", username, password];
    [self postURLDataForPath:path
                  params:nil block:^(NSError *error, id data) {
                      if (!error) {
                          [self saveToken:data];
                      }
                      block(error, data);
                  }];
    
//    NSString *path = @"user/login";
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",password,@"password", nil];
////    [self postURLDataForPath:path params:dic block:^(NSError *error, id data) {
////        if (!error) {
////            [self saveToken:data];
////        }
////        block(error, data);
////    }];
//    
//    [self postURLDataForPath:[self path:@"user/register" needToken:NO]
//                      params:dic block:^(NSError *error, id data) {
//                          block(error, data);
//                      }];
}

- (void)registerUser:(NSDictionary *)dict block:(HHYResponseBlock)block
{
    [self postURLDataForPath:[self path:@"user/register" needToken:NO]
                   params:dict block:^(NSError *error, id data) {
                       block(error, data);
                   }];
}

- (void)queryOneUser:(HHYResponseBlock)block
{
    [self postDataForPath:[self path:@"user/queryOneUser" needToken:YES] params:nil block:^(NSError *error, id data) {
        PersonModel *p = nil;
        if (!error) {
            p = [[PersonModel alloc] initWithDictionary:data error:nil];
        }
        block(error, p);
    }];
}

- (void)updateUserInfo:(NSDictionary *)userInfo block:(HHYResponseBlock)block
{

//    [self getDataForPath:[self path:@"user/update" needToken:YES] params:userInfo block:^(NSError *error,id data){
//        block(error,data);
//    }];
    [self postURLDataForPath:[self path:@"user/update" needToken:YES] params:userInfo block:^(NSError *error,id data){
        block(error,data);
    }];
}

- (void)queryPassengers:(HHYResponseBlock)block
{
    [self postDataForPath:[self path:@"cycjr/query" needToken:YES] params:nil block:^(NSError *error, id data) {
        NSMutableArray *passagers = nil;
        if (!error) {
            passagers = [NSMutableArray arrayWithCapacity:[data count]];
            for (NSDictionary *dic in data) {
                Passenger *p = [[Passenger alloc] initWithDictionary:dic error:&error];
                p.ID = [dic objectForKey:@"id"];
                [passagers addObject:p];
            }
        }
        block(error, passagers);
    }];
}

- (void)findOnePassenger:(NSString *)passengerId block:(HHYResponseBlock)block
{
    [self postDataForPath:[self path:@"cycjr/findOnePassenger" needToken:YES] params:@{@"id": passengerId} block:^(NSError *error, id data) {
        
    }];
}

- (void)addPassenger:(NSDictionary *)passengerInfo block:(HHYResponseBlock)block
{
    [self postURLDataForPath:[self path:@"cycjr/addPassenger" needToken:YES] params:passengerInfo block:^(NSError *error, id data) {
        block(error,data);
    }];
}

- (void)updatePassenger:(NSDictionary *)passengerInfo block:(HHYResponseBlock)block
{
    [self postURLDataForPath:[self path:@"cycjr/update" needToken:YES] params:passengerInfo block:^(NSError *error, id data) {
        block(error,data);
    }];

}

- (void)deletePassenger:(NSString *)passengerId block:(HHYResponseBlock)block
{
    NSString *path = [[self path:@"cycjr/remove" needToken:YES] stringByAppendingFormat:@"/%@", passengerId];
    [self postURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}

- (void)queryCities:(NSInteger)type block:(HHYResponseBlock)block
{
    NSString *path = [[self path:@"cities/query" needToken:NO] stringByAppendingFormat:@"/%d", type];
    [self postURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}

-(void)queryAirTicket:(NSString *)tickUrl block:(HHYResponseBlock)block
{

    [self postURLDataForPath:[[self path:@"queryTicket/query" needToken:NO] stringByAppendingFormat:@"/%@", tickUrl] params:nil block:^(NSError *error, id data) {
        block(error, data);
    }];
}

-(void)saveOrder:(NSString *)string block:(HHYResponseBlock)block
{
    [self postURLDataForPath:[self path:@"order/saveOrder" needToken:YES] params:@{@"jsonOrder": string} block:^(NSError *error, id data) {
        block(error,data);
    }];
}

-(void)queryAirPlainOrder:(HHYResponseBlock)block
{
    [self postURLDataForPath:[self path:@"order/queryOrder" needToken:YES] params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}

-(void)queryOrderDetail:(NSString *)orderNum block:(HHYResponseBlock)block
{
    NSString *path = [[self path:@"order/orderDetail" needToken:YES] stringByAppendingFormat:@"/%@", orderNum];
    [self postURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}

-(void)orderChange:(NSDictionary *)dict block:(HHYResponseBlock)block
{
    [self postURLDataForPath:[self path:@"order/orderChange" needToken:YES] params:dict block:^(NSError *error, id data) {
        block(error,data);
    }];
}

-(void)examineApply:(NSString *)orderNum block:(HHYResponseBlock)block
{
    NSString *path = [[self path:@"examine/apply" needToken:YES] stringByAppendingFormat:@"/%@", orderNum];
    [self postURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}

- (void)feedBack: (NSDictionary *)connent
           block:(HHYResponseBlock)block
{
    NSString *path = [self path:@"articl/save" needToken:NO];
    [self postURLDataForPath:path  params:connent block:^(NSError *error, id data) {
        block(error,data);
    }];
}


-(void)tgqrule:(NSString *)airCode andSpace:(NSString *)space block:(HHYResponseBlock)block
{
    NSString *path = [[self path:@"tgqruler/query" needToken:NO] stringByAppendingFormat:@"/%@/%@", airCode, space];
    [self postURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}

-(void)examineApply:(NSString *)orderNum
           andEmail:(NSString *)email
              block:(HHYResponseBlock)block
{
    NSString *path = [[self path:@"examine/apply" needToken:YES] stringByAppendingFormat:@"?orderNo=%@&email=%@", orderNum,email];
    [self postURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}

- (void)getPayURL:(NSString *)orderNum block:(HHYResponseBlock)block;
{
    NSString *path = [[self path:@"order/sign" needToken:YES] stringByAppendingFormat:@"?orderNo=%@", orderNum];
    [self postURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}

//查询审批人
- (void)searchApplyPeople:(HHYResponseBlock)block;
{
    NSString *path = [self path:@"examine/queryEmail" needToken:YES];
    [self postURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}

//查询需要审批的机票订单
- (void)searchAirOrderNeedApply:(NSString *)email   block:(HHYResponseBlock)block
{
    NSString *path = [[self path:@"examine/queryOrder" needToken:YES] stringByAppendingFormat:@"?email=%@",email];
    
    [self postURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}

//机票领导审批
- (void)airOrderLeaderApply:(NSDictionary *)orderInfo block: (HHYResponseBlock )block;
{
    NSString *path = [[self path:@"examine/answer" needToken:YES] stringByAppendingFormat:@"?id=%@&state=%@&username=%@&orderNo=%@",@"-1",[orderInfo objectForKey:@"state"],[orderInfo objectForKey:@"username"], [orderInfo objectForKey:@"orderNum"]];
    
    [self postURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}

#pragma mark (开始接手酒店)



//获取城市列表
-(void)getcitylistWithBlock:(HHYResponseBlock)block
{
    NSString *path = @"/interface/quey_city_list.jspx";
    [self getHotelDataForPath:path params:nil block:^(NSError *error,id data){
        block(error ,data);
    }];
}


//酒店查询
-(void)searchHotelDic:(NSDictionary *)dic block:(HHYResponseBlock)block
{

    
    NSString *path = @"interface/hotel_list.jspx";
    [self getHotelDataForPath:path params:dic block:^(NSError *error, id data) {
        block(error,data);
    }];


}

//获取城市区域
-(void)getArealistCity:(NSString *)city block:(HHYResponseBlock)block
{
    NSString *path = @"interface/quey_dist_list.jspx";
    NSDictionary *dic = @{@"city":city};
    [self getHotelDataForPath:path params:dic block:^(NSError *error,id data){
        block(error,data);
    }];
}

//获取城市地标 
-(void)getlandMarklistCity:(NSString *)city block:(HHYResponseBlock)block
{
    NSString *path = @"interface/quey_landmark_list.jspx";
    NSDictionary *dic = @{@"city":city};
    [self getHotelDataForPath:path params:dic block:^(NSError *error,id data){
        block(error,data);
    }];
}

//获取床型
-(void)getbedTypelistWithblock:(HHYResponseBlock)block
{
    NSString *path = @"interface/quey_type_list.jspx";
    [self getHotelDataForPath:path params:nil block:^(NSError *error,id data){
        block(error,data);
    }];
}

//获取酒店服务项(决定如何初始化填写订单页面)
-(void)getHotelSevDic:(NSDictionary *)dic block:(HHYResponseBlock)block
{
        NSString *path = @"interface/hotel_order.jspx";
    [self getHotelDataForPath:path params:dic block:^(NSError *error,id data){
        block(error,data);
    }];
}

//提交酒店订单
-(void)submitHotelMessage:(NSDictionary *)dic block:(HHYResponseBlock)block
{
    NSString *path = @"interface/hotel_save_order.jspx";
    
    [self getHotelDataForPath:path params:dic block:^(NSError *error,id data){
        block(error,data);
    }];

}

//酒店订单列表
-(void)hotelOrderList:(NSDictionary *)dic block:(HHYResponseBlock)block
{
    
    NSUserDefaults *appDefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [appDefault objectForKey:@"userId"];
    
    NSString *path = [@"interface/order_hotel_list.jspx" stringByAppendingFormat:@"?source=app&userId=%@&pageNo=%@&pageSize=%@",userId,@"1",@"100"];

    [self postHotelURLDataForPath:path params:nil block:^(NSError *error,id data)
     {
         block(error,data);
     }];
}

//酒店订单取消
- (void)hotelOrderCacle:(NSString *)orderNum block:(HHYResponseBlock)block
{
    NSString *path = [@"interface/cancel_hotel_order.jspx" stringByAppendingFormat:@"?orderNo=%@", orderNum];
    [self OrderHotelCacle:path params:nil block:^(NSError *error,id data)
     {
         block(error,data);
     }];
}

//酒店订单详情
- (void)HotelOrderDetail:(NSString *)orderNum block:(HHYResponseBlock)block
{
    NSString *path = [@"interface/order_detail.jspx" stringByAppendingFormat:@"?orderNo=%@", orderNum];
    [self OrderHotelDetail:path params:nil block:^(NSError *error,id data)
     {
         block(error,data);
     }];
}

//酒店提交审批
- (void)HotelOrderApply:(NSString *)orderNum
               andEmail:(NSString *)email block:(HHYResponseBlock)block
{
    NSString *path = [@"interface/approval.jspx" stringByAppendingFormat:@"?orderNo=%@&email=%@", orderNum,email];
    [self OrderHotelDetail:path params:nil block:^(NSError *error,id data)
     {
         block(error,data);
     }];
}

//退改规定
-(void)getQuitRuleWithAirCode:(NSString *)airCode andSpace:(NSString *)space block:(HHYResponseBlock)block
{
    NSString *path = [NSString stringWithFormat:@"cloud/tgqruler/query/%@/%@",airCode,space];
    [self getDataForPath:path params:nil block:^(NSError * error ,id data){
    
        block(error,data);
    }];
}

//查询需要审批的酒店订单
- (void)searchHotelOrderNeedApply:(NSString *)email block:(HHYResponseBlock)block
{
    NSString *path = [[self path:@"interface/query_list_by_email.jspx" needToken:NO] stringByAppendingFormat:@"?email=%@",email];
    
    [self postHotelURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];

}


//审批通过
- (void)hotelOrderApplyPass:(NSString *)orderNum block:(HHYResponseBlock)block
{
    NSString *path = [[self path:@"interface/approved.jspx" needToken:NO] stringByAppendingFormat:@"?email=%@&orderNo=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"applyEmail"],orderNum];
    
    
    [self postURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}

//审批拒绝
- (void)hotelOrderApplyRefuse:(NSString *)ordernum block:(HHYResponseBlock)block
{
    NSString *path = [[self path:@"interface/refuse.jspx" needToken:NO] stringByAppendingFormat:@"?email=%@&orderNo=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"applyEmail"],ordernum];
    
    [self postURLDataForPath:path params:nil block:^(NSError *error, id data) {
        block(error,data);
    }];
}


@end
