//
//  ViewController.h
//  MZCroppableView
//
//  Created by macbook on 30/10/2013.
//  Copyright (c) 2013 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZCroppableView;
@interface ViewController : UIViewController
{
    IBOutlet UIImageView *croppingImageView;

    __weak IBOutlet UIImageView *cutImageView;
    MZCroppableView *mzCroppableView;
}
- (IBAction)test:(id)sender;
- (IBAction)test1:(id)sender;
@end
