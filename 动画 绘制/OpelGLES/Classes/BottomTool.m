//
//  BottomTool.m
//  OpelGLES
//
//  Created by Foxconn on 2011/4/18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BottomTool.h"
#import <QuartzCore/QuartzCore.h>
#import "OpelGLESViewController.h"
#import "Constants.h"
#import "QuartzFunView.h"

@implementation BottomTool

@synthesize viewController;

//移除地步的View
- (void)removeBottonView {
	CATransition *animation = [CATransition animation];
	animation.duration = 0.2f;
	animation.delegate = self;
	animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.type = kCATransitionReveal;
	animation.subtype = kCATransitionFromRight;
	[[[self.view superview] layer] addAnimation:animation forKey:@"BottonToolOut"];
	[self.view removeFromSuperview];
	viewController.bottomAnimationView.alpha = 0.0f;
}

//选取阴影颜色值后并移除地步的view
- (IBAction)shadowColorBtn:(UIButton *)sender {
	int number = [sender tag] - 11;
	
	[(QuartzFunView *)[viewController mainView] setShadowColor:
	 [UIColor colorWithRed:shadowColorList[number].color_R / 1.0 
									 green:shadowColorList[number].color_G / 1.0
								    blue:shadowColorList[number].color_B / 1.0 
								   alpha:shadowColorList[number].color_A / 1.0 ]];
	[self removeBottonView];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
