//
//  HotelPayCell.m
//  HHY
//
//  Created by 兵 张 on 14/11/15.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HotelPayCell.h"

@implementation HotelPayCell

- (void)awakeFromNib {
    // Initialization code
    _lbPrice.textColor = [JJDevice colorWithR:239 G:94 B:0 A:1];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)TGrole:(id)sender {
    [Utils alertWithTitle:@"退改规定" message:@"取消规则：入住前1日内更改，收取首晚100%。入住前1日内取消，收取首晚100%。预订未到，收取首晚100%。"];
}
@end
