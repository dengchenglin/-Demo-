//
//  ApplyPeopleModel.m
//  HHY
//
//  Created by 兵 张 on 14/11/20.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "ApplyPeopleModel.h"

@implementation ApplyPeopleModel
@synthesize company = _company;
@synthesize dept = _dept;
@synthesize email = _email;
@synthesize fname = _fname;
@synthesize peopleID = _peopleID;
@synthesize keshi = _keshi;
@synthesize sname = _sname;
@synthesize isChooesd = _isChooesd;

- (void)jieXi:(NSDictionary *)dic
{
    _isChooesd = NO;
    
    _company = [dic objectForKey:@"company"];
    _dept = [dic objectForKey:@"dept"];
    _fname = [dic objectForKey:@"fname"];
    _email = [dic objectForKey:@"email"];
    _peopleID = [dic objectForKey:@"id"];
    _keshi = [dic objectForKey:@"keshi"];
    _sname = [dic objectForKey:@"sname"];
}


@end
