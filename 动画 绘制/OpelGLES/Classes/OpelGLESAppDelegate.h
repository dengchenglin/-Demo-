//
//  OpelGLESAppDelegate.h
//  OpelGLES
//
//  Created by Foxconn on 2011/4/8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OpelGLESViewController;

@interface OpelGLESAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    OpelGLESViewController *viewController;
	  UIImageView *splashView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet OpelGLESViewController *viewController;

//show animation of setting alpha and scale of image
-(void)showSpanView;

//callback function of after animation finished
-(void)startupAnimationDone:(NSString *)animationID finished:(NSNumber *)_finished 
										context:(void *)_context;
@end

