//
//  sdf.m
//  OpelGLES
//
//  Created by Foxconn on 2011/4/8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QuartzFunView.h"
#import "UIColor_Random.h"
#import "LeftTool.h"
#import "BottomTool.h"
#import <QuartzCore/CALayer.h>

//dash line
typedef struct {
	CGFloat pattern[1];
	size_t count;
} Pattern;

static Pattern patterns[]=
{
	{{600.0f},1},
	{{10.0f},1}
};

@implementation QuartzFunView
@synthesize firstTouch;
@synthesize lastTouch;
@synthesize currentColor;
@synthesize shadowColor;
@synthesize painWidth;
@synthesize shapeType;
@synthesize drawImage;
@synthesize useRandomColor;
@synthesize imageRef;
@synthesize image;
@synthesize path;
@synthesize haveSave;
@synthesize context;
@synthesize undoPicturePath;
@synthesize count;
@synthesize record;
@synthesize ac;
@synthesize viewController;

@synthesize KLineCap;
@synthesize KLineJoin;
@synthesize KPathDrawMode;
@synthesize DashLinePatternIndex;
@synthesize isUseShadow;

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ( (self = [super initWithCoder:aDecoder]) ) {
		//颜色的使用
		self.currentColor = [UIColor redColor];
		self.useRandomColor = NO;
		self.painWidth = 2.0f;
		if (drawImage == nil) {
			self.drawImage = [UIImage imageNamed:@"ICON_Final_Small.png"];
		}
		NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
																																 NSUserDomainMask, YES);
		//沙盒路径
		self.path = [documentPaths objectAtIndex:0];
		//存储undo和redo动作的图片的路径
		self.undoPicturePath = [documentPaths objectAtIndex:0];
		//存储绘图的图片
		NSString *fileName = [[[[NSString alloc] initWithFormat:@"%@",@"painPicture"] autorelease] 
													stringByAppendingString:@".png"];
		self.path = [self.path stringByAppendingPathComponent:fileName];
		
		NSError *error;
		NSFileManager *fileMgr = [NSFileManager defaultManager];
		[fileMgr removeItemAtPath:self.path error:&error];
		//从模板中复制一份画布
		[fileMgr copyItemAtPath:@"tempPicture.png" toPath:self.path error:&error];
		KLineCap = kCGLineCapRound;
		KLineJoin = kCGLineJoinMiter;
		KPathDrawMode = kCGPathStroke;
		isUseShadow=NO;
		
		shadowColor = [[UIColor colorWithRed:shadowColorList[0].color_R 
																   green:shadowColorList[0].color_G 
																	  blue:shadowColorList[0].color_B 
																   alpha:shadowColorList[0].color_A ] retain];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
