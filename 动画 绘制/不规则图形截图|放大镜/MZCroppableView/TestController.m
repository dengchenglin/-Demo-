//
//  TestController.m
//  MZCroppableView
//
//  Created by chenguangjiang on 15/9/16.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import "TestController.h"
#import "UICutView.h"
@interface TestController ()
@property(nonatomic,strong)UICutView *cutView;
@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}
-(void)createView{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _imageView.image = [UIImage imageNamed:@"cropping_sample.jpg"];
   [_imageView setFrame:[self rectWithImage:_imageView.image inSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)]];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_imageView];
    _cutView = [[UICutView alloc]initWithFrame:_imageView.frame];
    _cutView.imageView = _imageView;
    _cutView.image = _imageView.image;
    //_cutView.scale = 5;
    [self.view addSubview:_cutView];
}

-(CGRect)rectWithImage:(UIImage *)image inSize:(CGSize)size{
    CGSize imageSize = image.size;
    if(imageSize.width > size.width){
        imageSize = CGSizeMake(size.width, imageSize.height * size.width/imageSize.width);
    }
    if(imageSize.height > size.height){
        imageSize = CGSizeMake(imageSize.width * size.height/imageSize.height, imageSize.height);
    }
    return CGRectMake((size.width - imageSize.width)/2, (size.height - imageSize.height)/2, imageSize.width, imageSize.height);
}

- (IBAction)cut:(id)sender {
   
}

- (IBAction)cancel:(id)sender {
    [self.view removeFromSuperview];
}

- (IBAction)fitFill:(id)sender {
      _imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (IBAction)center:(id)sender {
      _imageView.contentMode = UIViewContentModeCenter;
}
@end
