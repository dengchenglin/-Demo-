//
//  ViewController.m
//  MZCroppableView
//
//  Created by macbook on 30/10/2013.
//  Copyright (c) 2013 macbook. All rights reserved.
//

#import "ViewController.h"
#import "MZCroppableView.h"
#import "TestController.h"
#import "Test1Controller.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [croppingImageView setImage:[UIImage imageNamed:@"cropping_sample.jpg"]];
    CGRect rect1 = CGRectMake(0, 0, croppingImageView.image.size.width, croppingImageView.image.size.height);
    CGRect rect2 = croppingImageView.frame;
    [croppingImageView setFrame:[MZCroppableView scaleRespectAspectFromRect1:rect1 toRect2:rect2]];
  
    
    [self setUpMZCroppableView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - My Methods -
- (void)setUpMZCroppableView
{
    [mzCroppableView removeFromSuperview];
    mzCroppableView = [[MZCroppableView alloc] initWithImageView:croppingImageView];
    [self.view addSubview:mzCroppableView];
}
#pragma mark - My IBActions -
- (IBAction)resetButtonTapped:(UIBarButtonItem *)sender
{
    [self setUpMZCroppableView];
}
- (IBAction)cropButtonTapped:(UIBarButtonItem *)sender
{
    UIImage *croppedImage = [mzCroppableView deleteBackgroundOfImage:croppingImageView];
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/final.png"];
    [UIImagePNGRepresentation(croppedImage) writeToFile:path atomically:YES];
    [cutImageView setImage:croppedImage];
    NSLog(@"cropped image path: %@",path);
}
- (IBAction)test:(id)sender {
//    TestController *test = [[TestController alloc]init];
//    [self addChildViewController:test];
//    [self.view addSubview:test.view];
}

- (IBAction)test1:(id)sender {
    Test1Controller *test1 = [[Test1Controller alloc]init];
    [self addChildViewController:test1];
    [self.view addSubview:test1.view];
}
@end