//	if(self.ac==KprepareAction)
//		return;
	
		//先加载上一次的绘图结果

	image = [UIImage imageWithContentsOfFile:self.path];
	[image drawInRect:[self bounds]];
	
	context = UIGraphicsGetCurrentContext();
    if (ac == KUndoAction || ac == KNewAction) {
		return;
	}
	
	//[self.undoManager registerUndoWithTarget:self selector:@selector(UndoPainWithBackColor:) object:image];
	//设置绘图参数
	if (isUseShadow == YES) {
		CGSize myShadowOffset = CGSizeMake(0,0);
		CGContextSetShadowWithColor(context, myShadowOffset, 40, shadowColor.CGColor);
	}
	CGContextSetLineWidth(context, self.painWidth);
	CGContextSetLineCap(context, KLineCap);
	CGContextSetLineJoin(context, KLineJoin);
	patterns[1].pattern[0] = self.painWidth+10;
	if (DashLinePatternIndex == 1) {
		CGContextSetLineDash(context, 5.0f, patterns[DashLinePatternIndex].pattern, 
												 patterns[DashLinePatternIndex].count);
	}
	//NSLog(@"DashLinePatternIndex:%d",DashLinePatternIndex);
	CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
	CGContextSetFillColorWithColor(context, currentColor.CGColor);
	CGRect currentRect = CGRectMake(
								    (firstTouch.x > lastTouch.x)?lastTouch.x : firstTouch.x, 
								    (firstTouch.y > lastTouch.y)?lastTouch.y : firstTouch.y, 
								    fabsf(firstTouch.x - lastTouch.x), 
								    fabsf(firstTouch.y - lastTouch.y));
	
	//NSLog(@"kLineType:%d",shapeType);
	//判断绘图类型
	switch (shapeType) {
		case KLineShape:
		case KCurveShape:
			//[[self.undoManager prepareWithInvocationTarget:self] UndoPainWithBackColor:context];
			CGContextMoveToPoint(context, firstTouch.x, firstTouch.y);
			CGContextAddLineToPoint(context, lastTouch.x, lastTouch.y);
//			NSLog(@"first point:(%f,%f)",firstTouch.x,firstTouch.y);
//			NSLog(@"last point:(%f,%f)",lastTouch.x,lastTouch.y);
			CGContextStrokePath(context);
			//[[self viewController] performSelector:@selector(checkUndoAndHideIfNeeded) withObject:nil afterDelay:0.2f];
			break;
//		case KCurveShape:
//			CGContextMoveToPoint(context, firstTouch.x, firstTouch.y);
//			CGContextAddQuadCurveToPoint(context, 1000.0f, 1000.0f, lastTouch.x, lastTouch.y);
//			CGContextStrokePath(context);
//			break;
		case KRectShape:
			CGContextAddRect(context, currentRect);
			CGContextStrokeRect(context, currentRect);
			if (KPathDrawMode == kCGPathFill)
				CGContextFillRect(context, currentRect);

			break;
		case KEllipseShape:
			CGContextAddEllipseInRect(context, currentRect);
			CGContextStrokeEllipseInRect(context, currentRect);
			if (KPathDrawMode == kCGPathFill)
				CGContextFillEllipseInRect(context, currentRect);

			break;
		case KImageShape:
		{
			CGFloat horizontaloffset = drawImage.size.width / 2;
			CGFloat verticaloffset = drawImage.size.height / 2;
			CGPoint drawPoint = CGPointMake(lastTouch.x - horizontaloffset, 
																			lastTouch.y - verticaloffset);
			[drawImage drawAtPoint:drawPoint];
			//[drawImage drawAtPoint:drawPoint blendMode:kCGBlendModeNormal alpha:0.5f];
			break;
		}
		default:
			break;
	}
	//是否保存绘图结果
	if (self.haveSave == YES) {
		imageRef = CGBitmapContextCreateImage(context);
		image = [UIImage imageWithCGImage:imageRef];
		CGImageRelease(imageRef);
		[UIImagePNGRepresentation(image) writeToFile:self.path atomically:YES];
		
		self.haveSave = NO;
	}
	
	
}

- (void)dealloc {
	[currentColor release];
	[drawImage release];
	[image release];
	[path release];
	[undoPicturePath release];
	[viewController release];
  [super dealloc];
}

//打开相册
- (void)openPhotosAlbum {
	if ([UIImagePickerController isSourceTypeAvailable:
			 UIImagePickerControllerSourceTypePhotoLibrary]) {
		UIImagePickerController *picker = [[UIImagePickerController alloc] init];
		picker.delegate = self;
		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		[viewController presentModalViewController:picker animated:YES];
		[picker release];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error accessing photo library!" 
																										message:@"Device does not support\
													                                    a photo library!" 
																									 delegate:nil 
																					cancelButtonTitle:@"Drat" 
																					otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

//处理四个触摸事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (viewController.leftViewInOrOut == YES) {
		[[self.viewController leftToolViewController] buttonTouch];
	}
	if (viewController.bottomViewInOrOut == YES) {
		[[self.viewController bottonToolViewController] removeBottonView];
	}
	
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	ac = KPainAction;
//	if ([touch tapCount] == 2) {
//		[self openPhotosAlbum];
//		return;
//	}
	//两个手指同时触摸屏幕，打开相册图片选取器
	if ([[event allTouches] count] == 2) {
		[self openPhotosAlbum];
		return;
	}
	[self saveCurrentViewToPicture];

	//[self UndoPainWithBackColor];
	if (useRandomColor) {
		self.currentColor = [UIColor randomColor];
	}
	firstTouch = [touch locationInView:self];
	lastTouch = [touch locationInView:self];
	haveSave = NO;
	//[self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	haveSave = NO;
	if (shapeType == KCurveShape) {
		firstTouch = [touch previousLocationInView:self];
		haveSave = YES;
	}
	
	lastTouch = [touch locationInView:self];
	
	[self setNeedsDisplay];
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[touches allObjects] objectAtIndex:0];	
	lastTouch = [touch locationInView:self];
	haveSave = YES;
	//[self.viewController performSelector:@selector(checkUndoAndHideIfNeeded)];
  //重绘画布
	[self setNeedsDisplay];
