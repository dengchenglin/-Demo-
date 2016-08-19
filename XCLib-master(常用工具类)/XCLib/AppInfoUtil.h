

#import <Foundation/Foundation.h>

#define APP_VERSION_KEY @"AppVersion"

@interface AppInfoUtil : NSObject
/**
 *  App名称
 *
 *  @return
 */
+ (NSString *)getAppName;
/**
 *  App版本
 *
 *  @return
 */
+ (NSString *)getAppVersion;
/**
 *  App构建版本
 *
 *  @return
 */
+ (NSString *)getAppBundleVersion;
/**
 *  App bundle id
 *
 *  @return
 */
+ (NSString *)getAppBundleIdentifier;
/**
 *  是否是新版本
 *
 *  @return
 */
+ (BOOL)isNewVersion;
/**
 *  保存当前版本号到NSUserDefaults
 */
+ (void)saveCurrentVersion;
/**
 *  生成请求头的User-Agent字段；格式：app name/app version(customer identifier);os name,os version;device name
 *
 *  @param identifier 自定义标识字符串
 *
 *  @return User-Agent标识字符串
 */
+ (NSString *)generateUserAgentWithIdentifier:(NSString *)identifier;
@end