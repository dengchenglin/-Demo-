//
//  HQFThreeViewController.h
//  IOS
//
//  Created by qianfeng on 13-11-7.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookReadProtocol <NSObject>

- (void)bookId:(NSString *)bookId AndChapterId:(NSInteger)chapterId;

@end

@interface HQFThreeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString *bookName;
    NSString *bookId;
    NSInteger chapterId;
    NSString *bookAouter;
    NSString *bookType;
}
- (IBAction)bianJiBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *shuJiaTableView;
@property (nonatomic,assign) id<BookReadProtocol>delegate;

@end
