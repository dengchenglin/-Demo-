//
//  TiledLayer_iphoneAppDelegate.m
//  TiledLayer_iphone
//
//  Created by jimneylee on 10-9-2.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "TiledLayer_iphoneAppDelegate.h"
#import "TiledLayer_iphoneViewController.h"

@implementation TiledLayer_iphoneAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    TiledLayer_iphoneViewController *viewController = [[TiledLayer_iphoneViewController alloc]init];
    self.window.rootViewController = viewController;
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
