//
//  QuitView.m
//  HHY
//
//  Created by chenguangjiang on 14-11-21.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "QuitView.h"

@implementation QuitView
{
    UIImageView *backView;
    UIView *showView;
}
-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}
-(void)initView
{
    backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, kScreenHeight)];
    backView.backgroundColor =[UIColor blackColor];
    [self addSubview:backView];
    showView = [[UIView alloc]initWithFrame:CGRectZero];
    
}

@end
