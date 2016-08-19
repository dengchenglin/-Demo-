//
//  CustomNavBar.m
//  HHY
//
//  Created by chenguangjiang on 14-11-7.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "CustomNavBar.h"

@implementation CustomNavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kADWColor(44, 172, 230, 1);
    }
    return self;
}

-(void)layoutSubviews
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but setFrame:CGRectMake(15, 25, 30, 30)];
    [but setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(leftclick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:but];
}
-(void)creatTitle:(NSString *)customTitle
{
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 25, 180, 30)];
    titlelabel.text = customTitle;
    titlelabel.font = [UIFont systemFontOfSize:19];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.textColor = [UIColor whiteColor];
    [self addSubview:titlelabel];
}
-(void)creatRightButtonWithFrame:(CGRect)frame andImageName:(NSString *)imageName andTitle:(NSString *)rightTitle
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but setFrame:frame];
    if(imageName)
    {
        [but setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if(rightTitle)
    {
        [but setTitle:rightTitle forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    [but addTarget:self action:@selector(rightclick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:but];
}
-(void)leftclick
{
    if(_delegate)
    {
        UIViewController *vc = (UIViewController *)_delegate;
        if(vc.navigationController)
        {
          
            [vc.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [vc dismissViewControllerAnimated:YES completion:nil];
        }
    }
  
}
-(void)rightclick
{
    if(_delegate && [_delegate respondsToSelector:@selector(rightButtonClick)])
    {
        [_delegate rightButtonClick];
    }
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
