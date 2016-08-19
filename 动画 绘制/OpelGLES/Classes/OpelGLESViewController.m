//
//  OpelGLESViewController.m
//  OpelGLES
//
//  Created by Foxconn on 2011/4/8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OpelGLESViewController.h"
#import "Setting.h"
#import "QuartzFunView.h"
#import "LeftTool.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>
#import "PreviewImage.h"
#import "BottomTool.h"

@implementation OpelGLESViewController
@synthesize colorControl;
@synthesize settingView;
@synthesize setColorButton;
@synthesize chooseMoreShape;
@synthesize mainView;
@synthesize leftToolViewController;
@synthesize bottonToolViewController;
@synthesize leftViewInOrOut;
@synthesize bottomViewInOrOut;
@synthesize painView;
@synthesize saveImage;
@synthesize previewController;
//@synthesize undoManager;
@synthesize undoButton;
@synthesize redoButton;
@synthesize leftAnimationView;
@synthesize bottomAnimationView;

//撤销
- (IBAction)undo:(id)sender {
	//[self.undoManager undo];
	[painView undo];
}

//恢复
- (IBAction)redo:(id)sender
{
	[self.undoManager redo];
}

//保存图片到document
- (IBAction)savePaintPicture:(id)sender {
	UIActionSheet *savePaintAction=[[UIActionSheet alloc] initWithTitle:nil 
																														 delegate:self 
																										cancelButtonTitle:@"cancel" 
																							 destructiveButtonTitle:@"Save paint" 
																										otherButtonTitles:nil];
	savePaintAction.tag=1;
	[savePaintAction showInView:self.view];
	[savePaintAction release];
}

//保存图片到相册
- (void)savePaintPictureToAlume {
	saveImage=[UIImage  imageWithContentsOfFile:[painView path]];
	UIImageWriteToSavedPhotosAlbum(saveImage, nil, nil, nil);
}

//处理UIAlertView上的按钮单击事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (alertView.tag) {
		case 1:
			if(buttonIndex == 0) {
				[self savePaintPictureToAlume];
			}
			break;
		case 2:
			if (buttonIndex == 0) {
				[self savePaintPictureToAlume];
			}
			[self clearCurrenrPaint];
			break;
		default:
			break;
	}

}

//实现警报代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//	switch (actionSheet.tag) {
//		case 1:
//			if(buttonIndex == 0) {
//				[self savePaintPictureToAlume];
//			}
//			break;
//		case 2:
//			if (buttonIndex == 0) {
//				[self savePaintPictureToAlume];
//			}
//			[self clearCurrenrPaint];
//			break;
//		default:
//			break;
//	}
	
	if (actionSheet.tag == 1) {
		if(buttonIndex == 0) {
			[self savePaintPictureToAlume];
		}		
	}
	else {
		switch (buttonIndex) {
			case 0:
				[self savePaintPictureToAlume];
				break;
			case 1:
				[self clearCurrenrPaint];
				break;
			case 2:
				[self savePaintPictureToAlume];
				[self clearCurrenrPaint];
				break;
			default:
				break;
		}
	}

	
}

//清除画布
- (void)clearCurrenrPaint {
	NSError *error;
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	NSArray *undoFileArray = [fileMgr contentsOfDirectoryAtPath:[painView undoPicturePath] 
																												error:&error];
	int i = 0;
	for (; i < [undoFileArray count]; i++) {
		[fileMgr removeItemAtPath:[[painView undoPicturePath] 
															 stringByAppendingPathComponent:[undoFileArray objectAtIndex:i]] 
												error:&error];
		//NSLog(@"%@",[undoFileArray objectAtIndex:i]);
	}
	//[fileMgr removeItemAtPath:[painView path] error:&error];
	painView.count = 0;
	NSString *tempPicture = [[NSBundle mainBundle] pathForResource:@"tempPicture" ofType:@"png"];
	[fileMgr copyItemAtPath:tempPicture toPath:[painView path] error:&error];
	[painView setAc:KNewAction];
	[mainView setNeedsDisplay];
}

