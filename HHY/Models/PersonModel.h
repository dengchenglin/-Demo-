//
//  PersonModel.h
//  HHY
//
//  Created by jiangjun on 14-6-5.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "JSONModel.h"

@interface PersonModel : JSONModel
@property(nonatomic,strong)NSString<Optional> *id;
@property(nonatomic,strong)NSString<Optional> *staffName;
@property(nonatomic,strong)NSString<Optional> *userName;
@property(nonatomic,strong)NSString<Optional> *password;
@property(nonatomic,strong)NSString<Optional> *sex;
@property(nonatomic,strong)NSString<Optional> *creditType;
@property(nonatomic,strong)NSString<Optional> *creditNo;
@property(nonatomic,strong)NSString<Optional> *mobile;
@property(nonatomic,strong)NSString<Optional> *email;
@property(nonatomic,strong)NSString<Optional> *state;
@property(nonatomic,strong)NSString<Optional> *birthday;
@property(nonatomic,strong)NSString<Optional> *company;
@property(nonatomic,strong)NSString<Optional> *department;
@property(nonatomic,strong)NSString<Optional> *keshi;
@end
