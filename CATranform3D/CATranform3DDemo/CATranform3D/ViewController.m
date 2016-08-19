//
//  ViewController.m
//  CATranform3D
//
//  Created by chenguangjiang on 15/10/19.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    {
        UILabel* lblNothing= [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 140, 15)];
        lblNothing.text = @"没旋转没m34";
        lblNothing.textColor = [UIColor blackColor];
        [self.view addSubview:lblNothing];
        
        UIImageView* nothingView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 160, 126)];
        nothingView.image = [UIImage imageNamed:@"test"];
        [self.view addSubview:nothingView];
        
        
        UIImageView* nothingView2 = [[UIImageView alloc] initWithFrame:CGRectMake(160, 20, 160, 126)];
        nothingView2.image = [UIImage imageNamed:@"test"];
        [self.view addSubview:nothingView2];
    }
    
    {
        UILabel* lblNoM34= [[UILabel alloc] initWithFrame:CGRectMake(10, 151, 160, 15)];
        lblNoM34.text = @"有旋转没m34";
        lblNoM34.textColor = [UIColor blackColor];
        [self.view addSubview:lblNoM34];
        
        UIImageView* noM34View = [[UIImageView alloc] initWithFrame:CGRectMake(0, 168, 160, 126)];
        noM34View.image = [UIImage imageNamed:@"test"];
        [self.view addSubview:noM34View];
        
        CATransform3D transform1 = CATransform3DIdentity;
        transform1 = CATransform3DRotate(transform1,(-M_PI/180*50), 0, 1, 0);
        [noM34View.layer setTransform:transform1];
        
        
        UIImageView* noM34View2 = [[UIImageView alloc] initWithFrame:CGRectMake(160, 168, 160, 126)];
        noM34View2.image = [UIImage imageNamed:@"test"];
        [self.view addSubview:noM34View2];
    }
    
    {
        UILabel* lblM34= [[UILabel alloc] initWithFrame:CGRectMake(10, 301, 160, 15)];
        lblM34.text = @"有旋转有m34";
        lblM34.textColor = [UIColor blackColor];
        [self.view addSubview:lblM34];
        
        UIImageView* m34View = [[UIImageView alloc] initWithFrame:CGRectMake(0, 322, 160, 126)];
        m34View.image = [UIImage imageNamed:@"test"];
        [self.view addSubview:m34View];
        
        CATransform3D transform2 = CATransform3DIdentity;
        //.m行一定要写在CATransform3DRotate的前面！
        transform2.m34 = -1/1000.0; // 透视效果
        transform2 = CATransform3DRotate(transform2,(-M_PI/180*50), 0, 1, 0);
        [m34View.layer setTransform:transform2];
        
        
        UIImageView* m34View3 = [[UIImageView alloc] initWithFrame:CGRectMake(160, 322, 160, 126)];
        m34View3.image = [UIImage imageNamed:@"test"];
        [self.view addSubview:m34View3];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