//显示左边的条状View
- (IBAction)showLeftView:(id)sender {
	leftViewInOrOut = YES;
	leftAnimationView.alpha = 1.0f;
	CATransition *animation = [CATransition animation];
	animation.duration = 0.2f;
	animation.delegate = self;
	animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.type = kCATransitionMoveIn;
	animation.subtype = kCATransitionFromLeft;
	[[leftAnimationView layer] addAnimation:animation forKey:@"LeftToolIn"];
	[leftAnimationView addSubview:leftToolViewController.view];
	[sender setHidden:YES];

}

//显示地步的设置阴影颜色的视图
- (IBAction)showBottomView:(id)sender {
	bottomViewInOrOut=YES;
	bottomAnimationView.alpha = 1.0f;
	CATransition *animation = [CATransition animation];
	animation.duration = 0.2f;
	animation.delegate = self;
	animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.type = kCATransitionMoveIn;
	animation.subtype = kCATransitionFromLeft;
	[[bottomAnimationView layer] addAnimation:animation forKey:@"BottomToolIn"];
	[bottomAnimationView addSubview:bottonToolViewController.view];
}

//实现设置颜色的代理方法
- (void)setColor:(UIColor *)color andLineWidth:(float)width {
	[painView setCurrentColor:color];
	[painView setPainWidth:width];
	painView.useRandomColor=NO;
}

//创建新的画布
- (IBAction)newPicture:(id)sender{
	UIActionSheet *newPaintAction = [[UIActionSheet alloc] initWithTitle:nil 
																delegate:self 
													   cancelButtonTitle:@"Cancel" 
												  destructiveButtonTitle:@"Save" 
													   otherButtonTitles:@"Clear", @"Save And Clear", nil];
	newPaintAction.tag = 2;
	[newPaintAction showInView:self.view];
	[newPaintAction release];
		
}

//选取Red\Green\Blue\Randome颜色
- (IBAction)changeColor:(id)sender {
	NSInteger index = [sender tag];
	switch (index) {
		case 101:
			painView.currentColor = [UIColor redColor];
			painView.useRandomColor = NO;
			break;
		case 102:
			painView.currentColor = [UIColor greenColor];
			painView.useRandomColor = NO;
			break;
		case 103:
			painView.currentColor = [UIColor blueColor];
			painView.useRandomColor = NO;
			break;
		case 104:
			painView.useRandomColor = YES;
			break;
		default:
			break;
	}
}

//选择画笔样式
- (IBAction)changeShape:(id)sender {
	NSInteger index = [sender tag];
	switch (index) {
		case 115:
			if ([UIImagePickerController isSourceTypeAvailable:
					 UIImagePickerControllerSourceTypePhotoLibrary]) {
				UIImagePickerController *picker = [[UIImagePickerController alloc] init];
				picker.delegate = self;
				picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
				[self presentModalViewController:picker animated:YES];
				//[picker release];
			}
			else {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error accessing photo library!" 
																												message:@"Device does not support\
															                                  a photo library!" 
																											 delegate:nil 
																							cancelButtonTitle:@"Drat" 
																							otherButtonTitles:nil];
				[alert show];
				[alert release];
			}
			break;
		default:
			break;
	}
	[painView setShapeType:index - 111];
}

