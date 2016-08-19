//
//  AddAirTicketViewController.h
//  HHY
//
//  Created by jiangjun on 14-5-22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
#import "CityListViewController.h"
#import "DateSelectViewController.h"
@class SelectTypeButton;
@class CitySelectButton;
@class CityModel;
@class DayModel;

@interface AddAirTicketViewController : RootViewController<CityListViewControllerDelegate,DateSelectViewControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,retain)SelectTypeButton *startPointBT;
@property(nonatomic,retain)SelectTypeButton *destinationBT;
@property(nonatomic,retain)CitySelectButton *startDateBT;
@property(nonatomic,retain)UILabel *startDateLable;
@property(nonatomic,retain)UIImageView *endDateView;
@property(nonatomic,retain)SelectTypeButton *companyBT;
@property(nonatomic,retain)SelectTypeButton *chengkeBT;
@property(nonatomic,retain)SelectTypeButton *changweiBT;
@property(nonatomic,retain)CityModel *startingModel;
@property(nonatomic,retain)CityModel *endingModel;
@property(nonatomic,retain)DayModel *startingDay;
@property(nonatomic,retain)DayModel *endingDay;
@property(nonatomic,retain)UIImageView *lineView;
@property(nonatomic,retain)NSArray *shippingspaceArray;
@property(nonatomic,retain)NSArray *airWayArray;
@property(nonatomic,copy)NSString *airWayType;
@property(nonatomic,copy)NSString *shippingspaceType;
@property(nonatomic,copy)NSString *pasengerType;
@end
