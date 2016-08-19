 //
//  HHYNetworkEngine.m
//  HHY
//
//  Created by 谈文钊 on 14-5-31.
//  Copyright (c) 2014年 yunluosoft. All rights reserved.
//

#import "HHYNetworkEngine.h"

static NSString * const HHYHostName = @"113.11.197.184:7070/cloud";
static NSString * const HHYHotelHostName = @"www.hhytours.com";
//static NSString * const HHYHotelHostName = @"113.11.197.184:9090";

@implementation HHYNetworkEngine

SYNTHESIZE_MINI_ARC_SINGLETON_FOR_CLASS(HHYNetworkEngine)

- (id)init
{
    if (self = [super init]) {
        self.mkEngine = [[MKNetworkEngine alloc] initWithHostName:HHYHostName];
        self.mkhotelEngine = [[MKNetworkEngine alloc]initWithHostName:HHYHotelHostName];
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"userId"])
        {
            self.userID  = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        }
    }
    return self;
}
-(void)saveUserID:(NSString *)userId
{
    if(userId != nil)
    {
        self.userID = userId;
        [[NSUserDefaults standardUserDefaults] setObject:_userID forKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        self.userID = nil;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
    }
    
   
    
    
    
}

- (void)success:(id)responseObject block:(HHYResponseBlock)block
{
    NSLog(@"JSON: %@", responseObject);
    if ([responseObject isKindOfClass:[NSDictionary class]] ) {
        NSString *msg = [responseObject objectForKey:@"msg"];
        NSString *result =[responseObject objectForKey:@"result"];
        if ([msg isEqualToString:@"ok"]) {
            block(nil, [responseObject objectForKey:@"result"]);
            if([responseObject objectForKey:@"userId"])
            {
                [self saveUserID:[responseObject objectForKey:@"userId"]];
                if ([responseObject objectForKey:@"level"] ) {
                    [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"level"] forKey:@"level"];
                    [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"email"] forKey:@"applyEmail"];
                }
            }
        } else {
            if ([[responseObject objectForKey:@"result"] isEqualToString:@"tokenErr"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNeedLogin object:nil];
            }
            NSError *er = [NSError errorWithDomain:@"HHY"
                                              code:9998
                                          userInfo:@{NSLocalizedDescriptionKey: msg}];
            if(result && result.length != 0)
            {
                block(er, result);
            }
            else{
                block(er, nil);
            }
        }
        
    } else if ([responseObject isKindOfClass:[NSArray class]]) {
        block(nil,responseObject);
    } else {
        NSError *er = [NSError errorWithDomain:@"HHY"
                                          code:9999
                                      userInfo:@{NSLocalizedDescriptionKey: @"数据异常"}];
        block(er, nil);
    }
}

- (void)error:(NSError *)error block:(HHYResponseBlock)block
{
    NSLog(@"Error: %@", error);
    block(error, nil);
}

- (void)getDataForPath:(NSString *)path params:(NSDictionary *)params block:(HHYResponseBlock)block;
{
    
    MKNetworkOperation *op = [self.mkEngine operationWithPath:path params:params httpMethod:@"GET"];

    NSLog(@"%@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
           NSLog(@"json:%@", completedOperation.responseString);
        [self success:completedOperation.responseJSON block:block];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self error:error block:block];
    }];
    [self.mkEngine enqueueOperation:op];
}

- (void)postDataForPath:(NSString *)path params:(NSDictionary *)params block:(HHYResponseBlock)block
{
    MKNetworkOperation *op = [self.mkEngine operationWithPath:path params:params httpMethod:@"POST"];
  
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;

    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [self success:completedOperation.responseJSON block:block];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self error:error block:block];
    }];
    [self.mkEngine enqueueOperation:op];
}

