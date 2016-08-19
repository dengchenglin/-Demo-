//
//  ApplyAirTicketsOrderTableViewCell.m
//  HHY
//
//  Created by 兵 张 on 14/11/22.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "ApplyAirTicketsOrderTableViewCell.h"

@implementation ApplyAirTicketsOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _lb1.textColor = [JJDevice colorWithR:137 G:137 B:137 A:1.0];
    _lb2.textColor = [JJDevice colorWithR:137 G:137 B:137 A:1.0];
    _lb3.textColor = [JJDevice colorWithR:137 G:137 B:137 A:1.0];
    _lb4.textColor = [JJDevice colorWithR:137 G:137 B:137 A:1.0];
    _lb5.textColor = [JJDevice colorWithR:137 G:137 B:137 A:1.0];
    _lbState.backgroundColor = [JJDevice colorWithR:137 G:137 B:137 A:1.0];
    
    _lbOrderNum.text = @"";
    _lbTime.text = @"";
    _lbPhone.text = @"";
    _lbContact.text = @"";
    _lbPrice.text = @"";
    _lbContact.textColor = [JJDevice colorWithR:54 G:128 B:241 A:1.0];
    _lbPrice.textColor = [JJDevice colorWithR:247 G:114 B:18 A:1.0];
    
    [_btCacle setBackgroundColor:[JJDevice colorWithR:247 G:114 B:18 A:1.0]];
    [_btCacle setTitle:@"取消" forState:0];
    [_btCacle setTitleColor:[UIColor whiteColor] forState:0];
    [_btPass setBackgroundColor:[JJDevice colorWithR:54 G:128 B:241 A:1.0]];
    [_btPass setTitle:@"确定" forState:0];
    [_btPass setTitleColor:[UIColor whiteColor] forState:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
