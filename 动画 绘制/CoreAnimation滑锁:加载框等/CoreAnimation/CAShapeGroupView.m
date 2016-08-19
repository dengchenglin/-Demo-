//
//  CAShapeGroupView.m
//  CoreAnimation
//
//  Created by chenguangjiang on 15/9/29.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "CAShapeGroupView.h"

@implementation CAShapeGroupView
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
    [self.layer addSublayer:shapeLayer];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-0.5);
    strokeStartAnimation.toValue = @(1);
    CABasicAnimation *stokenEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    stokenEndAnimation.fromValue = @(0);
    stokenEndAnimation.toValue = @(1);
    CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
    group.animations = @[strokeStartAnimation,stokenEndAnimation];
    group.duration  =  1.5;
    group.repeatCount = HUGE;
    [shapeLayer addAnimation:group forKey:nil];
}@end
