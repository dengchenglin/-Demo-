//
//  sdf.h
//  OpelGLES
//
//  Created by Foxconn on 2011/4/8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "OpelGLESViewController.h"


@interface QuartzFunView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

	CGPoint firstTouch;
	CGPoint lastTouch;
	UIColor *currentColor;
	UIColor *shadowColor;
	float painWidth;
	ShapeType shapeType;
	UIImage *drawImage;
	BOOL useRandomColor;
	BOOL haveSave;
	CGImageRef imageRef;
	UIImage *image;
	NSString *path;
	CGContextRef context;
	NSString *undoPicturePath;
	int count;
	int record;
	Action ac;
	OpelGLESViewController *viewController;
	//
	CGLineCap KLineCap;
	CGLineJoin KLineJoin;
	CGPathDrawingMode KPathDrawMode;
	Byte DashLinePatternIndex;
	
	BOOL isUseShadow;

}

@property CGPoint firstTouch;
@property CGPoint lastTouch;
@property (nonatomic, retain) UIColor *currentColor;
@property (nonatomic, retain) UIColor *shadowColor;
@property float painWidth;
@property ShapeType shapeType;
@property (nonatomic, retain) UIImage *drawImage;
@property BOOL useRandomColor;
@property CGImageRef imageRef;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *path;
@property BOOL haveSave;
@property CGContextRef context;
@property (nonatomic, retain) NSString *undoPicturePath;
@property int count;
@property int record;
@property Action ac;
@property (nonatomic, retain) OpelGLESViewController *viewController;
@property CGLineCap KLineCap;
@property CGLineJoin KLineJoin;
@property CGPathDrawingMode KPathDrawMode;
@property Byte DashLinePatternIndex;
@property BOOL isUseShadow;

//save current view to picture
- (void)saveCurrentViewToPicture;

//open album
- (void)openPhotosAlbum;

//undo operation
- (void)undo;

//redo operation
- (void)redo;

@end
