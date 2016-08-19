//
//  TestView.m
//  Quartz2D绘制颜色
//
//  Created by chenguangjiang on 15/9/24.
//  Copyright (c) 2015年 Dengchenglin. All rights reserved.
//

#import "TestView.h"
#import <QuartzCore/QuartzCore.h>
@implementation TestView

-(void)awakeFromNib{
    [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(timerAnimation) userInfo:nil repeats:YES];
}
static CGFloat midX = 0;
-(void)timerAnimation{
    midX += 0.01;
    if(midX > 1.0){
        midX = 0;
    }
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 创建色彩空间对象
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    //创建两种颜色的渐变
    
    
//    // 创建起点颜色(R,G,B,alpha)
//    CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){0, 0, 0, 1.0f});
//    // 创建终点颜色
//    CGColorRef endColor = CGColorCreate(colorSpaceRef, (CGFloat[]){1, 1, 1, 1.0f});
//    
//    // 创建颜色数组
//    CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor, endColor}, 2, nil);
//    
//    // 创建渐变对象
//    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, (CGFloat[]){
//        0.0f,       // 对应起点颜色位置
//        1.0f        // 对应终点颜色位置
//    });
//    // 释放颜色数组
//    CFRelease(colorArray);
//    // 释放起点和终点颜色
//    CGColorRelease(beginColor);
//    CGColorRelease(endColor);
//    // 释放色彩空间
//    CGColorSpaceRelease(colorSpaceRef);
//    //从视图的哪里倒哪里的渐变
//    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(0.0f, 0), CGPointMake(320.0f, 0), 0);
//    // 释放渐变对象
//    CGGradientRelease(gradientRef);
    
    
    
    //创建三种颜色的渐变
    
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef, (CGFloat[]){
        0, 0, 0, 1.0f,
        1, 1, 1, 1,
        0, 0, 0, 1.0f
    }, (CGFloat[]){
        0,// 对应起点颜色位置
        midX,//对应中点的颜色
        1 // 对应终点颜色位置
    },
    3);
    CGColorSpaceRelease(colorSpaceRef);
    // 填充渐变色
    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(0.0f, 100), CGPointMake(320.0f, 100), 0);
    // 释放渐变对象
    CGGradientRelease(gradientRef);
}


@end
