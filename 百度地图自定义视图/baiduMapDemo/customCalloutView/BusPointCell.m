//
//  BusPointCell.m
//  ZNBC
//
//  Created by 杨晓龙 on 13-4-11.
//  Copyright (c) 2013年 yangxiaolong. All rights reserved.
//

#import "BusPointCell.h"

@implementation BusPointCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
- (void)dealloc {
    [_aliasLabel release];
    [_speedLabel release];
    [_degreeLabel release];
    [_nameLabel release];
    [super dealloc];
}
@end
