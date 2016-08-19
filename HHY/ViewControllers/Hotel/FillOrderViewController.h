//
//  FillOrderViewController.h
//  HHY
//
//  Created by chenguangjiang on 14-11-7.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"

@interface FillOrderViewController : RootViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic,copy)NSDictionary *roomDic;
@property (nonatomic,copy)NSString *roomID;
@property (nonatomic,copy)NSString *startDate;
@property (nonatomic,copy)NSString *endDate;
@property (nonatomic,copy)NSString *roomNum;
@property (nonatomic,copy)NSString *hotelName;

@property (nonatomic,assign)BOOL isSubmitOrder;
@end
