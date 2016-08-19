//
//  UserModel.h
//  HHY
//
//  Created by jiangjun on 14-5-7.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "JSONModel.h"

@interface UserModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *birthday;
@property(nonatomic,strong)NSString<Optional> *creditNo;
@property(nonatomic,strong)NSString<Optional> *creditType;
@property(nonatomic,strong)NSString<Optional> *email;
@property(nonatomic,strong)NSString<Optional> *mobile;
@property(nonatomic,strong)NSString<Optional> *password;
@property(nonatomic,strong)NSString<Optional> *sex;
@property(nonatomic,strong)NSString<Optional> *staffName;
@property(nonatomic,strong)NSString<Optional> *state;
@property(nonatomic,strong)NSString<Optional> *uid;
@property(nonatomic,strong)NSString<Optional> *userName;
@end
