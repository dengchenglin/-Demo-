//
//  HQFShowViewController.h
//  IOS
//
//  Created by qianfeng on 13-11-9.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQFBookProtocl.h"
#import "HQFSecondViewController.h"
#import "HQFFirstViewController.h"
#import "HQFReadProtocol.h"

@protocol HQFMuLuProtocl <NSObject>

- (void)muLuChapterId:(NSInteger)chapterId AndChapterFirst:(NSInteger)chapterFirst AndBookId:(NSString *)readBookId;

@end


@interface HQFShowViewController : UIViewController<UIScrollViewDelegate,UITextViewDelegate,HQFBookProtocl,UITableViewDataSource,UITableViewDelegate,HQFSecondProtocl>
{
    CGSize strSize;
    NSUInteger myIndex;
    NSUInteger myShu;
    NSString *secondBookId;
    NSString *secondBookName;
    NSString *secondAouter;
    NSString *sencondType;
    NSString *selfBookId;
    NSString *strUrl;
    NSUInteger myPageIndex;
    UILabel *myYeMianLabel;
    NSString *str1;
    BOOL flag;
}

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *tpye;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet UILabel *myTitle;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UIImageView *myImgV;
@property (weak, nonatomic) IBOutlet UITableView *myMuLuTableView;
@property (nonatomic,retain) NSString *chapteridFirst;
@property (nonatomic,assign) id<HQFReadProtocol>delegeta;
@property (nonatomic,assign) id<HQFMuLuProtocl>muLudegeta;








- (IBAction)myBtn:(id)sender;
- (IBAction)wCXiaZaiBtn:(UIButton *)sender;


@end
