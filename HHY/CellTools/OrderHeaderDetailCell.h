//
//  OrderHeaderDetailCell.h
//  HHY
//
//  Created by chenguangjiang on 14-11-7.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHeaderDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *roomType;
@property (weak, nonatomic) IBOutlet UILabel *bedType;
@property (weak, nonatomic) IBOutlet UILabel *breakfast;

@property (weak, nonatomic) IBOutlet UILabel *price;
@end
