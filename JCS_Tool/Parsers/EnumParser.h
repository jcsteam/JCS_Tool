//
//  EnumParser.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface EnumParser : NSObject

+ (NSArray*)parseEnumMap:(NSString*)sourceContent configInfo:(ConfigInfo*)configInfo;

/// 属性是否是枚举
+ (BOOL)propertyIsEnum:(NSString*)type;
/// 转换属性类型 "Sex -> JCS_Sex"
+ (NSString*)transPropertyType:(NSString*)type;
/// 转换属性类型 "male -> JCS_SexMale"
+ (NSString*)transPropertyValue:(NSString*)value;

@end

NS_ASSUME_NONNULL_END
