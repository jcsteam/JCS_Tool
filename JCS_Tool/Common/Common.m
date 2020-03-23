//
//  Common.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/14.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "Common.h"
#import "Category.h"

static NSArray *_imports = nil;

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
+ (NSString *)fullTypeString:(NSString*)typeAlias {
    NSString *type = [[self propertyTypeMap] valueForKey:typeAlias];
    if([type isEqualToString:@"NSString"]) { return @"NSString *";}
    if([type isEqualToString:@"NSMutableString"]) { return @"NSMutableString *";}
    else if([type isEqualToString:@"NSArray"]) { return @"NSArray *";}
    else if([type isEqualToString:@"NSMutableArray"]) { return @"NSMutableArray *";}
    else if([type isEqualToString:@"NSArray"]) { return @"NSArray *";}
    else if([type isEqualToString:@"NSMutableDictionary"]) { return @"NSMutableDictionary *";}
    else if([type isEqualToString:@"NSInteger"]
            || [type isEqualToString:@"CGFloat"]
            || [type isEqualToString:@"double"]
            || [type isEqualToString:@"BOOL"]
            || [type isEqualToString:@"double"]) { return type;}
    return [NSString stringWithFormat:@"%@ *",typeAlias];
}

/// 获取类型部分修饰符
+ (NSString *)modifierString:(NSString*)typeAlias {
    NSString *type = [[self propertyTypeMap] valueForKey:typeAlias];
    if([type isEqualToString:@"NSString"]
       || [type isEqualToString:@"NSMutableString"]
       || [type isEqualToString:@"NSArray"]
       || [type isEqualToString:@"NSMutableArray"]
       || [type isEqualToString:@"NSArray"]
       || [type isEqualToString:@"NSMutableDictionary"]) { return @"strong";}
    else if([type isEqualToString:@"NSInteger"]
            || [type isEqualToString:@"CGFloat"]
            || [type isEqualToString:@"double"]
            || [type isEqualToString:@"BOOL"]
            || [type isEqualToString:@"double"]) { return @"assign";}
    
    return @"strong";
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

/// 配置import信息
+ (void)configImports:(NSArray*)imports {
    _imports = imports;
}
/// 拼接import新
+ (void)imports:(NSMutableString*)stringBuilder {
    if(!_imports){
        return;
    }
    //#import 导入
    for (NSString *importInfo in _imports) {
        if(importInfo.jcs_isValid){
            [stringBuilder appendFormat:@"%@\n",importInfo];
        }
    }
}

@end
