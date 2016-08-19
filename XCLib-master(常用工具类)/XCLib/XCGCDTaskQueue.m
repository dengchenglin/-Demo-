//
//  SFTaskQueueManager.m
//  smileFace
//
//  Created by qianbailangmac on 15/11/24.
//  Copyright © 2015年 千百浪. All rights reserved.
//

#import "XCGCDTaskQueue.h"

@interface XCGCDTaskQueue ()
@property (nonatomic, strong) dispatch_queue_t taskQueue;
@property (nonatomic, strong) dispatch_group_t taskGroup;
@end

@implementation XCGCDTaskQueue

- (id)init
{
    if (self = [super init]) {
        _taskQueue = dispatch_queue_create("cn.sinsmin.ConcurrentTaskQueue", DISPATCH_QUEUE_CONCURRENT);
        _taskGroup = dispatch_group_create();
    }
    return self;
}

+ (instancetype)sharedTaskQueue
{
    static XCGCDTaskQueue *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[XCGCDTaskQueue alloc] init];
    });
    return _sharedClient;
}

- (void)addTask:(dispatch_block_t)block
{
    if (!block) {
        return;
    }
    dispatch_group_async(self.taskGroup, self.taskQueue, block);
}

- (void)addTask:(dispatch_block_t)block completionOnMainQueue:(dispatch_block_t)completion
{
    if (!block) {
        return;
    }
    dispatch_group_async(self.taskGroup, self.taskQueue, ^{
        dispatch_sync(self.taskQueue, block);
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), completion);
        }
    });
}

- (void)addTaskOnMainQueue:(dispatch_block_t)block
{
    if (!block) {
        return;
    }
    dispatch_group_async(self.taskGroup, dispatch_get_main_queue(), block);
}

- (void)addGroupTask:(NSArray<dispatch_block_t> *)blocks
{
    [self addGroupTask:blocks notificationBlock:nil];
}

- (void)addGroupTask:(NSArray<dispatch_block_t> *)blocks notificationBlock:(dispatch_block_t)notificationBlock
{
    for (dispatch_block_t block in blocks) {
        if (block) {
            dispatch_group_async(self.taskGroup, self.taskQueue, block);
        }
    }
    if (notificationBlock) {
        dispatch_group_notify(self.taskGroup, dispatch_get_main_queue(), notificationBlock);
    }
}
@end
