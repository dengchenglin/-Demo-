//
//  ShimmerView.m
//  CoreAnimation
//
//  Created by chenguangjiang on 15/9/29.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "ShimmerView.h"

@implementation ShimmerView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor blackColor];
        [self createView];
    }
    return self;
}
//滑锁效果
-(void)createView{
    UILabel * maskView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    maskView.text = @"MASKLABELHE";
    maskView.textAlignment = NSTextAlignmentCenter;
    maskView.font = [UIFont systemFontOfSize:40];
    maskView.textColor = [UIColor whiteColor];
    [self addSubview:maskView];
    [self.layer addSublayer:maskView.layer];
    
    CAGradientLayer *maskLayer = [CAGradientLayer layer];
    UIColor *maskedColor = [UIColor colorWithWhite:1.0 alpha:1];
    UIColor *unmaskedColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    maskLayer.colors = @[(__bridge id)unmaskedColor.CGColor,(__bridge id)maskedColor.CGColor,(__bridge id)unmaskedColor.CGColor];
    // 渐变颜色的区间分布，locations的数组长度和color一致
    maskLayer.locations = @[@(0.2),
                            @(0.5),
                            @(0.8)];
    maskLayer.startPoint = CGPointMake(0, 0);
    maskLayer.endPoint = CGPointMake(1, 0);
    maskLayer.frame = CGRectMake(0, 0, 320, 40);
    maskView.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.fromValue = @[@(0),@(0),@(0.2)];
    animation.toValue = @[@(0.8),@(1),@(1)];
    animation.duration = 2.5;
    animation.repeatCount = HUGE;
    [maskLayer addAnimation:animation forKey:@"locations"];
}

-(void)drawRect:(CGRect)rect{
  
}

@end
