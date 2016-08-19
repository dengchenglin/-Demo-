
#import "XCHTTPClient.h"

NSString * const XCHTTPClientTaskDidStartNotification = @"cn.sinsmin.XCHTTPClientTaskDidStartNotification";
NSString * const XCHTTPClientTaskDidFinishNotification = @"cn.sinsmin.XCHTTPClientTaskDidFinishNotification";
NSString * const XCHTTPClientTaskErrorKey = @"cn.sinsmin.XCHTTPClientTaskErrorKey";
NSString * const XCHTTPClientTaskDownloadLocationURLKey = @"cn.sinsmin.XCHTTPClientTaskDownloadLocationURLKey";

#define CallOnMainQueue(block) dispatch_async(dispatch_get_main_queue(), (block))

static id XCJSONObjectRemoveKeysWithNullValues(id JSONObject, NSJSONReadingOptions readingOptions)
{
    if ([JSONObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[(NSArray *)JSONObject count]];
        for (id value in (NSArray *)JSONObject) {
            [mutableArray addObject:XCJSONObjectRemoveKeysWithNullValues(value, readingOptions)];
        }
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableArray : [NSArray arrayWithArray:mutableArray];
    } else if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:JSONObject];
        for (id <NSCopying> key in [(NSDictionary *)JSONObject allKeys]) {
            id value = [(NSDictionary *)JSONObject objectForKey:key];
            if (!value || [value isEqual:[NSNull null]]) {
                [mutableDictionary removeObjectForKey:key];
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                [mutableDictionary setObject:XCJSONObjectRemoveKeysWithNullValues(value, readingOptions) forKey:key];
            }
        }
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableDictionary : [NSDictionary dictionaryWithDictionary:mutableDictionary];
    }
    return JSONObject;
}

static void XCPostNotification(NSString *notificationName,id object,NSDictionary *userInfo)
{
    CallOnMainQueue(^{
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:object userInfo:userInfo];
    });
}

@implementation XCHTTPResponseSerializer

- (instancetype)init
{
    if (self = [super init]) {
        self.stringEncoding = NSUTF8StringEncoding;
    }
    return self;
}

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
    return data;
}
@end

@implementation XCJSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error
{
    NSStringEncoding stringEncoding = self.stringEncoding;
    if (response.textEncodingName) {
        CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)response.textEncodingName);
        if (encoding != kCFStringEncodingInvalidId) {
            stringEncoding = CFStringConvertEncodingToNSStringEncoding(encoding);
        }
    }
    id responseObject = nil;
    NSError *serializationError = nil;
    @autoreleasepool {
        NSString *responseString = [[NSString alloc] initWithData:data encoding:stringEncoding];
        if (responseString && responseString.length > 0) {
            data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            if (data) {
                if ([data length] > 0) {
                    responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                } else {
                    return nil;
                }
            } else {
                NSDictionary *userInfo = @{
                                           NSLocalizedDescriptionKey: @"Data failed decoding as a UTF-8 string",
                                           NSLocalizedFailureReasonErrorKey: [NSString stringWithFormat:@"Could not decode string: %@", responseString]
                                           };
                serializationError = [NSError errorWithDomain:@"cn.sinsmin.error.serialization.response" code:NSURLErrorCannotDecodeContentData userInfo:userInfo];
            }
        }
    }
    if (self.ignoreNullValue && responseObject) {
        responseObject = XCJSONObjectRemoveKeysWithNullValues(responseObject, 0);
    }
    if (serializationError && error) {
        NSMutableDictionary *mutableUserInfo = [serializationError.userInfo mutableCopy];
        mutableUserInfo[NSUnderlyingErrorKey] = *error;
        *error = [[NSError alloc] initWithDomain:serializationError.domain code:serializationError.code userInfo:mutableUserInfo];
    }
    return responseObject;
}
@end

