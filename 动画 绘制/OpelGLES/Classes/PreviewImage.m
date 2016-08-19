//
//  PreviewImage.m
//  OpelGLES
//
//  Created by Foxconn on 2011/4/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PreviewImage.h"
#import "QuartzFunView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PreviewImage

@synthesize imagePreview;
@synthesize scale;
@synthesize KImageOrientation;
@synthesize scaleSlider;
@synthesize image;
@synthesize paintView;

//设置画笔样式为图片
- (IBAction)buttonPressed:(id)sender {
	[self.paintView setDrawImage:[UIImage imageWithCGImage:[self.image CGImage] 
																									 scale:1.0 / self.scale
																						 orientation:KImageOrientation]];
	CATransition *animation = [CATransition animation];
  animation.duration = 0.2f;
	animation.delegate = self;
	animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.type = kCATransitionReveal;
	animation.subtype = kCATransitionFromRight;
	[[[self.view superview] layer] addAnimation:animation forKey:@"Preview"];
	[self.view removeFromSuperview];
}

//改变图片的大小
- (IBAction)changeScale:(id)sender {
	if (scaleSlider.value >= 0.5f) {
		scale = (scaleSlider.value - 0.5f) * 10 + 1;
	}
	else {
		scale = scaleSlider.value * 2;
	}
    NSLog(@"slider value:%f,scale value:%f",scaleSlider.value,self.scale);
	[self changeImageScale];
}

//改变图片的方向
- (IBAction)changeOrienta:(id)sender {
	if (KImageOrientation == 6) {
		KImageOrientation = -1;
	}
	KImageOrientation++;
	//NSLog(@"UIImageOrientationUp value:%d",self.KImageOrientation);
	[self changeImageScale];
}
/*
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}

*/
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	//[self changeImageScale];
	//imagePreview.image=self.image;
    [super viewDidLoad];
}
*/
- (void)changeImageScale {
	imagePreview.image = [UIImage imageWithCGImage:[self.image CGImage] 
																					 scale:self.scale 
																		 orientation:KImageOrientation];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	self.imagePreview = nil;
	self.scaleSlider = nil;
	self.image = nil;
  [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[imagePreview release];
	[scaleSlider release];
	[image release];
  [super dealloc];
}


@end
