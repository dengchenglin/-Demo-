//
//  QUartzFun.h
//  OpelGLES
//
//  Created by Foxconn on 2011/4/8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface QUartzFun : UIView {

	CGPoint firstTouch;
	CGPoint lastTouch;
	UIColor *currentColor;
	ShapeType shapeType;
	UIImage *drawImage;
	BOOL useRandomColor;
}

@property CGPoint firstTouch;
@property CGPoint lastTouch;
@property (nonatomic, retain) UIColor *currentColor;
@property ShapeType shapeType;
@property (nonatomic, retain) UIImage *drawImage;
@property BOOL useRandomColor;
@end
