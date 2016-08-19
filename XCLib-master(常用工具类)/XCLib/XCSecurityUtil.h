

#import <Foundation/Foundation.h>

@interface XCSecurityUtil : NSObject
/**
 *  md5加密
 *
 *  @param str 要加密的字符串
 *
 *  @return 32位md5字符串
 */
+ (NSString *)md5:(NSString *)input;
/**
 *  sha1加密
 *
 *  @param input 要加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString *)sha1:(NSString *)input;
+ (NSString *)sha224:(NSString *)input;
+ (NSString *)sha256:(NSString *)input;
+ (NSString *)sha384:(NSString *)input;
+ (NSString *)sha512:(NSString *)input;
/**
 *  DES加密
 *
 *  @param key  密钥
 *  @param data 加密数据
 *
 *  @return 加密后的数据
 */
+ (NSData *)DESEncryptWithKey:(NSString *)key data:(NSData *)data;
/**
 *  DES解密
 *
 *  @param key  密钥
 *  @param data 解密数据
 *
 *  @return 解密后的数据
 */
+ (NSData *)DESDecryptWithKey:(NSString *)key data:(NSData *)data;
/**
 *  AES256加密
 *
 *  @param key  密钥
 *  @param data 加密数据
 *
 *  @return 加密后的数据
 */
+ (NSData *)AES256EncryptWithKey:(NSString *)key data:(NSData *)data;
/**
 *  AES256解密
 *
 *  @param key  密钥
 *  @param data 解密数据
 *
 *  @return 解密后的数据
 */
+ (NSData *)AES256DecryptWithKey:(NSString *)key data:(NSData *)data;
/**
 *  NSData转Base64
 *
 *  @param data
 *
 *  @return
 */
+ (NSString *)base64EncodedStringWithData:(NSData *)data;
/**
 *  Base64转NSData
 *
 *  @param base64String
 *
 *  @return
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)base64String;
/**
 *  NSString转Base64
 *
 *  @param string
 *
 *  @return
 */
+ (NSString *)base64EncodedString:(NSString *)string;
/**
 *  Base64转NSString
 *
 *  @param base64String base64字符串
 *
 *  @return
 */
+ (NSString *)stringWithBase64Encoded:(NSString *)base64String;
/**
 *  生成32位UUID,不带'-'
 *
 *  @return 32位UUID
 */
+ (NSString *)createUUID;

@end
