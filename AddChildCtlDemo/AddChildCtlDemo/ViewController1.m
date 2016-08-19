//
//  ViewController1.m
//  AddChildCtlDemo
//
//  Created by chenguangjiang on 15/9/30.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()
{
    UIView *view ;
}
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
   view = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"ViewController1 viewWillAppear\n\n");
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"ViewController1 viewWillDisappear\n\n");
}
-(void)willMoveToParentViewController:(UIViewController *)parent{
    NSLog(@"ViewController1 - willMoveToParentViewController - %@\n\n",parent);
}
-(void)didMoveToParentViewController:(UIViewController *)parent{
    NSLog(@"ViewController1 - didMoveToParentViewController - %@\n\n",parent);
}
- (void)dealloc
{
    NSLog(@"ViewController1 - dealloc\n\n");
}

@end
