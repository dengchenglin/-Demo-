//
//  CAReplicatorView.m
//  CoreAnimation
//
//  Created by chenguangjiang on 15/9/29.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "CAReplicatorView.h"

@implementation CAReplicatorView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor greenColor];
        [self createView];
    }
    return self;
}
-(void)createView{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = self.bounds;
    replicatorLayer.anchorPoint = CGPointMake(0, 0);
    [self.layer addSublayer:replicatorLayer];
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 30, 120);
    layer.anchorPoint = CGPointMake(0, 0);
    layer.position = CGPointMake(10, 110);
    layer.cornerRadius = 2;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:layer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.duration = 0.7;
    animation.autoreverses = YES;
    animation.toValue = @(40);
    animation.repeatCount = HUGE;
    [layer addAnimation:animation forKey:nil];
    
    //将replicatorLayer的子Layer复制3份
    replicatorLayer.instanceCount = 3;
    

    
    //复制图之间的间隔
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(40, 0, 0);
    //使CAReplicatorLayer中的每个子Layer的动画起始时间逐个递增
    replicatorLayer.instanceDelay = 0.3;
    replicatorLayer.masksToBounds = YES;
    

    
}
@end
