//
//  CustomPickView.h
//  HHY
//
//  Created by chenguangjiang on 14-11-11.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomPickDelegate <NSObject>

-(void)didSelectIndexRow:(NSString *)row withButTag:(NSInteger)tag;

@end
@interface CustomPickView : UIView<UIScrollViewDelegate>
@property (nonatomic,assign)id <CustomPickDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scrolView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,copy)NSArray *arr;
-(void)show:(UIViewController *)vc;
-(void)hidden;
- (IBAction)cancel;
- (IBAction)sure;
@end


