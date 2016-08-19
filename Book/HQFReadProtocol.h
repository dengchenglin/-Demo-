//
//  HQFReadProtocol.h
//  IOS
//
//  Created by qianfeng on 13-11-17.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HQFReadProtocol <NSObject>
- (void)readBookId:(NSString *)bookId AndChapterFirstId:(NSString *)chapterFirstId;

@end
