//
//  CustomOverlayRenderer.m
//  MapView
//
//  Created by chenguangjiang on 14-12-29.
//  Copyright (c) 2014年 Orb. All rights reserved.
//

#import "CustomOverlayRenderer.h"

@implementation CustomOverlayRenderer
-(id)initWithCircle:(MKCircle *)circle withRadius:(double)radius
{
    if(self = [super initWithOverlay:(MKCircle *)circle])
    {
        
    }
    return self;
}

-(void)createPath
{
   
    MKMapPoint point = MKMapPointForCoordinate([[self overlay] coordinate]
                                               ) ;
    NSLog(@"中心点 －－－%f %f\n",point.x,point.y);

      CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画圆
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);//笔的颜色
    CGContextSetLineWidth(context, 1.0);
    //画大圆并填充颜
    UIColor*aColor = [UIColor colorWithRed:0.5 green:0.0 blue:0 alpha:1];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    CGContextSetLineWidth(context, 3.0);//线的宽度
    
    CGContextAddArc(context, point.x, point.y,  200, 0, 2*M_PI, 0);//添加一个圆
    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
    CGContextDrawPath(context,kCGPathFillStroke); //绘制路径加填充
    
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGFloat lengths[] = {10,10};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, point.x + 200,point.y);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}
@end
