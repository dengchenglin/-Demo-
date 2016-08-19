//
//  HQFBookSelfModel.m
//  IOS
//
//  Created by qianfeng on 13-11-25.
//  Copyright (c) 2013年 黄庆丰. All rights reserved.
//

#import "HQFBookSelfModel.h"

@implementation HQFBookSelfModel

//-(id)initWithBookName:(NSString *)bookName AndBookId:(NSString *)bookId AndChapterId:(NSString *)chapterId
//{
//    if (self = [super init])
//    {
//        self.bookName = bookName;
//        self.bookId = bookId;
//        self.chapterId = chapterId;
//    }
//    
//    return self;
//}

//编码的时候会调用
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.bookName forKey:@"bookName"];
    [aCoder encodeObject:self.bookId forKey:@"bookId"];
    [aCoder encodeObject:self.chapterId forKey:@"bookChapterId"];
    [aCoder encodeObject:self.bookAouter forKey:@"bookAouter"];
    [aCoder encodeObject:self.bookType forKey:@"bookType"];
}

//解码的时候调用
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.bookName = [aDecoder decodeObjectForKey:@"bookName"];
        self.bookId = [aDecoder decodeObjectForKey:@"bookId"];
        self.chapterId = [aDecoder decodeObjectForKey:@"bookChapterId"];
        self.bookAouter = [aDecoder decodeObjectForKey:@"bookAouter"];
        self.bookType = [aDecoder decodeObjectForKey:@"bookType"];
    }
    
    return self;
}

@end
