//
//  Setting.h
//  OpelGLES
//
//  Created by Foxconn on 2011/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingProtocol.h"

@class SettingView;

@interface UISetting : UIViewController {

	UITextField *textRed;
	UITextField *textGreen;
	UITextField *textBlue;
	UITextField *textOpacity;
	UITextField *textLineWidth;
	UIView *showColorView;
	SettingView *setColorView;
	UISlider *redSlider;
	UISlider *greenSlider;
	UISlider *blueSlider;
	UISlider *opacitySlider;
	id<SettingProtocol> delegate;
	
	UIImageView *colorImageView;
	
}

@property (nonatomic, retain) IBOutlet UITextField *textRed;
@property (nonatomic, retain) IBOutlet UITextField *textGreen;
@property (nonatomic, retain) IBOutlet UITextField *textBlue;
@property (nonatomic, retain) IBOutlet UITextField *textOpacity;
@property (nonatomic, retain) IBOutlet UITextField *textLineWidth;
@property (nonatomic, retain) IBOutlet UIView *showColorView;
@property (nonatomic, retain) IBOutlet SettingView *setColorView;
@property (nonatomic, retain) IBOutlet UISlider *redSlider;
@property (nonatomic, retain) IBOutlet UISlider *greenSlider;
@property (nonatomic, retain) IBOutlet UISlider *blueSlider;
@property (nonatomic, retain) IBOutlet UISlider *opacitySlider;
@property (nonatomic, assign) id<SettingProtocol> delegate;
@property (nonatomic, retain) IBOutlet UIImageView *colorImageView;

//设置颜色的代理方法(设置颜色和线宽)
- (void)setColor:(UIColor *)color andLineWidthDelegate:(float)width;

//设置颜色
- (void)setColor:(Byte[4])colorRGB;

//改变TextField中的颜色值
- (IBAction)changeColor:(id)sender;

//回退键盘
- (IBAction)backKeyBoard:(id)sender;

//初始化颜色选取界面上颜色值和线宽
- (void)initWithColor:(UIColor *)color andLineWidth:(float)width;

@end
