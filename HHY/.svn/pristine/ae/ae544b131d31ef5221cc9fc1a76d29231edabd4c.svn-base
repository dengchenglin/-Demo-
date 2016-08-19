//
//  SynthesizeSingleton.h
//
// Modified by Karl Stenerud starting 16/04/2010.
// - Moved the swizzle code to allocWithZone so that non-default init methods may be
//   used to initialize the singleton.
// - Added "lesser" singleton which allows other instances besides sharedInstance to be created.
// - Added guard ifndef so that this file can be used in multiple library distributions.
// - Made singleton variable name class-specific so that it can be used on multiple classes
//   within the same compilation module.
//
//  Modified by CJ Hanson on 26/02/2010.
//  This version of Matt's code uses method_setImplementaiton() to dynamically
//  replace the +sharedInstance method with one that does not use @synchronized
//
//  Based on code by Matt Gallagher from CocoaWithLove
//
//  Created by Matt Gallagher on 20/10/08.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#ifndef SYNTHESIZE_SINGLETON_FOR_CLASS

#import <objc/runtime.h>


#pragma mark -
#pragma mark Singleton

/*Synthesize Singleton For Class
 *
  *Creates a singleton interface for the specified class with the following methods:
 *
  *+ (MyClass*) sharedInstance;
  *+ (void) purgeSharedInstance;
 *
  *Calling sharedInstance will instantiate the class and swizzle some methods to ensure
  *that only a single instance ever exists.
  *Calling purgeSharedInstance will destroy the shared instance and return the swizzled
  *methods to their former selves.
 *
  *
  *Usage:
 *
  *MyClass.h:
  *========================================
 *	#import "SynthesizeSingleton.h"
 *
 *	@interface MyClass: SomeSuperclass
 *	{
 *		...
 *	}
 *	SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(MyClass);
 *
 *	@end
  *========================================
 *
 *
 *	MyClass.m:
  *========================================
 *	#import "MyClass.h"
 *
 *	// This line is optional. Use it if you've enabled GCC_WARN_UNDECLARED_SELECTOR
 *	SYNTHESIZE_SINGLETON_FOR_CLASS_PROTOTYPE(MyClass);
 *
 *	@implementation MyClass
 *
 *	SYNTHESIZE_SINGLETON_FOR_CLASS(MyClass);
 *
 *	...
 *
 *	@end
  *========================================
 *
 *
  *Note: Calling alloc manually will also initialize the singleton, so you
  *can call a more complex init routine to initialize the singleton like so:
 *
  *[[MyClass alloc] initWithParam:firstParam secondParam:secondParam];
 *
  *Just be sure to make such a call BEFORE you call "sharedInstance" in
  *your program.
 */

#define SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(SS_CLASSNAME)	\
	\
+ (SS_CLASSNAME*) sharedInstance;	\

#define SYNTHESIZE_MINI_SINGLETON_FOR_CLASS(SS_CLASSNAME)\
\
+ (SS_CLASSNAME*) sharedInstance	\
{\
return [[MiniSingletonFactory sharedInstance] singleInstanceWith:@#SS_CLASSNAME]; \
}\

#define SYNTHESIZE_MINI_ARC_SINGLETON_FOR_CLASS(SS_CLASSNAME)\
\
+ (SS_CLASSNAME*) sharedInstance	\
{\
static SS_CLASSNAME *instance;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [[SS_CLASSNAME alloc] init];\
});\
return instance;\
}\

#define SYNTHESIZE_SINGLETON_FOR_CLASS(SS_CLASSNAME)	\
	\
static  SS_CLASSNAME *_##SS_CLASSNAME##_sharedInstance = nil;	\
	\
+ (SS_CLASSNAME*) sharedInstance	\
{	\
    @synchronized(self)\
    {\
        if (_##SS_CLASSNAME##_sharedInstance == nil)\
        {\
            _##SS_CLASSNAME##_sharedInstance = [[self alloc] init];\
        }\
    }\
	return _##SS_CLASSNAME##_sharedInstance; \
}	\
	\
+ (id)allocWithZone:(NSZone*) zone	\
{	\
	@synchronized(self)	\
	{	\
		if (nil == _##SS_CLASSNAME##_sharedInstance)	\
		{	\
			_##SS_CLASSNAME##_sharedInstance = [super allocWithZone:zone];	\
			return _##SS_CLASSNAME##_sharedInstance;\
		}	\
	}	\
	return nil;	\
}	\
- (id)copyWithZone:(NSZone *)zone	\
{	\
	return self;	\
}	\
	\
- (id)retain	\
{	\
	return self;	\
}	\
	\
- (NSUInteger)retainCount	\
{	\
	NSAssert1(1==0, @"SynthesizeSingleton: %@ ERROR: -(NSUInteger)retainCount method did not get swizzled.", self);	\
	return UINT_MAX;	\
}	\
	\
- (id)autorelease	\
{	\
	NSAssert1(1==0, @"SynthesizeSingleton: %@ ERROR: -(id)autorelease method did not get swizzled.", self);	\
	return self;	\
}	\
	\

#endif /*SYNTHESIZE_SINGLETON_FOR_CLASS */