@interface XCHTTPClient ()<NSURLSessionTaskDelegate,NSURLSessionDownloadDelegate>
@property (nonatomic, copy) XCHTTPClientProgressBlock progressBlock;
@property (nonatomic, copy) XCHTTPClientDownloadCompletionBlock downloadCompletionBlock;
@property (nonatomic, copy) XCHTTPClientFailureBlock failureBlock;
@end

@implementation XCHTTPClient

+ (instancetype)sharedInstance
{
    static XCHTTPClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[XCHTTPClient alloc] init];
        sharedClient.responseSerializer = [[XCHTTPResponseSerializer alloc] init];
    });
    return sharedClient;
}

- (NSURLSessionDataTask *)postWithURL:(NSURL *)requestURL parameter:(NSDictionary *)parameter completion:(XCHTTPClientCompletionBlock)completion failure:(XCHTTPClientFailureBlock)failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:self.configuration.timeoutIntervalForRequest];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[self parameterToString:parameter stringEncoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [weakSelf handleTaskCompletion:dataTask data:data response:response error:error completion:completion failure:failure];
    }];
    XCPostNotification(XCHTTPClientTaskDidStartNotification, dataTask, nil);
    [dataTask resume];
    return dataTask;
}

- (NSURLSessionDataTask *)getWithURL:(NSURL *)requestURL parameter:(NSDictionary *)parameter completion:(XCHTTPClientCompletionBlock)completion failure:(XCHTTPClientFailureBlock)failure
{
    NSMutableString *urlString = [requestURL.absoluteString mutableCopy];
    if (parameter) {
        if ([urlString rangeOfString:@"?"].location != NSNotFound) {
            [urlString appendString:@"&"];
        } else {
            [urlString appendString:@"?"];
        }
        [urlString appendString:[self parameterToString:parameter stringEncoding:-1]];
    }
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:self.configuration.timeoutIntervalForRequest];
    request.HTTPMethod = @"GET";
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [weakSelf handleTaskCompletion:dataTask data:data response:response error:error completion:completion failure:failure];
    }];
    XCPostNotification(XCHTTPClientTaskDidStartNotification, dataTask, nil);
    [dataTask resume];
    return dataTask;
}

- (NSURLSessionUploadTask *)uploadWithURL:(NSURL *)requestURL parameter:(NSDictionary *)parameter fromData:(NSData *)bodyData progress:(XCHTTPClientProgressBlock)progress completion:(XCHTTPClientCompletionBlock)completion failure:(XCHTTPClientFailureBlock)failure
{
    self.progressBlock = progress;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:self.configuration.timeoutIntervalForRequest];
    request.HTTPMethod = @"POST";
    if (parameter) {
        request.HTTPBody = [[self parameterToString:parameter stringEncoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
    }
    __weak typeof(self) weakSelf = self;
    NSURLSessionUploadTask *uploadTask = [self.session uploadTaskWithRequest:request fromData:bodyData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [weakSelf handleTaskCompletion:uploadTask data:data response:response error:error completion:completion failure:failure];
        weakSelf.progressBlock = nil;
    }];
    XCPostNotification(XCHTTPClientTaskDidStartNotification, uploadTask, nil);
    [uploadTask resume];
    return uploadTask;
}

