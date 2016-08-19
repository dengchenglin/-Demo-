//
//  FootView.m
//  HHY
//
//  Created by jiangjun on 14-6-5.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "FootView.h"

@implementation FootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self getView];
    }
    return self;
}

-(void)getView
{
    _lable1 = [AffUIToolBar lableCgrectmake:CGRectMake(20, 0, 300, 20) lableNametext:@"退票原因"];
    _lable1.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lable1];
    
    _lable2 = [AffUIToolBar lableCgrectmake:CGRectMake(20, 80, 300, 20) lableNametext:@"注:退改票应尽量提前申请,否则手续费会大幅增加"];
    _lable2.font = FONT_12;
    _lable2.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_lable2];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, 320, 60)];
    _textView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_textView];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"gaiqi"] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageNamed:@"gaiqiBTN"] forState:UIControlStateHighlighted];
    _button.frame = CGRectMake(40, 120, 240, 40);
    [self addSubview:_button];
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
