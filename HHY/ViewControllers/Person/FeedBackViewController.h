//
//  FeedBackViewController.h
//  HHY
//
//  Created by jiangjun on 14-4-25.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"

@interface FeedBackViewController : RootViewController<UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,retain)UITextField *emailTF;
@property(nonatomic,retain)UITextField *phoneTF;
@property(nonatomic,retain)UITextView *pingjiaTV;
@end
