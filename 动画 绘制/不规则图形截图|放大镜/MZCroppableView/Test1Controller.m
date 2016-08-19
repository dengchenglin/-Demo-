//
//  Test1Controller.m
//  MZCroppableView
//
//  Created by chenguangjiang on 15/9/17.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import "Test1Controller.h"
@interface Test1Controller ()<UIAlertViewDelegate>
@property (nonatomic, assign) CGPoint startPoint;
@end

@implementation Test1Controller
- (UIView *)clipView
{
    //如果clipView为被创建，就创建
    if (_clipView == nil)
    {
        UIView *view = [[UIView alloc] init];
        _clipView = view;
        //设置clipView的背景色和透明度
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5;
        //将clipView添加到控制器的view上，此时的clipView不会显示（未设置其frame）
        [self.view addSubview:_clipView];
    }
    return _clipView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = [UIImage imageNamed:@"cropping_sample.jpg"];
    [self.view addSubview:_imageView];
    /**创建手势**/
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    /**
     *每当pan手势的位置发生变化，就会调用pan:方法，并将手势作为参数传递
     */
    /**添加手势**/
    [self.view addGestureRecognizer:pan];
   
}
-(void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint endPoint = CGPointZero;

    if (pan.state == UIGestureRecognizerStateBegan)
    {
        /**开始点击时，记录手势的起点**/
        self.startPoint = [pan locationInView:self.view];
    }
    else if(pan.state == UIGestureRecognizerStateChanged)
    {
        /**当手势移动时，动态改变终点的值，并计算起点与终点之间的矩形区域**/
        endPoint = [pan locationInView:self.view];
        //计算矩形区域的宽高
        CGFloat w = endPoint.x - self.startPoint.x;
        CGFloat h = endPoint.y - self.startPoint.y;
        //计算矩形区域的frame
        CGRect clipRect = CGRectMake(self.startPoint.x, self.startPoint.y, w, h);
        //设置剪切区域的frame
        self.clipView.frame = clipRect;
    }
    else if(pan.state == UIGestureRecognizerStateEnded)
    {
        /**若手势停止，将剪切区域的图片内容绘制到图形上下文中**/
        //开启位图上下文
        UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
        //创建大小等于剪切区域大小的封闭路径
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.clipView.frame];
        CGContextRef context = UIGraphicsGetCurrentContext();
        //设置超出的内容不显示，
        [path addClip];
        
        //等同于
//        CGContextAddPath(context, path.CGPath);
//        CGContextClip(context);
        
        //圆形切图
//        CGPoint showPoint = CGPointMake(_imageView.frame.size.width/2, _imageView.frame.size.height/2);
//        
//        CGContextAddEllipseInRect(context, CGRectMake(showPoint.x - 80/2, showPoint.y - 80/2, 80 , 80));
//        //指定可以显示图片的范围
//        CGContextClip(context);
        
        
        //将图片渲染的上下文中



        [self.imageView.layer renderInContext:context];
        //获取上下文中的图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        //关闭位图上下文
        UIGraphicsEndImageContext();
        //移除剪切区域视图控件，并清空
        [self.clipView removeFromSuperview];
        self.clipView = nil;
        //将图片显示到imageView上
        self.imageView.image = image;
        //通过alertView提示用户，是否将图片保存至相册
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"保存图片" message:@"是否将图片保存至相册?" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alertView show];
    }
}

- (void)alertView:(nonnull UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //若点击了“是”，则保存图片
    if (buttonIndex == 1)
    {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
        /**
         * 该方法可以设置保存完毕调用的方法，此处未进行设置
         */
    }
}

@end
