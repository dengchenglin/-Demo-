//
//  HotelCell.m
//  HHY
//
//  Created by jiangjun on 14-4-23.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HotelCell.h"

@implementation HotelCell

- (void)awakeFromNib
{
    [_headImageView.layer setCornerRadius:5];
    [_headImageView.layer setMasksToBounds:YES];
}

-(void)layoutSubviews
{   if(_DetLable.text && _DetLable.text.length != 0)
    {
    
        CGSize size = [_DetLable.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(215, 100)];
        [_DetLable setFrame:CGRectMake(87, 54, 215, size.height)];
        if(size.height > 20)
        {
            [_lineview setFrame:CGRectMake(0, 63 + size.height, 320, 1)];
        }
        else
        {
             [_lineview setFrame:CGRectMake(0, 68 + size.height, 320, 1)];
        }
      
        
    }
    else
    {
        [_DetLable setFrame:CGRectMake(87, 54, 215, 21)];
         [_lineview setFrame:CGRectMake(0, 79, 320, 1)];
    }


}

-(void)setGrade:(NSString *)grade
{
    if(_grade != grade)
    {
        _grade = [grade copy];
    }
    if(_grade)
    {
        if([_grade isEqualToString:@"5"])
        {
            self.scroceLable.text = @"豪华型";
        }
        else if([_grade isEqualToString:@"4"])
        {
            self.scroceLable.text = @"高端型";
        }
        else if([_grade isEqualToString:@"3"])
        {
            self.scroceLable.text = @"舒服型";
        }
        else
        {
            self.scroceLable.text = @"经济型 ";
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
