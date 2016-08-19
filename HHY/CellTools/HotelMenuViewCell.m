//
//  HotelMenuViewCell.m
//  HHY
//
//  Created by jiangjun on 14-4-25.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HotelMenuViewCell.h"

@implementation HotelMenuViewCell

- (void)awakeFromNib
{
    // Initialization code
    [_btCacel setBackgroundColor:[UIColor colorWithRed:54/255.0 green:128/255.0 blue:214/255.0 alpha:1.0]];
    [_btCacel setTitleColor:[UIColor whiteColor] forState:0];
    
    [_btChange setBackgroundColor:[UIColor colorWithRed:247/255.0 green:114/255.0 blue:18/255.0 alpha:1.0]];
    [_btChange setTitleColor:[UIColor whiteColor] forState:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
