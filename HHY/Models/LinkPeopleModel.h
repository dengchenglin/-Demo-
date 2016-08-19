//
//  LinkPeopleModel.h
//  HHY
//
//  Created by jiangjun on 14-5-28.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkPeopleModel : NSObject
@property(nonatomic,assign)int company;	//公司id
@property(nonatomic,assign)int dept;	//部门id
@property(nonatomic,assign)int secondDept;	//二级部门id
@property(nonatomic,copy)NSString *name;	//姓名
@property(nonatomic,copy)NSString *mobile;	//手机
@property(nonatomic,copy)NSString *phoneNo;	//电话
@property(nonatomic,copy)NSString *email;	//Email
@property(nonatomic,copy)NSString *payType;	//支付方式
@property(nonatomic,copy)NSString *otherNeed;	//其他需求
@property(nonatomic,copy)NSString *reason;	//出差原因
@property(nonatomic,assign)int profession;	//同业
@property(nonatomic,assign)int source;	//来源细分id
@property(nonatomic,assign)int orderNature;	//订单性质
-(NSDictionary *)getJason;
@end
