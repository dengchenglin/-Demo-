//
//  AirPersonCell.m
//  HHY
//
//  Created by jiangjun on 14-5-21.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "AirPersonCell.h"

@implementation AirPersonCell

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
    self.nameLable.textColor = [JJDevice colorWithR:155 G:155 B:155 A:1];
    self.shenfenzhengLb.textColor = [JJDevice colorWithR:155 G:155 B:155 A:1];
    self.baoxianLable.textColor = [JJDevice colorWithR:155 G:155 B:155 A:1];
    self.nameLable.font = FONT_12;
    self.shenfenzhengLb.font = FONT_12;
    self.baoxianLable.font = FONT_12;
    self.nameText.font = FONT_12;
    self.inderfidyLable.font = FONT_12;
}
@end
