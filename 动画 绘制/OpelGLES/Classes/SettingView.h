//
//  SettingView.h
//  OpelGLES
//
//  Created by Foxconn on 2011/4/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UISetting;

//setting view for color and line width 
@interface SettingView : UIView {

	UISetting *setColorController;
	unsigned char *rawData;
	NSInteger bytesPerPixel;
	NSInteger bytesPerRow;
}

@property (nonatomic, retain) UISetting *setColorController;
@property unsigned char *rawData;
@property NSInteger bytesPerPixel;
@property NSInteger bytesPerRow;

//get color date of image 
- (void)getImageData:(UIImage *)image;
- (void)getRGBAsDataFromImage:(UIImage *)image;

@end
