//
//  AirChangeDateCell.h
//  HHY
//
//  Created by jiangjun on 14-6-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirChangeDateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *gaiqiQian;
@property (weak, nonatomic) IBOutlet UIImageView *line1;
@property (weak, nonatomic) IBOutlet UILabel *startDateBefore;
@property (weak, nonatomic) IBOutlet UILabel *placeBefore;
@property (weak, nonatomic) IBOutlet UILabel *startTimeBefore;
@property (weak, nonatomic) IBOutlet UILabel *startPlaceBef;
@property (weak, nonatomic) IBOutlet UILabel *endtimeBef;
@property (weak, nonatomic) IBOutlet UILabel *endPlaceBef;
@property (weak, nonatomic) IBOutlet UILabel *airTypeBef;
@property (weak, nonatomic) IBOutlet UILabel *jipiaojiaBef;
@property (weak, nonatomic) IBOutlet UILabel *priceLableBef;
@property (weak, nonatomic) IBOutlet UILabel *suifeiBef;
@property (weak, nonatomic) IBOutlet UILabel *suiFeeBef;
@property (weak, nonatomic) IBOutlet UILabel *gaiqiHou;
@property (weak, nonatomic) IBOutlet UILabel *startDateAf;
@property (weak, nonatomic) IBOutlet UILabel *placeAf;
@property (weak, nonatomic) IBOutlet UILabel *startTimeAf;
@property (weak, nonatomic) IBOutlet UILabel *startPlaceAf;
@property (weak, nonatomic) IBOutlet UILabel *endTimeAf;
@property (weak, nonatomic) IBOutlet UILabel *endPlaceAf;
@property (weak, nonatomic) IBOutlet UILabel *airTypeAf;
@property (weak, nonatomic) IBOutlet UILabel *jipiaojiaAf;
@property (weak, nonatomic) IBOutlet UILabel *priceAf;
@property (weak, nonatomic) IBOutlet UILabel *suifeiAf;
@property (weak, nonatomic) IBOutlet UILabel *suifeeLable;
@property (weak, nonatomic) IBOutlet UILabel *gaiqiPriceLable;
@property (weak, nonatomic) IBOutlet UIButton *guidingButton;
-(void)chushihua;
@end
