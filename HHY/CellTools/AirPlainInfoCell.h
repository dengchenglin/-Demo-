//
//  AirPlainInfoCell.h
//  HHY
//
//  Created by jiangjun on 14-6-3.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirPlainInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UILabel *placeLable;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *startPlace;
@property (weak, nonatomic) IBOutlet UILabel *endTime;
@property (weak, nonatomic) IBOutlet UILabel *endPlace;
@property (weak, nonatomic) IBOutlet UILabel *jixingType;
@property (weak, nonatomic) IBOutlet UILabel *jipiajiaLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *suifei;
@property (weak, nonatomic) IBOutlet UILabel *suiPrice;
@property (weak, nonatomic) IBOutlet UIButton *tuigaiButton;

@end
