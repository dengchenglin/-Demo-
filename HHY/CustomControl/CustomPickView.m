//
//  CustomPickView.m
//  HHY
//
//  Created by chenguangjiang on 14-11-11.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "CustomPickView.h"

@implementation CustomPickView

-(id)init{
    if(self = [super init])
    {
  
        
    }
    return self;
}
-(void)awakeFromNib
{
    _scrolView.showsVerticalScrollIndicator = NO;
    _scrolView.delegate = self;
}
-(void)setArr:(NSArray *)arr
{
    if(_arr != arr)
    {
        _arr = [arr copy];
    }
    for(UIView *v in _scrolView.subviews)
    {
        [v removeFromSuperview];
    }
    for(int i = 0;i < arr.count;i++)
    {
        UIButton *but =[UIButton buttonWithType:UIButtonTypeCustom];
        but.tag = 800 + i;
        [but setFrame:CGRectMake(0, 40 + i * 40, 80, 20)];
        [but setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(moveoffest:) forControlEvents:UIControlEventTouchUpInside];
        [_scrolView addSubview:but];
    }
     _scrolView.contentSize = CGSizeMake(80, 60 +40 * arr.count);
     _scrolView.contentOffset = CGPointMake(0, 40);
    if(arr.count == 1)
    {
         _scrolView.contentOffset = CGPointMake(0, 0);
    }
 
   
   
    
}
-(void)moveoffest:(UIButton *)button
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    _scrolView.contentOffset = CGPointMake(0, (button.tag - 800) * 40);
    [UIView commitAnimations];
}
-(void)show:(UIViewController *)vc
{
    [vc.view addSubview:self];
}
-(void)hidden
{
    [self removeFromSuperview];
}

- (IBAction)cancel {
    [self hidden];
}

- (IBAction)sure {
    NSString *row = [NSString stringWithFormat:@"%.0f",_scrolView.contentOffset.y/40];
 
    if(_delegate && [_delegate respondsToSelector:@selector(didSelectIndexRow:withButTag:)])
    {
        [_delegate didSelectIndexRow:row withButTag:self.tag];
    }
    [self hidden];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSInteger i;
    if((NSInteger)scrollView.contentOffset.y%40 < 20)
    {
        i = scrollView.contentOffset.y/40;
    }
    else
    {
        i = scrollView.contentOffset.y/40 + 1;
    }
 
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    scrollView.contentOffset = CGPointMake(0, i * 40);
    [UIView commitAnimations];
  
}

@end
