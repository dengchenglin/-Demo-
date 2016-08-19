//
//  UICutCircleView.m
//  MZCroppableView
//
//  Created by chenguangjiang on 15/9/17.
//  Copyright (c) 2015年 macbook. All rights reserved.
//

#import "UICutCircleView.h"

@implementation UICutCircleView
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
 
}
-(UIImage *)cutCircleImage{
    return nil;
}
@end
