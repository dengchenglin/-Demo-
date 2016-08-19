//
//  CustomButton.m
//  HHY
//
//  Created by jiangjun on 14-4-24.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createbt];
    }
    return self;
}

-(void)createbt
{
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, self.frame.size.height-3)];
    _nameLable.textColor = [UIColor grayColor];
    _nameLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLable];
    
    self.lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-3, 160, 3)];
    [self addSubview:_lineView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
