//
//  Passenger.h
//  HHY
//
//  Created by jiangjun on 14-6-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "JSONModel.h"

@interface Passenger : JSONModel
{
    NSInteger _baoxianfei;
}
@property (nonatomic, strong) NSString<Optional> *birthday;
@property (nonatomic, strong) NSString<Optional> *email;
@property (nonatomic, strong) NSString<Optional> *ID;
@property (nonatomic, strong) NSString<Optional> *mobile;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *note;
@property (nonatomic, strong) NSString<Optional> *sex;
@property (nonatomic, strong) NSString<Optional> *userId;
@property (nonatomic, strong) NSString<Optional> *zjh;
@property (nonatomic, strong) NSString<Optional> *zjlx;
-(NSDictionary *)getJson:(NSString *)capexFee andAllfuel:(NSString *)fuelFee andAirPrice:(NSString *)price;
-(void)setBaoxianfei:(NSInteger)num;
-(NSInteger)getbaoxianfei;
@end
