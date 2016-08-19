//
//  LinkPeopleCell.m
//  HHY
//
//  Created by jiangjun on 14-5-21.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "LinkPeopleCell.h"

@implementation LinkPeopleCell

- (void)awakeFromNib
{
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenKeyboard) name:@"airHiddenkeyboard" object:nil];
}

-(void)hiddenKeyboard{
    for(UITextField *textfield in self.contentView.subviews)
    {
        [textfield resignFirstResponder];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
