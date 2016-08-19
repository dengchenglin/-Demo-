//
//  ChangeDateViewController.h
//  HHY
//
//  Created by jiangjun on 14-5-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"

@interface ChangeDateViewController : RootViewController<UITextFieldDelegate>
@property(nonatomic,assign)BOOL isHotel;
@property(nonatomic,retain)UITextView *headTextView;
@property(nonatomic,retain)UILabel *nameLable;
@property(nonatomic,retain)UILabel *typeLable;
@property(nonatomic,retain)UILabel *orderNumberLable;
@property(nonatomic,retain)UILabel *startingLable;
@property(nonatomic,retain)UILabel *priceLable;
@property(nonatomic,retain)UITextField *nameTF;
@property(nonatomic,retain)UITextField *phoneTF;
@end
