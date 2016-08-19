//
//  ApplyPeopleModel.h
//  HHY
//
//  Created by 兵 张 on 14/11/20.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplyPeopleModel : NSObject

@property(nonatomic, retain)NSString *company;
@property(nonatomic, retain)NSString *dept;
@property(nonatomic, retain)NSString *email;
@property(nonatomic, retain)NSString *fname;
@property(nonatomic, retain)NSString *peopleID;
@property(nonatomic, retain)NSString *keshi;
@property(nonatomic, retain)NSString *sname;

@property(nonatomic, assign)BOOL isChooesd;

- (void)jieXi:(NSDictionary *)dic;

@end
