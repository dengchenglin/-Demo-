//
//  HotelRoomCell.h
//  HHY
//
//  Created by chenguangjiang on 14-11-5.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelDetailViewController.h"
#import "CustomPickView.h"
@interface HotelRoomCell : UITableViewCell<CustomPickDelegate>
@property (weak, nonatomic) IBOutlet UIButton *reserveBut;
@property (weak, nonatomic) IBOutlet UILabel *catType;
@property (weak, nonatomic) IBOutlet UILabel *bedType;
@property (weak, nonatomic) IBOutlet UILabel *cerealCount;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (copy ,nonatomic) NSString *roomID;
@property (nonatomic,copy)NSString *startDate;
@property (copy,nonatomic) NSDictionary *roomDic;
@property (copy,nonatomic)NSString *hotelName;
@property (nonatomic,assign)BOOL bookFlg;
@property (nonatomic,assign)NSInteger advance;
@property (weak, nonatomic) HotelDetailViewController *hotelDetailVC;
@property (copy,nonatomic) NSString *bf;
- (IBAction)reserve;

- (IBAction)catCount;

@property (weak, nonatomic) IBOutlet UIButton *catCountBUt;

@end
