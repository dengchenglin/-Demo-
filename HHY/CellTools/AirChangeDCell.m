//
//  AirChangeDCell.m
//  HHY
//
//  Created by 兵 张 on 14/12/17.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "AirChangeDCell.h"

@implementation AirChangeDCell

- (void)awakeFromNib {
    // Initialization code
    UIColor *color = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:232/255.0];
    _line1.backgroundColor = color;
    _line2.backgroundColor = color;
    _line3.backgroundColor = color;
    _line4.backgroundColor = color;
    _line5.backgroundColor = color;
    _line6.backgroundColor = color;
    _line7.backgroundColor = color;
    _line8.backgroundColor = color;
    _line9.backgroundColor = color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)tgAction:(id)sender {
}
@end
