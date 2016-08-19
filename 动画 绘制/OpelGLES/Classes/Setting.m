//
//  Setting.m
//  OpelGLES
//
//  Created by Foxconn on 2011/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Setting.h"
#import "SettingView.h"

@implementation UISetting
@synthesize textRed;
@synthesize textGreen;
@synthesize textBlue;
@synthesize textOpacity;
@synthesize textLineWidth;
@synthesize showColorView;
@synthesize setColorView;
@synthesize redSlider;
@synthesize greenSlider;
@synthesize blueSlider;
@synthesize opacitySlider;
@synthesize delegate;
@synthesize colorImageView;

//设置颜色的代理方法(设置颜色和线宽)
- (void)setColor:(UIColor *)color andLineWidthDelegate:(float)width {
	[self.delegate setColor:color andLineWidth:width];
}

//设置颜色
- (void)setColor:(Byte[])colorRGB {
	redSlider.value = (float)colorRGB[0] / 255;
	greenSlider.value = (float)colorRGB[1] / 255;
	blueSlider.value = (float)colorRGB[2] / 255;
	opacitySlider.value = (float)colorRGB[3] / 255;
	//NSLog(@"XXX:%d,%d,%d,%d",colorRGB[0],colorRGB[1],colorRGB[2],colorRGB[3]);
	[self changeColor:nil];
}

//初始化颜色选取界面上颜色值和线宽
- (void)initWithColor:(UIColor *)color andLineWidth:(float)width {
	const float *colorRGB = CGColorGetComponents(color.CGColor);
	redSlider.value = colorRGB[0];
	greenSlider.value = colorRGB[1];
	blueSlider.value = colorRGB[2];
	opacitySlider.value = colorRGB[3];
	//NSLog(@"%f,%f,%f,%f",colorRGB[0],colorRGB[1],colorRGB[2],colorRGB[3]);
	textLineWidth.text = [[NSString alloc] initWithFormat:@"%.1f", width];
	[self changeColor:nil];
}

//改变TextField中的颜色值
- (IBAction)changeColor:(id)sender {
	showColorView.backgroundColor = [UIColor colorWithRed:redSlider.value 
																									green:greenSlider.value 
																									 blue:blueSlider.value 
																									alpha:opacitySlider.value];
	textRed.text = [[[NSString alloc] initWithFormat:@"%d", (int)(redSlider.value*255)] autorelease];
	textGreen.text = [[[NSString alloc] initWithFormat:@"%d", 
										 (int)(greenSlider.value*255)] autorelease];
	textBlue.text = [[[NSString alloc] initWithFormat:@"%d", 
										(int)(blueSlider.value*255)] autorelease];
	textOpacity.text = [[[NSString alloc] initWithFormat:@"%.0f%@",
											 opacitySlider.value*100,@"%"] autorelease];
}

//绘图键盘
- (IBAction)backKeyBoard:(id)sender {
	[textRed resignFirstResponder];
	[textGreen resignFirstResponder];
	[textBlue resignFirstResponder];
	[textOpacity resignFirstResponder];
	[textLineWidth resignFirstResponder];
}
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
	setColorView.setColorController = self;
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
  [super viewDidUnload];
	self.textRed = nil;
	self.textGreen = nil;
	self.textBlue = nil;
	self.textOpacity = nil;
	self.textLineWidth = nil;
	self.showColorView = nil;
	self.redSlider = nil;
	self.greenSlider = nil;
	self.blueSlider = nil;
	self.opacitySlider = nil;
	self.colorImageView = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
   
	[textRed release];
	[textGreen release];
	[textBlue release];
	[textOpacity release];
	[textLineWidth release];
	[showColorView release];
	[redSlider release];
	[greenSlider release];
	[blueSlider release];
	[opacitySlider release];
	[colorImageView release];
	[super dealloc];
}

@end
