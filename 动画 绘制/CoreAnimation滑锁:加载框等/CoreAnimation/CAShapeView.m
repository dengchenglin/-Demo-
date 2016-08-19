//
//  CAShapeView.m
//  CoreAnimation
//
//  Created by chenguangjiang on 15/9/29.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "CAShapeView.h"

@implementation CAShapeView
{
    CAShapeLayer  *shapeLayer;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self createView];
    }
    return self;
}
-(void)createView{
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    //根据CGRect画正圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self
                          .bounds];
    //UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:30 startAngle:-M_PI endAngle:M_PI clockwise:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeEnd = 0.8;
    [self.layer addSublayer:shapeLayer];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [shapeLayer removeAllAnimations];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration  =  1.5;
    animation.autoreverses = NO;//代表动画每次重复执行的效果会跟上一次相反
    animation.cumulative = NO;//逐渐增加
    animation.fromValue = @(0);
    animation.toValue = @(2 * M_PI);
    animation.repeatCount = HUGE;
    //animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:animation forKey:nil];
  
}

@end
