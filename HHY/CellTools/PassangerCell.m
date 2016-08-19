//
//  PassangerCell.m
//  HHY
//
//  Created by jiangjun on 14-6-3.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "PassangerCell.h"

@implementation PassangerCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)chushihua
{
    self.nameLable.font = FONT_14;
    self.shenfengzhen.textColor = [UIColor grayColor];
    self.shenfengzhen.font = FONT_14;
    self.nameText.font = FONT_14;
    self.sfzText.textColor = [UIColor grayColor];
    self.sfzText.font = FONT_14;
}
@end
