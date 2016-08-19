//
//  GNHotelViewController.h
//  HHY
//
//  Created by jiangjun on 14-4-22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"

@class SelectTypeButton;
@class CitySelectButton;

@interface GNHotelViewController : RootViewController<UITextFieldDelegate>
{
    BOOL isChange;
}

@property(nonatomic,retain)SelectTypeButton *cityBT;
@property(nonatomic,retain)UITextField *cityTF;
@property(nonatomic,retain)CitySelectButton *bookDateBT;
@property(nonatomic,retain)CitySelectButton *leavDateBT;
@property(nonatomic,retain)SelectTypeButton *starBT;

@property(nonatomic,copy) NSString *cityName;
@property(nonatomic,copy) NSString *cityCode;
@property(nonatomic,copy) NSString *hotelName;
@property(nonatomic,copy) NSString *intakeDate;
@property(nonatomic,copy) NSString *outakeDate;
@property(nonatomic,copy) NSString *hotelLevel;

@end
