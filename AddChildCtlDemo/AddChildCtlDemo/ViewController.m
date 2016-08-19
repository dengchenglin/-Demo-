//
//  ViewController.m
//  AddChildCtlDemo
//
//  Created by chenguangjiang on 15/9/30.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
@interface ViewController ()
{
    ViewController1 *v1;
    ViewController2 *v2;
    ViewController3 *v3;
    ViewController4 *v4;
    UIViewController *currentController;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    v1 = [[ViewController1 alloc]init];
    [self addChildViewController:v1];
    [self.view addSubview:v1.view];
    currentController = v1;
    
    
    v2 = [[ViewController2 alloc]init];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePaner:)];
    [self.view addGestureRecognizer:pan];
}
static  CGFloat beginX;
-(void)handlePaner:(UIPanGestureRecognizer *)pan{
    int isRight = 0;
    CGFloat pointX = [pan locationInView:self.view].x;
    if(pan.state == UIGestureRecognizerStateBegan){
        beginX = pointX;
    }
    else if(pointX > beginX){
        isRight = 1;
        if(currentController != v1){
            [self addChildViewController:v1];
           [self.view addSubview:v1.view];
            v1.view.frame = CGRectMake(pointX - beginX - currentController.view.frame.size.width, currentController.view.frame.origin.y, currentController.view.frame.size.width, currentController.view.frame.size.height);
        }
    }
    else if(pointX < beginX){
         isRight = -1;
        if(currentController != v2){
            [self addChildViewController:v2];
            [self.view addSubview:v2.view];
            v2.view.frame = CGRectMake(currentController.view.frame.size.width + (pointX - beginX), currentController.view.frame.origin.y, currentController.view.frame.size.width, currentController.view.frame.size.height);
        }
    }
    if(pan.state == UIGestureRecognizerStateEnded){
        if(isRight == 1){
            if(v1 != currentController){
                [self addChildViewController:v1];
                 [self.view addSubview:v1.view];
                [self transitionFromViewController:currentController toViewController:v1 duration:1 options:UIViewAnimationOptionTransitionNone animations:^{
                    v1.view.frame = CGRectMake(0, currentController.view.frame.origin.y, currentController.view.frame.size.width, currentController.view.frame.size.height);
                } completion:^(BOOL finished) {
                     [currentController.view removeFromSuperview];
                    [currentController removeFromParentViewController];
                    currentController = v1;
                    
                }];
            }
        
        }
        else if (isRight == -1)
        {
            if(v2 != currentController){
                [self addChildViewController:v2];
                 [self.view addSubview:v2.view];
                [self transitionFromViewController:currentController toViewController:v2 duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
                     v2.view.frame = CGRectMake(0, currentController.view.frame.origin.y, currentController.view.frame.size.width, currentController.view.frame.size.height);
                } completion:^(BOOL finished) {
                    [currentController.view removeFromSuperview];
                    [currentController removeFromParentViewController];
                    currentController = v2;
                }];
            }
        }
    }
   
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

@end
