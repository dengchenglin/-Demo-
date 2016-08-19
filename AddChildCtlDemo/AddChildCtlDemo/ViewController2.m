//
//  ViewController2.m
//  AddChildCtlDemo
//
//  Created by chenguangjiang on 15/9/30.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"ViewController2 viewWillAppear\n\n");
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"ViewController2 viewWillDisappear\n\n");
}
-(void)willMoveToParentViewController:(UIViewController *)parent{
    NSLog(@"ViewController2 - willMoveToParentViewController - %@\n\n",parent);
}
-(void)didMoveToParentViewController:(UIViewController *)parent{
    NSLog(@"ViewController2 - didMoveToParentViewController - %@\n\n",parent);
}
- (void)dealloc
{
    NSLog(@"ViewController2 - dealloc\n\n");
}


@end
