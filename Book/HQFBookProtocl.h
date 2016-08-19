//
//  HQFBookProtocl.h
//  IOS
//
//  Created by qianfeng on 13-11-12.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HQFBookProtocl <NSObject>

- (void)tableViewCellIndex:(NSInteger)index Andshu:(NSInteger)shu;
- (void)scorllViewWithBookId:(NSString *)bookId AndClickShu:(NSInteger)shu;
@end
