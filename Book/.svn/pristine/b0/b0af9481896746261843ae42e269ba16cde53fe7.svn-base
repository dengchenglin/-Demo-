//
//  HQFSecondViewController.h
//  IOS
//
//  Created by qianfeng on 13-11-7.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"


@protocol HQFSecondProtocl <NSObject>

- (void)secondIndex:(NSUInteger)secondIndex AndBookId:(NSString *)bookId AndBookName:(NSString *)bookName AndBookAouter:(NSString *)bookAouter AndType:(NSString *)bookType;
@end

@interface HQFSecondViewController : UIViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *myBtn;
- (IBAction)myBtn:(UIButton *)sender;

- (IBAction)searchBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *fenLeiView;
@property (weak, nonatomic) IBOutlet UIView *beiJingView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic) NSMutableArray *secondArr;
@property (weak, nonatomic) id<HQFSecondProtocl>delegate;

@end
