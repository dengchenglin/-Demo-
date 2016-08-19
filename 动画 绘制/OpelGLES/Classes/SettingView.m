//
//  SettingView.m
//  OpelGLES
//
//  Created by Foxconn on 2011/4/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingView.h"
#import "Setting.h"
#import <OpenGLES/ES1/gl.h>
#import "CGPointExtension.h"
#import "CCDirector.h"

@implementation SettingView

@synthesize setColorController;
@synthesize rawData;
@synthesize bytesPerPixel;
@synthesize bytesPerRow;

- (void)getImageData:(UIImage *)image {
//	void *imageData;
//	if (imageData==NULL) {
//		imageData=malloc(4*image.size.width*image.size.height);
//	}
//	CGColorSpaceRef cref=CGColorSpaceCreateDeviceRGB();
//	CGContextRef context=CGBitmapContextCreate(imageData, image.size.width, image.size.height, 8, image.size.width*4, cref, kCGImageAlphaPremultipliedLast);
//	imageData=CGBitmapContextGetData(context);
//	CGColorSpaceRelease(cref);
//	CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
//	[image drawAtPoint:CGPointMake(0.0f, 0.0f)];
//	
//	CGContextRelease(context);
//	colorPixels=(unsigned char *)imageData;
////	for (int i=0; i<4*image.size.width*image.size.height; i++) {
////		NSLog(@"the value:%d",colorPixels[i]);
////	}


	
//	const int imageWidth=image.size.width;
//	const int imageHeight=image.size.height;
//	size_t bytesPerRow=imageWidth*4;
//	void *imageData;
//	if (imageData==NULL) {
//		imageData=malloc(4*imageWidth*imageHeight);
//	}
//	
//	CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
//	CGContextRef context=CGBitmapContextCreate(imageData, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
//	CGColorSpaceRelease(colorSpace);
//	CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
//	colorData=CGBitmapContextGetData(context);
//	CGContextRelease(context);
	
}

//获取图片中的颜色数据
- (void)getRGBAsDataFromImage:(UIImage *)image {
	CGImageRef imageRef = [image CGImage];
	NSUInteger width = CGImageGetWidth(imageRef);
	NSInteger height = CGImageGetHeight(imageRef);
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	if (rawData == NULL) {
		rawData= malloc(width * height * 4);
	}
	bytesPerPixel = 4;
	bytesPerRow = bytesPerPixel * width;
	NSInteger bitsPerComponent = 8;
	CGContextRef context=CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
	CGColorSpaceRelease(colorSpace);
	CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
	CGContextRelease(context);
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
	[self getRGBAsDataFromImage:[setColorController colorImageView].image];
}


- (void)dealloc {
	[setColorController release];
	free(rawData);
  [super dealloc];
}


//颜色拾取图片上的触摸事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	if ([touch tapCount] == 2) {
		[setColorController backKeyBoard:nil];
		return;
	}
	CGPoint locationPoint = [touch locationInView:self];
	//NSLog(@"touch Point:x=%f,y=%f",locationPoint.x,locationPoint.y);
	CGPoint circlePoint = CGPointMake(94.0f,96.0f);
	if(ccpDistance(locationPoint, circlePoint) <= 88.0f) {
		//locationPoint.y=[self frame].size.height-locationPoint.y;
		//NSLog(@"convert touch Point:x=%f,y=%f",locationPoint.x,locationPoint.y);
		//glReadPixels(locationPoint.x,locationPoint.y,1,1,GL_RGBA,GL_UNSIGNED_BYTE,pixelColor);
		
		UInt8 pixelColor[4];
		int bytesIndex = self.bytesPerRow * locationPoint.y + self.bytesPerPixel * locationPoint.x;
		pixelColor[0] = self.rawData[bytesIndex];
		pixelColor[1] = self.rawData[bytesIndex + 1];
		pixelColor[2] = self.rawData[bytesIndex + 2];
		pixelColor[3] = self.rawData[bytesIndex + 3];
		//NSLog(@"TTT:%d,%d,%d,%d",pixelColor[0],pixelColor[1],pixelColor[2],pixelColor[3]);
		[self.setColorController setColor:pixelColor];
		//NSLog(@"image width:%f height:%f",[setColorController colorImageView].image.size.width,[setColorController colorImageView].image.size.height);
	}
	//[setColorController ];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}

//- (void)FloodFill4(int x,int y,) {
//}

@end
