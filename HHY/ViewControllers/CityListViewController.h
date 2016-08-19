//
//  CityListViewController.h
//  HHY
//
//  Created by jiangjun on 14-4-28.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "RootViewController.h"
@class CityModel;

@protocol CityListViewControllerDelegate <NSObject>
-(void)staringCity:(CityModel *)model;
-(void)endingCity:(CityModel *)model;
@end

@interface CityListViewController : RootViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tabView;
    BOOL isCN;
}
@property(nonatomic,retain)CityModel *currentCity;
@property(nonatomic,retain)CityModel *needCity;
@property(nonatomic,assign)BOOL isStarting;
@property(nonatomic,copy)NSString *titleString;
@property(nonatomic,retain)NSMutableArray *cityCNArray;
@property(nonatomic,retain)NSMutableArray *cityCJArray;
@property(nonatomic,retain)NSArray *hotcityCNArray;
@property(nonatomic,retain)NSArray *hotcityCJArray;
@property(nonatomic,retain)NSMutableArray *lableCNArray;
@property(nonatomic,retain)NSMutableArray *lableCJArray;
@property(nonatomic,weak)id<CityListViewControllerDelegate>target;
@end
