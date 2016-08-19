//
//  UICutCircleView.h
//  MZCroppableView
//
//  Created by chenguangjiang on 15/9/17.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICutCircleView : UIView
@property(nonatomic,weak)UIImageView *imageView;
@property(nonatomic,assign)CGPoint showPoint;
@property(nonatomic,assign)CGSize showSize;
@property(nonatomic,assign)CGFloat scale;
@property(nonatomic,strong)UIImage *image;
-(UIImage *)cutCircleImage;
@end
