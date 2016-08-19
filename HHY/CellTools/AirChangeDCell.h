//
//  AirChangeDCell.h
//  HHY
//
//  Created by 兵 张 on 14/12/17.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirChangeDCell : UITableViewCell

//改前
@property (strong, nonatomic) IBOutlet UILabel *bDate;
@property (strong, nonatomic) IBOutlet UILabel *bCityToCIty;
@property (strong, nonatomic) IBOutlet UILabel *bStartTime;
@property (strong, nonatomic) IBOutlet UILabel *bStatePlace;
@property (strong, nonatomic) IBOutlet UILabel *bEndTime;
@property (strong, nonatomic) IBOutlet UILabel *bEndPlace;
@property (strong, nonatomic) IBOutlet UILabel *bAirPlaneInfo;
@property (strong, nonatomic) IBOutlet UILabel *bairPrice;
@property (strong, nonatomic) IBOutlet UILabel *bAirPriceText;

@property (strong, nonatomic) IBOutlet UILabel *bShuiText;
@property (strong, nonatomic) IBOutlet UIImageView *bShui;


//改后
@property (strong, nonatomic) IBOutlet UILabel *aDate;
@property (strong, nonatomic) IBOutlet UILabel *aCityToCIty;
@property (strong, nonatomic) IBOutlet UILabel *aStartTime;
@property (strong, nonatomic) IBOutlet UILabel *aStartPlace;
@property (strong, nonatomic) IBOutlet UILabel *aEndTime;
@property (strong, nonatomic) IBOutlet UILabel *aEdnPlace;
@property (strong, nonatomic) IBOutlet UILabel *aAirLineInfo;
@property (strong, nonatomic) IBOutlet UILabel *aAirLinePrice;
@property (strong, nonatomic) IBOutlet UILabel *aAirLinePriceText;
@property (strong, nonatomic) IBOutlet UILabel *aShuiText;
@property (strong, nonatomic) IBOutlet UILabel *aGQPrice;


@property (strong, nonatomic) IBOutlet UIImageView *line1;
@property (strong, nonatomic) IBOutlet UIImageView *line2;
@property (strong, nonatomic) IBOutlet UIImageView *line3;
@property (strong, nonatomic) IBOutlet UIImageView *line4;
@property (strong, nonatomic) IBOutlet UIImageView *line5;
@property (strong, nonatomic) IBOutlet UIImageView *line6;
@property (strong, nonatomic) IBOutlet UIImageView *line7;
@property (strong, nonatomic) IBOutlet UIImageView *line8;
@property (strong, nonatomic) IBOutlet UIImageView *line9;
@property (strong, nonatomic) IBOutlet UIButton *tgButton;


@end
