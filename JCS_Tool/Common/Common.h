//
//  Common.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/14.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Common : NSObject

/// 版权信息
+ (void)copyRight:(NSString*)fileName projectName:(NSString*)projectName author:(NSString*)author stringBuilder:(NSMutableString*)stringBuilder;
/// message 备注
+ (void)messageComment:(NSString*)comment stringBuilder:(NSMutableString*)stringBuilder;
/// 写入文件
+ (void)writeToFile:(NSString*)filename outputPath:(NSString*)outputPath content:(NSString*)content;

/// 类型是否是字典
+ (BOOL)typeIsDictionary:(NSString*)type;
/// 类型是否是数字
+ (BOOL)typeIsArray:(NSString*)type;

/// 获取类型部分字符串
+ (NSString *)typeComponent:(NSString*)typeString;
///propertyTypeMap
+ (NSDictionary*)propertyTypeMap;

@end

NS_ASSUME_NONNULL_END
