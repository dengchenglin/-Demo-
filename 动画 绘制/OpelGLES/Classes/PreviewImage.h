//
//  PreviewImage.h
//  OpelGLES
//
//  Created by Foxconn on 2011/4/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuartzFunView;

//create new viewcontroller for preview image
@interface PreviewImage : UIViewController {

	UIImageView *imagePreview;
	CGFloat scale;
	UIImageOrientation KImageOrientation;
	UISlider *scaleSlider;
	UIImage *image;
	QuartzFunView *paintView;
	
}

@property (nonatomic, retain) IBOutlet UIImageView *imagePreview;
@property CGFloat scale;
@property UIImageOrientation KImageOrientation;
@property (nonatomic, retain) IBOutlet UISlider *scaleSlider;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) QuartzFunView *paintView;

//change the scale of image(button: touch inside)
- (IBAction)changeScale:(id)sender;

//change orientation of image
- (IBAction)changeOrienta:(id)sender;

//set brush style to image
- (IBAction)buttonPressed:(id)sender;

//change the scale of  image
- (void)changeImageScale;

@end
