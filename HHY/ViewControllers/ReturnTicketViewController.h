//
//  ReturnTicketViewController.h
//  HHY
//
//  Created by jiangjun on 14-5-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
@class CustomView;

@interface ReturnTicketViewController : RootViewController
@property(nonatomic,assign)BOOL isHotel;
@property(nonatomic,retain)UILabel *nameLable;
@property(nonatomic,retain)UILabel *typeLable;
@property(nonatomic,retain)UILabel *orderNumberLable;
@property(nonatomic,retain)UILabel *startingLable;
@property(nonatomic,retain)UILabel *priceLable;
@property(nonatomic,retain)UILabel *detailLable;
@property(nonatomic,retain)CustomView *orderView;
@property(nonatomic,retain)UILabel *yuanshiOrder;
@property(nonatomic,retain)UILabel *shouldReturn;
@property(nonatomic,retain)UILabel *kouchuLable;
@property(nonatomic,retain)UILabel *reallyReturn;
@end
