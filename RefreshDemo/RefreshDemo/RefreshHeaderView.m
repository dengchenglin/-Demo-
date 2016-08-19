//
//  RefreshHeaderView.m
//  RefreshDemo
//
//  Created by chenguangjiang on 15/10/27.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "RefreshHeaderView.h"

@implementation RefreshHeaderView

- (void)drawRect:(CGRect)rect {
    
}

@end

@interface RefreshCircle ()
@end
@implementation RefreshCircle
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor yellowColor];
        self.progressValue = 0.0;
    }
    return self;
}
-(void)setProgressValue:(CGFloat)progressValue{
    if(progressValue > 1.0){
        progressValue = 1.0;
    }
    _progressValue = progressValue;
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect{
    CGFloat lineD = rect.size.width/2;//前半部分移动的距离
    CGFloat lineW = 1;//线宽
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    UIBezierPath *linePath1 = [UIBezierPath bezierPath];
    [linePath1 moveToPoint:CGPointMake(rect.size.width/4 , rect.size.height - _progressValue * lineD)];
    [linePath1 addLineToPoint:CGPointMake(rect.size.width/4 ,rect.size.height/2)];
    linePath1.lineWidth = lineW;
    [linePath1 stroke];
    
    
    CGFloat radius = rect.size.width/2 - rect.size.width/4;
    UIBezierPath *arcPath1 = [UIBezierPath bezierPath];
    [arcPath1 addArcWithCenter:center radius:radius startAngle:M_PI endAngle:M_PI + M_PI * _progressValue clockwise:YES];
    arcPath1.lineWidth = lineW;
    [arcPath1 stroke];
    
    UIBezierPath *arrowPath1 = [UIBezierPath bezierPath];
    CGFloat arrowX = center.x - cos(M_PI * _progressValue) *radius;
    CGFloat arrowY = center.y - sin(M_PI * _progressValue) *radius;
    CGFloat arrowToX = arrowX - sin(M_PI * _progressValue ) * 7;
    CGFloat arrowToY = arrowY + cos(M_PI * _progressValue ) * 7;
    
    [arrowPath1 moveToPoint:CGPointMake(arrowX, arrowY)];
    [arrowPath1 addLineToPoint:CGPointMake(arrowToX, arrowToY)];
    arrowPath1.lineWidth = lineW;
    [arrowPath1 stroke];
    
}
@end