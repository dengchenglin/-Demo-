//
//  CustomView.m
//  HHY
//
//  Created by jiangjun on 14-4-24.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createPase];
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)createPase
{
    for (int i=0; i<2; i++) {
        UIImageView *imgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*(self.frame.size.height-1), 320, 1)];
        imgeView.image = [UIImage imageNamed:@"xian"];
        [self addSubview:imgeView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
