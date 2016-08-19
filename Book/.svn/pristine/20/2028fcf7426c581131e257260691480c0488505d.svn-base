//
//  HQFFirstViewController.h
//  IOS
//
//  Created by qianfeng on 13-11-7.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "HQFBookProtocl.h"


@interface HQFFirstViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
- (IBAction)mySearchBtn:(id)sender;
@property (nonatomic,assign) id<HQFBookProtocl>delegate;
@property (nonatomic,assign) BOOL isFirst;
@end
