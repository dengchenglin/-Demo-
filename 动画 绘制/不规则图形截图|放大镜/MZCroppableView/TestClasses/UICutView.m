//
//  UICutView.m
//  MZCroppableView
//
//  Created by chenguangjiang on 15/9/16.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import "UICutView.h"
#import "UIBezierPath-Points.h"
@interface UICutView()

@end
@implementation UICutView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        _showPoint = CGPointMake(frame.size.width/2, frame.size.height/2);
        _showSize = CGSizeMake(80, 80);
        
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
   //设置一个椭圆范围

    CGContextAddEllipseInRect(context, CGRectMake(_showPoint.x - _showSize.width/2, _showPoint.y - _showSize.height/2, _showSize.width , _showSize.height));
    //指定可以显示图片的范围
    CGContextClip(context);
    CGFloat scale = _imageView.image.size.width/_imageView.frame.size.width;
    [_imageView.image drawAtPoint:CGPointMake(_showPoint.x *(1 - scale), _showPoint.y * (1- scale))];
}

static BOOL isPress = NO;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect rect = CGRectMake(_showPoint.x - _showSize.width/2, _showPoint.y - _showSize.height/2, _showSize.width , _showSize.height);
    if(CGRectContainsPoint(rect, point)){
        isPress = YES;
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(isPress){
        UITouch *touch = [touches anyObject];
        _showPoint = [touch locationInView:self];
        [self setNeedsDisplay];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    isPress = NO;
}
-(void)setScale:(CGFloat)scale{
    _scale = scale;
    CGFloat aScale = _image.size.width/_imageView.frame.size.width;
    CGSize newSize = CGSizeMake(_image.size.width/aScale *scale, _image.size.height/aScale * scale);
    UIGraphicsBeginImageContext(newSize);
    [_imageView.image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _imageView.image = reSizeImage;
}

@end
