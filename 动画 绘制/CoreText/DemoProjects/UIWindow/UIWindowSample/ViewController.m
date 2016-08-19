//
//  ViewController.m
//  UIWindowSample
//
//  Created by TangQiao on 6/1/14.
//  Copyright (c) 2014 TangQiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController {
    UIWindow *_uiwindow;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)testButtonPressed:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"测试"
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)createWindowButtonPressed:(id)sender {
    _uiwindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _uiwindow.windowLevel = UIWindowLevelNormal;
    _uiwindow.backgroundColor = [UIColor redColor];
    _uiwindow.hidden = NO;
    
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
    [gesture addTarget:self action:@selector(hideWindow:)];
    [_uiwindow addGestureRecognizer:gesture];
}

- (void)hideWindow:(UIGestureRecognizer *)gesture {
    _uiwindow.hidden = YES;
    _uiwindow = nil;
}

- (void)alertView:(UIAlertView *)alertView
        clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIWindow *window = [alertView window];
    NSLog(@"window level = %f", window.windowLevel);
}


@end
