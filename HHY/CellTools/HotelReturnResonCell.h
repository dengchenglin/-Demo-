//
//  HotelReturnResonCell.h
//  HHY
//
//  Created by 兵 张 on 14/11/20.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelReturnResonCell : UITableViewCell
{
    int lenght;
}

@property (strong, nonatomic) IBOutlet UITextView *tvReason;
@property (strong, nonatomic) IBOutlet UITextField *tfBZ;
@property (strong, nonatomic) IBOutlet UILabel *line;
@property (strong, nonatomic) IBOutlet UILabel *lbBz;

- (void)resetHeight:(float)height;

@end
