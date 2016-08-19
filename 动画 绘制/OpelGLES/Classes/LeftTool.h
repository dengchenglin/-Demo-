//
//  LeftTool.h
//  OpelGLES
//
//  Created by Foxconn on 2011/4/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OpelGLESViewController;

//left view for setting attribute of shape
@interface LeftTool : UIViewController {

	OpelGLESViewController *viewController;
}

@property (nonatomic, retain) OpelGLESViewController *viewController;

//remove left view
- (void)buttonTouch;

//touch event for left view
- (IBAction)buttonPressByTag:(id)sender;

@end
