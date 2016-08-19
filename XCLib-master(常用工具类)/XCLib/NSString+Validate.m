
#import "NSString+Validate.h"

@implementation NSString (Validate)

- (BOOL)isEmpty
{
    if (self.length < 1) {
        return NO;
    }
    return ([self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length < 1);
}

- (BOOL)betweenWith:(int)min and:(int)max
{
    if ([self isEmpty]) {
        return NO;
    }
    return (self.length >= min && self.length < max);
}

- (BOOL)hasGreaterThanLength:(int)length
{
    if ([self isEmpty]) {
        return NO;
    }
    return self.length > length;
}

- (BOOL)equalLength:(int)length
{
    if ([self isEmpty]) {
        return NO;
    }
    return self.length == length;
}

- (BOOL)isGreaterThanNumber:(double)number
{
    return [self doubleValue] > number;
}

- (BOOL)isLessThanNumber:(double)number
{
    return [self doubleValue] < number;
}

- (BOOL)isEqualToCardNumber
{
    return [self validateString:@"^[A-Za-z]{1}[A-Za-z_0-9]{5}$"];
}

- (BOOL)isEqualToPostalCode
{
    return [self validateString:@"^[0-8]\\d{5}(?!\\d)$"];
}

- (BOOL)isEqualToIP
{
    BOOL rc = [self validateString:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    if (rc) {
        NSArray *componds = [self componentsSeparatedByString:@","];
        BOOL v = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                v = NO;
                break;
            }
        }
        return v;
    }
    return NO;
}

- (BOOL)isEqualToTaxNumber
{
    return [self validateString:@"[0-9]\\d{13}([0-9]|X)$"];
}

- (BOOL)isEqualToNumber
{
    return [self validateString:@"\\d+"];
}

- (BOOL)isEqualToDecimal
{
    return [self validateString:@"\\d+(\\.\\d+)?"];
}

- (BOOL)isEqualToPhone
{
    return [self validateString:@"1[3|4|5|7|8][0-9]{9}"];
}

- (BOOL)isEqualToTelPhone
{
    return [self validateString:@"\\d{3}(-)?\\d{8}|\\d{4}(-)?\\d{7,8}"];
}

- (BOOL)isEqualToEmail
{
    return [self validateString:@"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"];
}

- (BOOL)isEqualToURL
{
    return [self validateString:@"[http|https]+://[0-9a-zA-Z]+[0-9a-zA-Z.-]*.[a-zA-Z]{2,4}/?[^\\s]*"];
}

- (BOOL)isEqualToCNName
{
    return [self validateString:@"[\\u4E00-\\u9FA5]{2,5}(?:·[\\u4E00-\\u9FA5]{2,5})*"];
}

- (BOOL)isEqualToIdentity
{
    return [self validateString:@"\\d{15}|\\d{18}|\\d{17}[x|X]"];
}

- (BOOL)isEqualToRegex:(NSString *)regex
{
    return [self validateString:regex];
}

- (BOOL)validateString:(NSString *)regex
{
    if ([self isEmpty]) {
        return NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result =  [predicate evaluateWithObject:self];
    return result;
}
@end