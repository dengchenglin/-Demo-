//
//  CustomNavBar.h
//  HHY
//
//  Created by chenguangjiang on 14-11-7.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomBarDelegate <NSObject>
-(void)rightButtonClick;
@end

@interface CustomNavBar : UIView
@property (nonatomic,weak)id <CustomBarDelegate>delegate;
-(void)creatTitle:(NSString *)customTitle;
-(void)creatRightButtonWithFrame:(CGRect)frame andImageName:(NSString *)imageName andTitle:(NSString *)rightTitle;
@end

