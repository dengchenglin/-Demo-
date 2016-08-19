//
//  OrderNoticeCell.m
//  HHY
//
//  Created by chenguangjiang on 14-11-7.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "OrderNoticeCell.h"
@implementation OrderNoticeCell

- (void)awakeFromNib {
    _noticelabel.characterSpacing = 1;
    _noticelabel.linesSpacing = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
