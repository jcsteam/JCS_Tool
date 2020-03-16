//
//  MessageParser.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageParser : NSObject

+ (NSArray*)parseModelMap:(NSString*)sourceContent configInfo:(ConfigInfo*)configInfo;

/// 属性是否是Message类型
+ (BOOL)propertyIsMessage:(NSString*)type;
/// 转换属性类型 "Person -> JCS_Person"
+ (NSString*)transPropertyType:(NSString*)type;

@end

NS_ASSUME_NONNULL_END
