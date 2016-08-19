//
//  HotelReturnResonCell.m
//  HHY
//
//  Created by 兵 张 on 14/11/20.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HotelReturnResonCell.h"

@implementation HotelReturnResonCell

- (void)awakeFromNib {
    // Initialization code
    
    UIView *viewInput = [[UIView alloc] init];
    UIButton *button;
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button sizeToFit];
    
    viewInput.frame = CGRectMake(0, 0, 320, button.bounds.size.height);
    button.frame = CGRectOffset(button.frame, 320 - button.bounds.size.width, 0);
    viewInput.backgroundColor = [UIColor grayColor];
    [viewInput addSubview:button];
    
    _tvReason.inputAccessoryView = viewInput;
    
    lenght = [_tvReason.text length];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)resetHeight:(float)height
{
    _tvReason.frame = CGRectMake(10, 5, 300, height);
    _line.frame = CGRectMake(10, 95+height-90, 310, 1);
    _lbBz.frame = CGRectMake(10, 95+height-90, 50, 20);
    _tfBZ.frame = CGRectMake(60, 95+height-90, 250, 20);
}


- (void)done:(UIButton *)sender
{
    [_tvReason resignFirstResponder];
    if (lenght!=[_tvReason.text length]) {
           [[NSNotificationCenter defaultCenter] postNotificationName:@"textChanged" object:_tvReason.text];
    }
}

@end
