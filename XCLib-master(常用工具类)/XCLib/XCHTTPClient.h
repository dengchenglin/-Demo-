
#import <Foundation/Foundation.h>

typedef void(^XCHTTPClientCompletionBlock)(id responseObject, NSURLResponse *response);
typedef void(^XCHTTPClientFailureBlock)(NSError *error);
typedef void(^XCHTTPClientProgressBlock)(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend);
typedef void(^XCHTTPClientDownloadCompletionBlock)(NSURL *location, NSURLResponse *response);

//请求开始通知
extern NSString * const XCHTTPClientTaskDidStartNotification;
//请求结束通知
extern NSString * const XCHTTPClientTaskDidFinishNotification;
//请求错误通知
extern NSString * const XCHTTPClientTaskErrorKey;
//下载的文件地址Key
extern NSString * const XCHTTPClientTaskDownloadLocationURLKey;

/**
 *  序列化协议
 */
@protocol XCHTTPClientResponseSerializer <NSObject>
/**
 *  序列化
 *
 *  @param response 响应对象
 *  @param data     响应的数据
 *  @param error    错误
 *
 *  @return 序列化后对象
 */
- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error;
@end

/**
 *  序列化成NSData
 */
@interface XCHTTPResponseSerializer : NSObject<XCHTTPClientResponseSerializer>
/**
 *  默认utf8
 */
@property (nonatomic, assign) NSStringEncoding stringEncoding;
@end

/**
 *  序列化成JOSN(NSArray|NSDictionary)
 */
@interface XCJSONResponseSerializer : XCHTTPResponseSerializer
/**
 *  是否忽略null值
 */
@property (nonatomic, assign) BOOL ignoreNullValue;
@end

@interface XCHTTPClient : NSObject
/**
 *  序列化对象
 */
@property (nonatomic, strong) id<XCHTTPClientResponseSerializer> responseSerializer;
/**
 *  session 如果要更改此session delegate对象（影响上传、下载的代理方法），请自行实现session代理方法
 */
@property (nonatomic, strong) NSURLSession *session;
/**
 *  请求队列
 */
@property (nonatomic, strong) NSOperationQueue *operationQueue;
/**
 *  session 配置对象
 */
@property (nonatomic, strong) NSURLSessionConfiguration *configuration;

/**
 *  请求实例
 *
 *  @return
 */
+ (instancetype)sharedInstance;
/**
 *  post请求
 *
 *  @param requestURL 请求URL
 *  @param parameter  请求参数
 *  @param completion 请求完成回调
 *  @param failure    请求失败回调
 *
 *  @return 任务对象
 */
- (NSURLSessionDataTask *)postWithURL:(NSURL *)requestURL parameter:(NSDictionary *)parameter completion:(XCHTTPClientCompletionBlock)completion failure:(XCHTTPClientFailureBlock)failure;
/**
 *  get请求
 *
 *  @param requestURL 请求URL
 *  @param parameter  请求参数
 *  @param completion 请求完成回调
 *  @param failure    请求失败回调
 *
 *  @return 任务对象
 */
- (NSURLSessionDataTask *)getWithURL:(NSURL *)requestURL parameter:(NSDictionary *)parameter completion:(XCHTTPClientCompletionBlock)completion failure:(XCHTTPClientFailureBlock)failure;
/**
 *  资源上传
 *
 *  @param requestURL 请求URL
 *  @param parameter  请求参数
 *  @param bodyData   上传的数据
 *  @param progress   上传进度回调
 *  @param completion 请求完成回调
 *  @param failure    请求失败回调
 *
 *  @return 任务对象
 */
- (NSURLSessionUploadTask *)uploadWithURL:(NSURL *)requestURL parameter:(NSDictionary *)parameter fromData:(NSData *)bodyData progress:(XCHTTPClientProgressBlock)progress completion:(XCHTTPClientCompletionBlock)completion failure:(XCHTTPClientFailureBlock)failure;
/**
 *  资源下载
 *
 *  @param requestURL 请求URL
 *  @param parameter  请求参数
 *  @param progress   下载进度
 *  @param completion 请求完成回调
 *  @param failure    请求失败回调
 *
 *  @return 任务对象
 */
- (NSURLSessionDownloadTask *)downloadWithURL:(NSURL *)requestURL parameter:(NSDictionary *)parameter progress:(XCHTTPClientProgressBlock)progress completion:(XCHTTPClientDownloadCompletionBlock)completion failure:(XCHTTPClientFailureBlock)failure;;
@end