//
//  EditingPersonalInfoViewController.h
//  HHY
//
//  Created by jiangjun on 14-5-6.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
@class PersonModel;
@class SelectTypeButton;
@protocol EditingPersonDelegate <NSObject>

-(void)refreshData;

@end

@interface EditingPersonalInfoViewController : RootViewController<UITextFieldDelegate,UIActionSheetDelegate>
@property(nonatomic,copy)NSString *token;
@property(nonatomic,retain)UITextField *nameTF;
@property(nonatomic,retain)SelectTypeButton *sexTF;
@property(nonatomic,retain)SelectTypeButton *birthdayTF;
@property(nonatomic,retain)UITextField *phoneNumTF;
@property(nonatomic,retain)UITextField *identityNumTF;
@property(nonatomic,retain)UITextField *emialTF;
@property(nonatomic,retain)PersonModel *model;
@property(nonatomic,assign)NSString *typeNumber;
@property(nonatomic,retain)SelectTypeButton *typebutton;
@property (nonatomic,weak)id<EditingPersonDelegate>delegate;
@end
