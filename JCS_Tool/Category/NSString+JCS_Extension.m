//
//  NSString+JCS_Extension.m
//  AFNetworking
//
//  Created by 永平 on 2020/1/21.
//

#import "NSString+JCS_Extension.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#import "sys/utsname.h"

@implementation NSString (JCS_Extension)

@dynamic jcs_isValid;
@dynamic jcs_isBlank;

#pragma mark - 共有 Class 方法

///判断字符串是否为空
+ (BOOL)jcs_isValid:(NSString *)sender {
    return ![NSString jcs_isBlank:sender];
}

///判断字符串是否为空
+ (BOOL)jcs_isBlank:(NSString*)sender{
    if (sender == nil) {
        return YES;
    } else if (sender == NULL) {
        return YES;
    } else if ([sender isKindOfClass:[NSNull class]]) {
        return YES;
    } else if (![sender isKindOfClass:[NSString class]]) {
        return YES;
    } else if ([[sender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    } else if ([sender isEqualToString:@"(null)"]) {
        return YES;
    } else if ([[sender jcs_trimWhitespace] isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

#pragma mark - 共有 Insance 方法

- (BOOL)jcs_isValid{
    return [NSString jcs_isValid:self];
}
- (BOOL)jcs_isBlank {
    return [NSString jcs_isBlank:self];
}

- (NSString*)jcs_catpureUpper {
    NSString *firstChar = [self substringToIndex:1];
    NSString *lastChars = [self substringFromIndex:1];
    return [NSString stringWithFormat:@"%@%@",firstChar.uppercaseString,lastChars];
}

/**
 去掉字符串 空格
 */
- (NSString *)jcs_trimWhitespace {
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}

@end
