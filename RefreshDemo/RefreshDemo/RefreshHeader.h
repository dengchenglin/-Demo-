//
//  RefreshHeader.h
//  RefreshDemo
//
//  Created by chenguangjiang on 15/10/27.
//  Copyright © 2015年 Dengchenglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    RefreshStatePulling = 1, // 松开就可以进行刷新的状态
    RefreshStateNormal = 2, // 普通状态
    RefreshStateRefreshing = 3, // 正在刷新中的状态
    RefreshStateWillRefreshing = 4
} RefreshState;

@protocol RefreshDelegate <NSObject>
@end
@interface RefreshHeader : UIView
@property(nonatomic,weak)id <RefreshDelegate>delegate;
@property(nonatomic,weak)UIScrollView *scrollView;
@end

