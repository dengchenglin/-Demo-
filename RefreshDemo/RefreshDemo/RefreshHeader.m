//
//  RefreshHeader.m
//  RefreshDemo
//
//  Created by chenguangjiang on 15/10/27.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import "RefreshHeader.h"
#import "RefreshHeaderView.h"
@interface RefreshHeader()
@property(nonatomic,weak)RefreshCircle *header;
@property(nonatomic,assign)RefreshState state;
@end
@implementation RefreshHeader
-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}
-(void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    if(!self.header){
        RefreshCircle *circle = [[RefreshCircle alloc]initWithFrame:CGRectMake(100, 100, 40, 40)];
        [_scrollView addSubview:circle];
        [_scrollView addSubview:self];
        self.header = circle;
        
    }
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
   
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"contentOffset"]){
        CGFloat offestY = _scrollView.contentOffset.y;
        if(offestY < 0){
            _header.progressValue =  fabs(offestY / 60);
            NSLog(@"%f",_header.progressValue);
            if(_scrollView.isDragging){
                
            }
            else{
                
            }
        }
      
    }
}

- (void)dealloc
{
    
}
@end