//	if ([touch tapCount]==2) {
//		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//			UIImagePickerController *picker=[[UIImagePickerController alloc] init];
//			picker.delegate=self;
//			picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
//			[viewController presentModalViewController:picker animated:YES];
//			[picker release];
//		}
//		else {
//			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error accessing photo library!" message:@"Device does not support a photo library!" delegate:nil cancelButtonTitle:@"Drat" otherButtonTitles:nil];
//			[alert show];
//			[alert release];
//		}		
//	}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	//[self touchesEnded:touches withEvent:event];
}

//将当前View上的内容保存为图片
- (void)saveCurrentViewToPicture {
	//----------method1----------------------------
//	imageRef=CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
//	image=[UIImage imageWithCGImage:imageRef];
//	CGImageRelease(imageRef);
//	if (self.count==100) {
//		self.count=0;
//	}
//	NSString *writeToFileName=[[NSString alloc] initWithFormat:@"%@%d.png",@"undoPicture",self.count++];
//	//NSLog([self.undoPicturePath stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"%@%d.png",@"undoPicture",self.count++]]);
//	[UIImagePNGRepresentation(image) writeToFile:
//	 [self.undoPicturePath stringByAppendingPathComponent:writeToFileName]
//									  atomically:YES];
//	[writeToFileName release];
	
	//----------method2----------------------------
	UIGraphicsBeginImageContext([self bounds].size);
	[[self layer] renderInContext:UIGraphicsGetCurrentContext()];
	image = UIGraphicsGetImageFromCurrentImageContext();
	if (self.count == 100) {
		self.count = 0;
	}
	NSString *writeToFileName = [[NSString alloc] initWithFormat:@"%@%d.png",@"undoPicture", 
																																						self.count++];
	//NSLog([self.undoPicturePath stringByAppendingPathComponent:[[NSString alloc] initWithFormat:@"%@%d.png",@"undoPicture",self.count++]]);
	[UIImagePNGRepresentation(image) writeToFile:
	 [self.undoPicturePath stringByAppendingPathComponent:writeToFileName]
									  atomically:YES];
	[writeToFileName release];
	UIGraphicsEndImageContext();
}

- (void)UndoPainWithBackColor:(UIImage *) image {
    
}
- (void)undo {
	if (count == 0) {
		count = 100;
	}
	image = [UIImage imageWithContentsOfFile:[self.undoPicturePath stringByAppendingPathComponent:
																						[[NSString alloc] initWithFormat:@"%@%d.png",
																						 @"undoPicture", --self.count]]];
	[UIImagePNGRepresentation(image) writeToFile:self.path atomically:YES];
	ac = KUndoAction;
	[self setNeedsDisplay];
}
- (void)redo {
}


//实现图片选取器的四个委托方法
#pragma mark ---
#pragma make imagePickerController delegate method
- (void)imagePickerController:(UIImagePickerController *)picker 
				didFinishPickingImage:(UIImage *)imagePic editingInfo:(NSDictionary *)editingInfo {
	[UIImagePNGRepresentation(imagePic) writeToFile:self.path atomically:YES];
	[picker dismissModalViewControllerAnimated:YES];
	[self setNeedsDisplay];
	
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
	[self setNeedsDisplay];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (event.subtype == UIEventSubtypeMotionShake) {
		UIAlertView *alertShake = [[UIAlertView alloc] initWithTitle:@"Clear Paint?" 
																												 message:nil 
																												delegate:self 
																							 cancelButtonTitle:@"OK" 
																							 otherButtonTitles:@"Cancel",nil];
		[alertShake show];
		[alertShake release];
	}
}

- (void)alertViewCancel:(UIAlertView *)alertView {
	[viewController newPicture:nil];
}
@end
