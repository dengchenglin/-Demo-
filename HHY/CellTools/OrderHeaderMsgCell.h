//
//  OrderHeaderMsgCell.h
//  HHY
//
//  Created by chenguangjiang on 14-11-7.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHeaderMsgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hotelName;
@property (weak, nonatomic) IBOutlet UILabel *startDate;
@property (weak, nonatomic) IBOutlet UILabel *endDate;
@property (weak, nonatomic) IBOutlet UILabel *roomCount;

@end
