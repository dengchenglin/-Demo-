//
//  HHYNetworkEngine.h
//  HHY
//
//  Created by 谈文钊 on 14-5-31.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"

typedef void (^HHYResponseBlock)(NSError *error, id data);

@interface HHYNetworkEngine : NSObject

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(HHYNetworkEngine)

@property (nonatomic, strong) MKNetworkEngine *mkEngine;
@property (nonatomic, strong) MKNetworkEngine *mkhotelEngine;
@property (nonatomic,copy)NSString *userID;
- (void)getDataForPath:(NSString *)path params:(NSDictionary *)params block:(HHYResponseBlock)block;
- (void)postDataForPath:(NSString *)path params:(NSDictionary *)params block:(HHYResponseBlock)block;
- (void)postURLDataForPath:(NSString *)path params:(NSDictionary *)params block:(HHYResponseBlock)block;
- (void)getHotelDataForPath:(NSString *)path params:(NSDictionary *)params block:(HHYResponseBlock)block;

- (void)postHotelDataForPath:(NSString *)path params:(NSDictionary *)params block:(HHYResponseBlock)block;
- (void)postHotelURLDataForPath:(NSString *)path params:(NSDictionary *)params block:(HHYResponseBlock)block;
- (void)OrderHotelCacle:path params:(NSDictionary *)params block:(HHYResponseBlock)block;
- (void)OrderHotelDetail:path params:(NSDictionary *)params block:(HHYResponseBlock)block;



-(void)saveUserID:(NSString *)userId;
@end
