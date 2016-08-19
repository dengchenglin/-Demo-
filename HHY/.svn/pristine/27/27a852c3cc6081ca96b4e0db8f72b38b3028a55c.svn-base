//
//  JJMemoryManger.h
//  ToolsDemo
//
//  Created by jiangjun on 14-3-31.
//  Copyright (c) 2014年 jiangjun. All rights reserved.
//

#if __has_feature(objc_arc)
#define JJRetain(obj) (obj)
#define JJRelease(obj) do { } while(0)
#define JJAutorelease(obj) (obj)
#define JJSuperDealloc do { } while(0)

#else

#define JJRetain(obj) [(obj) retain]
#define JJRelease(obj) do { [(obj) release]; (obj) = nil; } while(0)
#define JJAutorelease(obj) [(obj) autorelease]
#define JJSuperDealloc [super dealloc]

#endif

