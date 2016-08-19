
#import "AppInfoUtil.h"
#import <UIKit/UIDevice.h>

@implementation AppInfoUtil

+ (NSString *)getAppName
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

+ (NSString *)getAppVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getAppBundleVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+ (NSString *)getAppBundleIdentifier
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

+ (BOOL)isNewVersion
{
    NSString *version = [self getAppVersion];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:APP_VERSION_KEY];
    if ([version isEqualToString:str]) {
        return NO;
    }
    return YES;
}

+ (void)saveCurrentVersion
{
    [[NSUserDefaults standardUserDefaults] setObject:[self getAppVersion] forKey:APP_VERSION_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)generateUserAgentWithIdentifier:(NSString *)identifier
{
    return [NSString stringWithFormat:@"%@/%@(%@);%@,%@;%@", [self getAppName], [self getAppVersion], identifier, [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion,[UIDevice currentDevice].model];
}
@end
