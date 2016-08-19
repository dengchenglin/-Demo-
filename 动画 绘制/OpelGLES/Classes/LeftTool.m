//
//  LeftTool.m
//  OpelGLES
//
//  Created by Foxconn on 2011/4/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LeftTool.h"
#import <QuartzCore/QuartzCore.h>
#import "OpelGLESViewController.h"
#import "QuartzFunView.h"

@implementation LeftTool

@synthesize viewController;

//触摸并以动画的方式移除左边的view
- (void)buttonTouch {
	viewController.leftViewInOrOut = NO;
	viewController.chooseMoreShape.hidden = NO;
	CATransition *animation = [CATransition animation];
	animation.duration = 0.2f;
	animation.delegate = self;
	animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.type = kCATransitionReveal;
	animation.subtype = kCATransitionFromRight;
	[[[self.view superview] layer] addAnimation:animation forKey:@"LeftToolOut"];
	[self.view removeFromSuperview];
	viewController.leftAnimationView.alpha = 0.0f;
}

//左边view上的触摸事件的处理方法
- (IBAction)buttonPressByTag:(id)sender {
	NSInteger index = [sender tag];
	switch (index) {
		case 0:
			[[viewController painView] setDashLinePatternIndex:
			 (([viewController painView].DashLinePatternIndex == 0) ? 1 : 0)];
			break;
		case 11:
			[[viewController painView] setKLineCap:kCGLineCapButt];
			break;
		case 12:
			[[viewController painView] setKLineCap:kCGLineCapRound];
			break;
		case 13:
			[[viewController painView] setKLineCap:kCGLineCapSquare];
			break;
		case 21:
			[[viewController painView] setKLineJoin:kCGLineJoinMiter];
			break;
		case 22:
			[[viewController painView] setKLineJoin:kCGLineJoinRound];
			break;
		case 23:
			[[viewController painView] setKLineJoin:kCGLineJoinBevel];
			break;
		case 31:
			[[viewController painView] setKPathDrawMode:kCGPathFill];
			break;
		case 32:
			[[viewController painView] setKPathDrawMode:kCGPathStroke];
			break;
		case 4:
			[[viewController painView] setDashLinePatternIndex:0];
			[[viewController painView] setKLineCap:kCGLineCapRound];
			[[viewController painView] setKLineJoin:kCGLineJoinMiter];
			[[viewController painView] setKPathDrawMode:kCGPathStroke];
			[[viewController painView] setIsUseShadow:NO];
			break;
		case 5:
			[[viewController painView] setIsUseShadow:![viewController painView].isUseShadow];
			break;
		default:
			break;
	}
	[self buttonTouch];
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
	self.viewController = nil;
  [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[viewController release];
  [super dealloc];
}


@end
