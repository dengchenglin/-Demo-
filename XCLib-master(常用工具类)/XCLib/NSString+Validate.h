

#import <Foundation/Foundation.h>

@interface NSString (Validate)
/**
 *  是否为空
 *
 *  @return
 */
- (BOOL)isEmpty;
/**
 *  长度位于min到max之间
 *
 *  @param min
 *  @param max
 *
 *  @return
 */
- (BOOL)betweenWith:(int)min and:(int)max;
/**
 *  必须大于
 *
 *  @param length
 *
 *  @return
 */
- (BOOL)hasGreaterThanLength:(int)length;
/**
 *  等于长度
 *
 *  @param length
 *
 *  @return
 */
- (BOOL)equalLength:(int)length;
/**
 *  是否大于长度
 *
 *  @param number
 *
 *  @return
 */
- (BOOL)isGreaterThanNumber:(double)number;
/**
 *  是否小于长度
 *
 *  @param number
 *
 *  @return
 */
- (BOOL)isLessThanNumber:(double)number;
/**
 *  验证车牌号
 *
 *  @return
 */
- (BOOL)isEqualToCardNumber;
/**
 *  验证邮政编码
 *
 *  @return
 */
- (BOOL)isEqualToPostalCode;
/**
 *  验证IP
 *
 *  @return
 */
- (BOOL)isEqualToIP;
/**
 *  验证工商税号
 *
 *  @return 
 */
- (BOOL)isEqualToTaxNumber;
/**
 *  是否是数字(不区分正负数)
 *
 *  @return
 */
- (BOOL)isEqualToNumber;
/**
 *  是否是小数(不区分正负数)
 *
 *  @return
 */
- (BOOL)isEqualToDecimal;
/**
 *  是否是11位手机号
 *
 *  @return
 */
- (BOOL)isEqualToPhone;
/**
 *  是否是国内电话号码,匹配形式如xxxx-xxxxxxx(xxxxxxxx)或xxx-xxxxxxxx
 *
 *  @return
 */
- (BOOL)isEqualToTelPhone;
/**
 *  是否是邮箱地址
 *
 *  @return
 */
- (BOOL)isEqualToEmail;
/**
 *  是否是URl
 *
 *  @return
 */
- (BOOL)isEqualToURL;
/**
 *  是否是中文名称
 *
 *  @return
 */
- (BOOL)isEqualToCNName;
/**
 *  是否是15位或18位身份证号码
 *
 *  @return
 */
- (BOOL)isEqualToIdentity;
/**
 *  匹配正则
 *
 *  @param regex 正则表达式
 *
 *  @return
 */
- (BOOL)isEqualToRegex:(NSString *)regex;
@end
