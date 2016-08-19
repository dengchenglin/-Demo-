
#import <Foundation/Foundation.h>

/**
 *  队列任务管理类
 */
@interface XCGCDTaskQueue : NSObject

+ (instancetype)sharedTaskQueue;
/**
 *  添加异步任务
 *
 *  @param block 任务block
 */
- (void)addTask:(dispatch_block_t)block;
/**
 *  添加异步任务
 *
 *  @param block      任务block
 *  @param completion 任务完成block(主线程调用)
 */
- (void)addTask:(dispatch_block_t)block completionOnMainQueue:(dispatch_block_t)completion;
/**
 *  添加任务到主线程
 *
 *  @param block 任务block
 */
- (void)addTaskOnMainQueue:(dispatch_block_t)block;
/**
 *  添加一组任务
 *
 *  @param blocks 任务blocks
 */
- (void)addGroupTask:(NSArray<dispatch_block_t> *)blocks;
/**
 *  添加一组任务
 *
 *  @param blocks            任务blocks
 *  @param notificationBlock 执行完成后的block
 */
- (void)addGroupTask:(NSArray<dispatch_block_t> *)blocks notificationBlock:(dispatch_block_t)notificationBlock;
@end