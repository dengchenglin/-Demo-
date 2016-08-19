//
//  Define.h
//  HHY
//
//  Created by chenguangjiang on 14-10-23.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#ifndef HHY_Define_h
#define HHY_Define_h
#define EnCodingNSString(s) (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)s,NULL,CFSTR("!*’();:@&=+$,/?%#[]"),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))

#define kADWColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define HostName @"http://113.11.197.184:9090"

#endif
