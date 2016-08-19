//
//  AirOrderListCell.h
//  HHY
//
//  Created by jiangjun on 14-6-6.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirOrderListCell : UITableViewCell
@property(nonatomic,retain)UILabel *orderNumLable;
@property(nonatomic,retain)UILabel *orderPriceCount;
@property(nonatomic,retain)UILabel *priceLable;
@property(nonatomic,retain)UILabel *stateLable;
@property(nonatomic,retain)UIImageView *rightView;
-(void)changeFrame;
-(void)getCell;
@end
