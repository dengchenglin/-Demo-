//
//  RefreshView.m
//  CoreAnimation
//
//  Created by chenguangjiang on 15/9/29.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "RefreshView.h"

@implementation RefreshView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self createView];
    }
    return self;
}
-(void)createView{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = self.bounds;
    replicatorLayer.anchorPoint = CGPointMake(0.5, 0.5);
    replicatorLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self.layer addSublayer:replicatorLayer];
    
//    CAShapeLayer *circleLayer = [CAShapeLayer layer];
//    circleLayer.fillColor = [UIColor whiteColor].CGColor;
//    circleLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,  7) radius:7 startAngle:-M_PI endAngle:M_PI clockwise:YES].CGPath;
//    [replicatorLayer addSublayer:circleLayer];
    
    CALayer *circleLayer = [CALayer layer];
    circleLayer.bounds = CGRectMake(0, 0, 14, 14);
    circleLayer.position = CGPointMake(self.frame.size.width/2, 7);
    [circleLayer setCornerRadius:7];
    circleLayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    circleLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:circleLayer];
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];    replicatorLayer.instanceBlueOffset  = 20.0;
    replicatorLayer.instanceGreenOffset  = -20.0;
    replicatorLayer.instanceBlueOffset  = 20.0;
    animation.duration = 1;
   // animation.autoreverses = YES;
    animation.fromValue = @(1);
    animation.toValue = @(0.1);
    animation.repeatCount = HUGE;
    [circleLayer addAnimation:animation forKey:nil];
    
    replicatorLayer.instanceCount = 15;
    

    
    replicatorLayer.instanceTransform  =CATransform3DMakeRotation(2 * M_PI/15, 0, 0, 1);
    replicatorLayer.instanceDelay = 1/15.0f;
}
@end
