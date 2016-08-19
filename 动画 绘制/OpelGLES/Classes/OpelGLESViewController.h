//
//  OpelGLESViewController.h
//  OpelGLES
//
//  Created by Foxconn on 2011/4/8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingProtocol.h"

@class UISetting;
@class QuartzFunView;
@class LeftTool;
@class PreviewImage;
@class BottomTool;

//main viewController
@interface OpelGLESViewController : UIViewController<SettingProtocol,UITextFieldDelegate,
UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate> {

	UISegmentedControl *colorControl;
	UISetting *settingView;
	UIButton *setColorButton;
	UIButton *chooseMoreShape;
	UIView * mainView;
	//NSUndoManager *undoManager;
	UIButton *undoButton;
	UIButton *redoButton;
	LeftTool *leftToolViewController;
	BottomTool *bottonToolViewController;
	QuartzFunView *painView;
	UIImage *saveImage;
	UIView *leftAnimationView;
	UIView *bottomAnimationView;
	BOOL leftViewInOrOut;
	BOOL bottomViewInOrOut;
	PreviewImage *previewController;

}

@property (nonatomic, retain) IBOutlet UISegmentedControl *colorControl;
@property (nonatomic, retain) IBOutlet UISetting *settingView;
@property (nonatomic, retain) IBOutlet UIButton *setColorButton;
@property (nonatomic, retain) IBOutlet UIButton *chooseMoreShape;
@property (nonatomic, retain) IBOutlet UIView * mainView;
@property (nonatomic, retain) IBOutlet UIButton *undoButton;
@property (nonatomic, retain) IBOutlet UIButton *redoButton;
@property (nonatomic, retain) LeftTool *leftToolViewController;
@property (nonatomic, retain) BottomTool *bottonToolViewController;
@property (nonatomic, retain) QuartzFunView *painView;
@property (nonatomic, retain) UIImage *saveImage;
@property (nonatomic, retain) IBOutlet UIView *leftAnimationView;
@property (nonatomic, retain) IBOutlet UIView *bottomAnimationView;
@property BOOL leftViewInOrOut;
@property BOOL bottomViewInOrOut;
@property (nonatomic, retain) PreviewImage *previewController;
//@property (retain) NSUndoManager *undoManager;

//change the color of pen
- (IBAction)changeColor:(id)sender;

//change shape
- (IBAction)changeShape:(id)sender;

//callback function
- (IBAction)setColor:(id)sender;

//create the new picture
- (IBAction)newPicture:(id)sender;

//undo last operation
- (IBAction)undo:(id)sender;

//redo last operation
- (IBAction)redo:(id)sender;

//save current picture
- (IBAction)savePaintPicture:(id)sender;

//show left setting view
- (IBAction)showLeftView:(id)sender;

//show or hiden button of undo and redo 
- (void)checkUndoAndHideIfNeeded;

//save current picture to album
- (void)savePaintPictureToAlume;

//clear current picture
- (void)clearCurrenrPaint;

//show bottom setting view
- (IBAction)showBottomView:(id)sender;

@end

