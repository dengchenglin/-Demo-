//
//  TaskQueueViewController.m
//  XCLib
//
//  Created by qianbailangmac on 15/12/21.
//  Copyright © 2015年 XC. All rights reserved.
//

#import "TaskQueueViewController.h"
#import "XCLib.h"

@interface TaskQueueViewController()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)startAction:(id)sender;
@end

@implementation TaskQueueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __block unsigned long long size = 0;
    [[XCGCDTaskQueue sharedTaskQueue] addTask:^{
        size = [[XCObjectCacheManager sharedCacheManager] getAllCacheSize];
    } completionOnMainQueue:^{
        self.title = [NSString stringWithFormat:@"缓存大小:%.2fkb", size / 1024.0];
    }];
}

- (IBAction)startAction:(id)sender
{
    if (self.textField.text.length < 1) {
        return;
    }
    int count = [self.textField.text intValue];
    XCGCDTaskQueue *taskQueue = [XCGCDTaskQueue sharedTaskQueue];
    NSDate *start = [NSDate date];
    __block NSString *countString = nil;
    [taskQueue addTask:^{
        NSMutableArray *counts = [NSMutableArray arrayWithCapacity:count];
        for(int i = 0; i < count; i++) {
            [counts addObject:@(arc4random_uniform(count))];
        }
        countString = [counts componentsJoinedByString:@"\n"];
        NSData *data = [countString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *key = [[NSString alloc] initWithBytes:data.bytes length:8 encoding:NSUTF8StringEncoding];
        [[XCObjectCacheManager sharedCacheManager] saveForKey:key object:[XCSecurityUtil DESDecryptWithKey:key data:data]];
    } completionOnMainQueue:^{
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:start];
        self.textView.text = [NSString stringWithFormat:@"%d次任务耗时:%f\n%@", count,time, countString];
    }];
}
@end
