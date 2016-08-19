//
//  OpelGLESAppDelegate.m
//  OpelGLES
//
//  Created by Foxconn on 2011/4/8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OpelGLESAppDelegate.h"
#import "OpelGLESViewController.h"

@implementation OpelGLESAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
	
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];
	//[self showSpanView];
    return YES;
}

//show animation of setting alpha and scale of image
- (void)showSpanView {
	splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,480)];
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:
										[[[NSBundle mainBundle] resourcePath] 
										 stringByAppendingPathComponent:@"Default.png"]];
	splashView.image = image;
	[image release];
	[self.window addSubview:splashView];
	[self.window bringSubviewToFront:splashView];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:2.0f];
	
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(startupAnimationDone:finished:context:)];
	splashView.alpha = 0.0;
	//splashView.frame=CGRectMake(-60, -40, 440, 600);
	//[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelay:0.5f];
	splashView.frame = CGRectMake(110, 270, 100, 60);
	[UIView commitAnimations];
	
	
}

//callback function of after animation finished
- (void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)_finished 
										 context:(void *)_context {
	[splashView removeFromSuperview];
	[splashView release];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
