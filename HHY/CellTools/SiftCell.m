//
//  SiftCell.m
//  HHY
//
//  Created by chenguangjiang on 14-11-3.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "SiftCell.h"

@implementation SiftCell

- (void)awakeFromNib
{
    _selectBut.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
