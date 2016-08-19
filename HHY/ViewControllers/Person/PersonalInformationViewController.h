//
//  PersonalInformationViewController.h
//  HHY
//
//  Created by jiangjun on 14-5-6.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
@class PersonModel;

@interface PersonalInformationViewController : RootViewController
@property(nonatomic,retain)PersonModel *model;
@property(nonatomic,copy)NSString *token;
@property(nonatomic,retain)UILabel *usernameLable;
@property(nonatomic,retain)UILabel *nameTF;
@property(nonatomic,retain)UILabel *sexTF;
@property(nonatomic,retain)UILabel *birthdayTF;
@property(nonatomic,retain)UILabel *phoneNumTF;
@property(nonatomic,retain)UILabel *identityNumTF;
@property(nonatomic,retain)UILabel *emialLable;
@property(nonatomic,retain)UILabel *typeLable;
@end
