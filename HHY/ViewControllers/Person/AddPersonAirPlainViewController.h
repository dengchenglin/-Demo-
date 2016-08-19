//
//  AddPersonAirPlainViewController.h
//  HHY
//
//  Created by jiangjun on 14-4-25.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
@class SelectTypeButton;
@class Passenger;
@class SelectTypeButton;
@protocol AddPersonDelegate <NSObject>

-(void)refreshAirPerson;

@end
@interface AddPersonAirPlainViewController : RootViewController<UITextFieldDelegate,UIActionSheetDelegate>
@property(nonatomic,copy)NSString *headTitle;
@property(nonatomic,assign)BOOL editingEnable;
@property(nonatomic,retain)SelectTypeButton *personTypeButton;
@property(nonatomic,retain)SelectTypeButton *certTypeButton;
@property(nonatomic,retain)UITextField *nameTF;
@property(nonatomic,retain)UITextField *certNumTF;
@property(nonatomic,retain)SelectTypeButton *birthdayTF;
@property(nonatomic, retain)SelectTypeButton *sexTF;
@property(nonatomic,retain)UITextField *phoneTF;
@property(nonatomic,retain)UITextField *emailTF;
@property(nonatomic,retain)Passenger *userModel;
@property(nonatomic,copy)NSString *passegerType;
@property(nonatomic,copy)NSString *certType;
@property(nonatomic,weak)id<AddPersonDelegate>delegate;
@end