//设置颜色的按钮触摸事件
- (IBAction)setColor:(id)sender {
	if ([[sender titleForState:UIControlStateNormal] compare:@"Setting"] == 0) {
		settingView = [[UISetting alloc] initWithNibName:@"Setting" bundle:nil];
		CATransition *animation = [CATransition animation];
		animation.duration = 0.2f;
		animation.delegate = self;
		animation.timingFunction = UIViewAnimationCurveEaseInOut;
		animation.type = kCATransitionMoveIn;
		animation.subtype = kCATransitionFromBottom;
		[[settingView.view layer] addAnimation:animation forKey:@"LeftToolIn"];
		[mainView addSubview:settingView.view];
		
		[setColorButton setTitle:@"Done" forState:UIControlStateNormal];
		settingView.delegate = self;
		[settingView initWithColor:[painView currentColor] andLineWidth:[painView painWidth]];
	}
	else {
		[settingView setColor:[UIColor colorWithRed:settingView.redSlider.value 
											  green:settingView.greenSlider.value 
											   blue:settingView.blueSlider.value 
											  alpha:settingView.opacitySlider.value] 
		 andLineWidthDelegate:[settingView.textLineWidth.text floatValue]];
		CATransition *animation = [CATransition animation];
		animation.duration = 0.2f;
		animation.delegate = self;
		animation.timingFunction = UIViewAnimationCurveEaseInOut;
		animation.type = kCATransitionReveal;
		animation.subtype = kCATransitionFromTop;
		[[painView layer] addAnimation:animation forKey:@"LeftToolOut"];
		[settingView.view removeFromSuperview];
		
		[setColorButton setTitle:@"Setting" forState:UIControlStateNormal];
	}
}
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	leftViewInOrOut=NO;
	bottomViewInOrOut=NO;
	painView=(QuartzFunView *)mainView;
	[painView setViewController:self];
	
	leftToolViewController=[[LeftTool alloc] initWithNibName:@"LeftTool" bundle:nil];
	leftToolViewController.viewController=self;
	
	previewController=[[PreviewImage alloc] initWithNibName:@"PreviewImage" bundle:nil];
	previewController.paintView=painView;
	previewController.scale=1.0f;
	previewController.KImageOrientation=UIImageOrientationUp;
	
	bottonToolViewController=[[BottomTool alloc] initWithNibName:@"BottomTool" bundle:nil];
	bottonToolViewController.viewController=self;
//	self.undoButton.hidden=YES;
//	self.redoButton.hidden=YES;
//	self.undoManager = [[NSUndoManager alloc] init];
//	[self.undoManager setLevelsOfUndo:999];
//	[self.undoManager release];
}




// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.colorControl = nil;
	self.settingView = nil;
	self.setColorButton = nil;
	self.mainView = nil;
	self.undoButton = nil;
	self.redoButton = nil;
	self.leftToolViewController = nil;
	self.saveImage = nil;
	self.leftAnimationView = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	[colorControl release];
	[settingView release];
	[setColorButton release];
	[mainView release];
    
	[undoButton release];
	[redoButton release];
	[leftToolViewController release];
	[saveImage release];
	[leftAnimationView release];
  [super dealloc];
}

//检测并设置撤销和恢复按钮的显示或者隐藏
- (void) checkUndoAndHideIfNeeded {
	while ([self.undoManager isUndoing]);
	while ([self.undoManager isRedoing]);
	
	// Don't show the undo button if the undo stack is empty. Ditto redo
	if (!self.undoManager.canUndo) 
		self.undoButton.hidden = YES;
	else
		self.undoButton.hidden = NO;
	
	if (!self.undoManager.canRedo) 
		self.redoButton.hidden = YES;
	else
		self.redoButton.hidden = NO;
}

//实现图片选取器的两个代理方法
#pragma mark ---
#pragma make imagePickerController delegate method
- (void)imagePickerController:(UIImagePickerController *)picker 
				didFinishPickingImage:(UIImage *)imagePic editingInfo:(NSDictionary *)editingInfo {

	[self.view addSubview:previewController.view];
	///resize imageview size for image---change imageview size
	CGSize imageSize = [imagePic size];
	CGSize imageViewSize = [previewController.imagePreview frame].size;
	NSLog(@"imagePreviewSize:%f,%f", imageViewSize.width, imageViewSize.height);
	NSLog(@"imageSize:%f,%f", imageSize.width, imageSize.height);
	//
	if (imageSize.width <= imageViewSize.width && imageSize.height <= imageViewSize.height) {
		//previewController.imagePreview.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
	}
	previewController.imagePreview.image = [UIImage imageWithCGImage:[imagePic CGImage] 
																														 scale:1.0f 
																											 orientation:UIImageOrientationUp];
	previewController.image = [imagePic retain];
	previewController.scale = 1.0f;
	previewController.scaleSlider.value = 0.5f;
	previewController.KImageOrientation = UIImageOrientationUp;
	[picker dismissModalViewControllerAnimated:YES];
	[picker release];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[picker dismissModalViewControllerAnimated:YES];
}
@end
