//
//  PersonModel.m
//  HHY
//
//  Created by jiangjun on 14-6-5.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel
-(void)setCreditType:(NSString<Optional> *)creditType
{
    if(_creditType != creditType)
    {
        if([creditType isEqualToString:@"0"])
        {
            _creditType = @"身份证";
        }
        if([creditType isEqualToString:@"1"])
        {
            _creditType = @"护照";
        }
        if([creditType isEqualToString:@"2"])
        {
            _creditType = @"其他";
        }
    }
    
}
@end
