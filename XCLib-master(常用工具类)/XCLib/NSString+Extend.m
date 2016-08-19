//
//  NSString+Extend.m
//  XCLib
//
//  Created by qianbailangmac on 15/12/17.
//  Copyright © 2015年 XC. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)

- (NSString *)unicodeToUTF8String
{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

- (NSString *)fullPinYinString
{
    if ([self length]) {
        CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, ((__bridge CFStringRef)self));
        CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
        return CFBridgingRelease(string);
    }
    return nil;
}
@end
