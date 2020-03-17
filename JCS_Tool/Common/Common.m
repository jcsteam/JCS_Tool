//
//  Common.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/14.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "Common.h"
#import "Category.h"

@implementation Common

/// 版权信息
+ (void)copyRight:(NSString*)fileName projectName:(NSString*)projectName author:(NSString*)author stringBuilder:(NSMutableString*)stringBuilder{
    
    NSString *year = @"2020/3/14";
    NSString *date = @"2020";
    if(author.length == 0){
        author = @"JackCat";
    }
    
    [stringBuilder appendString:@"//\n"];
    [stringBuilder appendFormat:@"//  %@ \n",fileName];
    [stringBuilder appendFormat:@"//  %@ \n",projectName];
    [stringBuilder appendString:@"//\n"];
    [stringBuilder appendFormat:@"//  Created by %@ on %@.\n",author,date];
    [stringBuilder appendFormat:@"//  Copyright © %@ %@. All rights reserved.\n",year,author];
    [stringBuilder appendString:@"//\n\n"];

}
/// message 备注
+ (void)messageComment:(NSString*)comment stringBuilder:(NSMutableString*)stringBuilder {
    if(comment.jcs_isValid){
        [stringBuilder appendString:@"/**\n"];
        [stringBuilder appendFormat:@"  %@\n",comment];
        [stringBuilder appendString:@" */\n"];
    }
}
/// 写入文件
+ (void)writeToFile:(NSString*)filename outputPath:(NSString*)outputPath content:(NSString*)content {
    filename = [outputPath stringByAppendingPathComponent:filename];
    NSError *error = nil;
    BOOL success = [content writeToFile:filename atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(!success || error){
        NSLog(@"文件 %@ 写入失败 %@",filename.lastPathComponent,error);
    }
}

/// 类型是否是字典
+ (BOOL)typeIsDictionary:(NSString*)type {
    return !type.jcs_isValid || [type isEqualToString:@"dict"] || [type isEqualToString:@"mdict"] || [type isEqualToString:@"nil"] || [type isEqualToString:@"null"];
}
/// 类型是否是数字
+ (BOOL)typeIsArray:(NSString*)type {
    return [type isEqualToString:@"list"] || [type isEqualToString:@"mlist"];
}

/// 获取类型部分字符串
+ (NSString *)typeComponent:(NSString*)typeString {
    NSString *type = [[self propertyTypeMap] valueForKey:typeString];
    if([type isEqualToString:@"NSString"]) { return @"NSString *";}
    if([type isEqualToString:@"NSMutableString"]) { return @"NSMutableString *";}
    else if([type isEqualToString:@"NSArray"]) { return @"NSArray *";}
    else if([type isEqualToString:@"NSMutableArray"]) { return @"NSMutableArray *";}
    else if([type isEqualToString:@"NSArray"]) { return @"NSArray *";}
    else if([type isEqualToString:@"NSMutableDictionary"]) { return @"NSMutableDictionary *";}
    else if([type isEqualToString:@"NSInteger"]) { return @"NSInteger ";}
    else if([type isEqualToString:@"CGFloat"]) { return @"CGFloat ";}
    else if([type isEqualToString:@"double"]) { return @"double ";}
    else if([type isEqualToString:@"BOOL"]) { return @"BOOL ";}
    else if([type isEqualToString:@"double"]) { return @"double ";}
    return @"";
}
///propertyTypeMap
+ (NSDictionary*)propertyTypeMap {
    static NSDictionary *_propertyTypeMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _propertyTypeMap = @{
            @"string":@"NSString",
            @"int":@"NSInteger",
            @"long":@"NSInteger",
            @"float":@"CGFloat",
            @"double":@"double",
            @"bool":@"BOOL",
            @"list":@"NSMutableArray",
            @"mlist":@"NSMutableArray",
            @"dict":@"NSMutableDictionary",
            @"mdict":@"NSMutableDictionary",
        };
    });
    return _propertyTypeMap;
}

@end
