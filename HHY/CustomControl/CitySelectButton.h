//
//  CitySelectButton.h
//  HHY
//
//  Created by jiangjun on 14-5-14.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitySelectButton : UIButton
@property(nonatomic,retain)UILabel *dateLable;
@property(nonatomic,retain)UILabel *yearLable;
@property(nonatomic,retain)UIImageView *rightView;

-(void)removeAllViews;
-(void)createButton;
-(void)decideIsToday:(NSString *)descripition;
@end