- (NSURLSessionDownloadTask *)downloadWithURL:(NSURL *)requestURL parameter:(NSDictionary *)parameter  progress:(XCHTTPClientProgressBlock)progress completion:(XCHTTPClientDownloadCompletionBlock)completion failure:(XCHTTPClientFailureBlock)failure
{
    self.progressBlock = progress;
    self.downloadCompletionBlock = completion;
    self.failureBlock = failure;
    NSMutableString *urlString = [requestURL.absoluteString mutableCopy];
    if (parameter) {
        if ([urlString rangeOfString:@"?"].location != NSNotFound) {
            [urlString appendString:@"&"];
        } else {
            [urlString appendString:@"?"];
        }
        [urlString appendString:[self parameterToString:parameter stringEncoding:-1]];
    }
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithURL:url];
    XCPostNotification(XCHTTPClientTaskDidStartNotification, downloadTask, nil);
    [downloadTask resume];
    return downloadTask;
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error
{
    self.progressBlock = nil;
    self.downloadCompletionBlock = nil;
    self.failureBlock = nil;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
{
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    NSURLCredential *credential = nil;
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        }
    }
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSDictionary *userInfo = nil;
    if (error && self.failureBlock) {
        userInfo = @{XCHTTPClientTaskErrorKey:error};
        dispatch_async(dispatch_get_main_queue(), ^{
            self.failureBlock(error);
            self.failureBlock = nil;
        });
    } else {
        self.failureBlock = nil;
    }
    XCPostNotification(XCHTTPClientTaskDidFinishNotification, task, userInfo);
    self.progressBlock = nil;
    self.downloadCompletionBlock = nil;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    if (self.progressBlock) {
        CallOnMainQueue(^{
            self.progressBlock(bytesSent, totalBytesSent, totalBytesExpectedToSend);
        });
    }
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSError *error = nil;
    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:filePath error:&error];
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
    if (error) {
        userInfo[XCHTTPClientTaskErrorKey] = error;
    }
    NSURL *url = [NSURL fileURLWithPath:filePath];
    userInfo[XCHTTPClientTaskDownloadLocationURLKey] = url;
    XCPostNotification(XCHTTPClientTaskDidFinishNotification, downloadTask, userInfo);
    if (self.downloadCompletionBlock) {
        CallOnMainQueue( ^{
            self.downloadCompletionBlock(url, downloadTask.response);
            self.downloadCompletionBlock = nil;
        });
        self.progressBlock = nil;
        self.failureBlock = nil;
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    if (self.progressBlock) {
        CallOnMainQueue(^{
            self.progressBlock(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        });
    }
}

#pragma mark - Private Method
- (void)handleTaskCompletion:(NSURLSessionTask *)task data:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error completion:(XCHTTPClientCompletionBlock)completion failure:(XCHTTPClientFailureBlock)failure
{
    id responseObject = nil;
    NSDictionary *userInfo = nil;
    if (completion) {
        responseObject = [self.responseSerializer responseObjectForResponse:response data:data error:&error];
    }
    if (error) {
        userInfo = @{XCHTTPClientTaskErrorKey:error};
    }
    XCPostNotification(XCHTTPClientTaskDidFinishNotification, task, userInfo);
    if (completion || failure) {
        CallOnMainQueue(^{
            if (error) {
                if (failure) {
                    failure(error);
                }
            } else {
                if (completion) {
                    completion(responseObject, response);
                }
            }
        });
    }
}

- (NSString *)parameterToString:(NSDictionary *)parameter stringEncoding:(NSStringEncoding)encoding
{
    if (!parameter || parameter.count < 1) {
        return @"";
    }
    NSMutableString *paramString = [NSMutableString string];
    for (NSString *key in parameter.allKeys) {
        [paramString appendFormat:@"%@=%@&", key, parameter[key]];
    }
    if (paramString.length > 0) {
        [paramString deleteCharactersInRange:NSMakeRange(paramString.length - 1, 1)];
    }
    if (encoding != -1) {
        return [paramString stringByReplacingPercentEscapesUsingEncoding:encoding];
    }
    return [paramString copy];
}

- (NSURLSessionConfiguration *)configuration
{
    if (!_configuration) {
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _configuration.timeoutIntervalForRequest = 10.0;
    }
    return _configuration;
}

- (NSURLSession *)session
{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:self.configuration delegate:self delegateQueue:self.operationQueue];
    }
    return _session;
}

- (NSOperationQueue *)operationQueue
{
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.name = @"cn.sinsmin.HTTPRequestQueue";
        _operationQueue.maxConcurrentOperationCount = 5;
    }
    return _operationQueue;
}
@end

