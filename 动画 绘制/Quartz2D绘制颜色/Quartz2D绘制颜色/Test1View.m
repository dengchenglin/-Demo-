//
//  Test1View.m
//  Quartz2D绘制颜色
//
//  Created by chenguangjiang on 15/9/28.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "Test1View.h"

@implementation Test1View


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const CGFunctionCallbacks callbacks = {
        .version = 0, .evaluate = &MyShaderProcedure, .releaseInfo = NULL
    };
    
    // 创建函数对象
    CGFunctionRef funcRef = CGFunctionCreate(NULL,  // 将info置空
                                             1,     // 1个输入元素（每个元素为2个分量来表示区间）
                                             (CGFloat[]){0.0f, 1.0f},
                                             4,     // 4个输出元素
                                             (CGFloat[]){0.0f, 1.0f, 0.0f, 1.0f, 0.0f, 1.0f, 0.0f, 1.0f},
                                             &callbacks);
    
    // 创建色彩空间对象
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    // 创建着色器对象
    CGShadingRef shadingRef = CGShadingCreateAxial(colorSpaceRef,
                                                   CGPointMake(0.0f, 0.0f),         // 起点坐标
                                                   CGPointMake(320.0f, 460.0f),     // 终点坐标
                                                   funcRef, false, false);
    
    // 释放色彩空间对象
    CGColorSpaceRelease(colorSpaceRef);
    
    // 释放函数对象
    CGFunctionRelease(funcRef);
    
    // 绘制着色渐变
    CGContextDrawShading(context, shadingRef);
    
    // 释放着色器对象
    CGShadingRelease(shadingRef);
}

static void MyShaderProcedure(void *info, const CGFloat *in, CGFloat *out)
{
    CGFloat color;
    
    if(in[0] < 0.33f)
        color = 0.3f;
    else if(in[0] < 0.66f)
        color = 0.9f;
    else
        color = 0.6f;
    
    out[0] = color;
    out[1] = color;
    out[2] = color;
    out[3] = 1.0f;
}
@end
