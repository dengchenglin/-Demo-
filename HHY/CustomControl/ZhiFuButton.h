//
//  ZhiFuButton.h
//  HHY
//
//  Created by jiangjun on 14-5-4.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhiFuButton : UIButton
@property(nonatomic,retain)UIImageView *headView;
@property(nonatomic,retain)UILabel *headLable;
@property(nonatomic,retain)UIImageView *rightView;
-(void)setHeadTitle:(NSString *)title;
-(void)setheadImage:(NSString *)imageString;
@end