-(void)postURLDataForPath:(NSString *)path params:(NSDictionary *)params block:(HHYResponseBlock)block
{
    MKNetworkOperation *op = [self.mkEngine operationWithPath:path params:params httpMethod:@"POST"];
   
    op.postDataEncoding = MKNKPostDataEncodingTypeURL;
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"json:%@", completedOperation.responseString);
        
        [self success:completedOperation.responseJSON block:block];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"json:%@", completedOperation.responseString);
        [self error:error block:block];
    }];
    [self.mkEngine enqueueOperation:op];
    
    
    
//    MKNetworkOperation *op = [self.mkEngine operationWithPath:path params:params httpMethod:@"POST"];
//
//    op.postDataEncoding = MKNKPostDataEncodingTypeURL;
// 
//    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//    NSLog(@"json:%@", completedOperation.responseString);
//        [self success:completedOperation.responseJSON block:block];
//    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//      NSLog(@"json:%@", completedOperation.responseString);
//        [self error:error block:block];
//    }];
//    [self.mkEngine enqueueOperation:op];
}


//酒店相关数据
- (void)getHotelDataForPath:(NSString *)path params:(NSDictionary *)params block:(HHYResponseBlock)block;
{
    MKNetworkOperation *op = [self.mkhotelEngine operationWithPath:path params:params httpMethod:@"GET"];
    NSLog(@"%@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        block(nil,completedOperation);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self error:error block:block];
    }];
    [self.mkhotelEngine enqueueOperation:op];
}


//酒店相关数据
- (void)postHotelDataForPath:(NSString *)path params:(NSDictionary *)params block:(HHYResponseBlock)block;
{
    MKNetworkOperation *op = [self.mkhotelEngine operationWithPath:path params:params httpMethod:@"POST"];
    NSLog(@"%@",op.url);
    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        block(nil,completedOperation);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self error:error block:block];
    }];
    [self.mkhotelEngine enqueueOperation:op];
}

- (void)postHotelURLDataForPath:(NSString *)path params:(NSDictionary *)params block:(HHYResponseBlock)block;
{
    MKNetworkOperation *op = [self.mkhotelEngine operationWithPath:path params:params httpMethod:@"POST"];
    NSLog(@"%@",op.url);
    op.postDataEncoding = MKNKPostDataEncodingTypeURL;
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"json:%@", completedOperation.responseString);
        [self success:completedOperation.responseJSON block:block];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self error:error block:block];
    }];
    [self.mkhotelEngine enqueueOperation:op];
}

- (void)OrderHotelCacle:path params:(NSDictionary *)params block:(HHYResponseBlock)block
{
    MKNetworkOperation *op = [self.mkhotelEngine operationWithPath:path params:params httpMethod:@"POST"];
    NSLog(@"%@",op.url);
    op.postDataEncoding = MKNKPostDataEncodingTypeURL;
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"json:%@", completedOperation.responseString);
        block(nil, completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self error:error block:block];
    }];
    [self.mkhotelEngine enqueueOperation:op];
}

- (void)OrderHotelDetail:path params:(NSDictionary *)params block:(HHYResponseBlock)block
{
    MKNetworkOperation *op = [self.mkhotelEngine operationWithPath:path params:params httpMethod:@"POST"];
    NSLog(@"%@",op.url);
    op.postDataEncoding = MKNKPostDataEncodingTypeURL;
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        block(nil, completedOperation.responseJSON);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self error:error block:block];
    }];
    [self.mkhotelEngine enqueueOperation:op];
}


- (void)OrderHotelApply:path params:(NSDictionary *)params block:(HHYResponseBlock)block
{
    MKNetworkOperation *op = [self.mkhotelEngine operationWithPath:path params:params httpMethod:@"POST"];
    NSLog(@"%@",op.url);
    op.postDataEncoding = MKNKPostDataEncodingTypeURL;
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        block(nil, completedOperation);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self error:error block:block];
    }];
    [self.mkhotelEngine enqueueOperation:op];
}

- (void)successhotel:(id)responseObject block:(HHYResponseBlock)block
{
    
}


@end
