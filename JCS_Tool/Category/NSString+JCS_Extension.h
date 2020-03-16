//
//  NSString+JCS_Extension.h
//  AFNetworking
//
//  Created by 永平 on 2020/1/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JCS_Extension)

/**
 字符串是否有效
 */
@property (nonatomic, assign) BOOL jcs_isValid;
@property (nonatomic, assign) BOOL jcs_isBlank;

+ (BOOL)jcs_isValid:(NSString *)sender;
+ (BOOL)jcs_isBlank:(NSString*)sender;

- (NSString *)jcs_trimWhitespace;
- (NSString*)jcs_catpureUpper;

@end

NS_ASSUME_NONNULL_END
