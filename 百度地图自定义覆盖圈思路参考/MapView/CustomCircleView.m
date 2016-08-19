//
//  CustomCircleView.m
//  SHareihpme
//
//  Created by chenguangjiang on 14-12-29.
//  Copyright (c) 2014年 FULLUSERNAME. All rights reserved.
//

#import "CustomCircleView.h"

@implementation CustomCircleView


-(instancetype)init{
    if(self = [super init])
    {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.6;
    }
    return self;
}
- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    NSLog(@"%f",self.frame.size.width);
    NSLog(@"%f",self.frame.size.height);
    
    _viewWidth=self.frame.size.width;
    _viewHeight=self.frame.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画圆
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);//笔的颜色
    //CGContextSetLineWidth(context, 1.0);
    //画大圆并填充颜
    UIColor *aColor = [UIColor colorWithRed:250/255.0f green:76/255.0f blue:67/255.0f alpha:0.5];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    CGContextSetLineWidth(context, 20.0);//线的宽度
    
    CGContextAddArc(context, _viewWidth/2, _viewHeight/2, (_viewWidth-80)/2, 0, 2*M_PI, 0);//添加一个圆
    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
    CGContextDrawPath(context,kCGPathFillStroke); //绘制路径加填充
    

//    //第二个小圆
//    CGContextSetRGBStrokeColor(context, 0, 0, 0, 0);//笔没有颜色
//    //画大圆并填充颜
//    UIColor*Color = [UIColor blackColor];
//    CGContextSetFillColorWithColor(context, Color.CGColor);//填充颜色
//    
//    
//    CGContextAddArc(context, _viewWidth-10, _viewHeight/2, 10, 0, 2*M_PI, 0);//添加一个圆
//    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
//    CGContextDrawPath(context,kCGPathFillStroke); //绘制路径加填充

    
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGFloat lengths[] = {10,10};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, self.frame.size.width/2, self.frame.size.height/2);
    CGContextAddLineToPoint(context, self.frame.size.width - 30,self.frame.size.height/2);
    CGContextStrokePath(context);
   // CGContextClosePath(context);
    
    

}


@end
