//
//  ConerView.m
//  CoreAnimation
//
//  Created by chenguangjiang on 15/9/29.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "ConerView.h"

@implementation ConerView
{
    UIView *view;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self createView];
    };
    return self;
}
-(void)createView{
    //绘制圆角矩形（用于设置UIView圆角）
    // UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 60,60) cornerRadius:40];
    //设置UIView四个角分别圆角
    //  UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:<#(CGRect)#> byRoundingCorners:<#(UIRectCorner)#> cornerRadii:<#(CGSize)#>]
    view = [[UIView alloc]initWithFrame:CGRectMake(10, 20, 80, 60)];
    [view setBackgroundColor:[UIColor blueColor]];
    [self addSubview:view];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view.bounds;
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)].CGPath;
    view.layer.mask = maskLayer;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //usingSpringWithDamping：弹簧动画的阻尼值，也就是相当于摩擦力的大小，该属性的值从0.0到1.0之间，越靠近0，阻尼越小，弹动的幅度越大，反之阻尼越大，弹动的幅度越小，如果大道一定程度，会出现弹不动的情况。
    //initialSpringVelocity：弹簧动画的速率，或者说是动力。值越小弹簧的动力越小，弹簧拉伸的幅度越小，反之动力越大，弹簧拉伸的幅度越大。这里需要注意的是，如果设置为0，表示忽略该属性，由动画持续时间和阻尼计算动画的效果。
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:10 options:UIViewAnimationOptionTransitionNone animations:^{
        if(self.center.x > 100){
           self.center = CGPointMake(self.center.x - 100, self.center.y);
        }
        else{
          self.center = CGPointMake(self.center.x + 100, self.center.y);
        }
        
    } completion:^(BOOL finished) {
        [UIView transitionWithView:self duration:1.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [self addSubview:view];
        } completion:^(BOOL finished) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 40)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"QGDKGJSD";
            [UIView transitionFromView:view toView:label duration:1.5 options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
                
                [UIView animateWithDuration:1 animations:^{
                    label.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0.5), CGAffineTransformMakeTranslation(0, -label.frame.size.height));
                    label.alpha = 0;
                }];
            }];
        
        }];
        
    }];

}

@end
