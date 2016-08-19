//
//  BottomTool.h
//  OpelGLES
//
//  Created by Foxconn on 2011/4/18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OpelGLESViewController;

//set shadow for pen
@interface BottomTool : UIViewController {

	OpelGLESViewController *viewController;
}

@property (nonatomic, retain) OpelGLESViewController *viewController;

//remove botton view
- (void)removeBottonView;

//select shadow color for pen
- (IBAction)shadowColorBtn:(UIButton *)sender;

@end
