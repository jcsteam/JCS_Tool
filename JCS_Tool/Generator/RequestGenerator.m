//
//  RequestGenerator.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/17.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "RequestGenerator.h"
#import "RequestInfo.h"
#import "Common.h"
#import "Category.h"
#import "RequestParser.h"
#import "MessageParser.h"

@implementation RequestGenerator

+ (void)generateRequests:(NSString*)source configInfo:(ConfigInfo*)configInfo outputPath:(NSString*)outputPath {
    NSMutableString *stringBuilderH = [NSMutableString string]; //Model H String
    NSMutableString *stringBuilderM = [NSMutableString string]; //Model M String
    NSString *filenameH = [NSString stringWithFormat:@"%@Request.h",configInfo.prefix];
    NSString *filenameM = [NSString stringWithFormat:@"%@Request.m",configInfo.prefix];
    //requests
    NSArray *requests = [RequestParser parseRequest:source configInfo:configInfo];
    if(!(requests && requests.count > 0)){
        return;
    }
    //生成
    [self generateContentH:requests config:configInfo filename:filenameH stringBuilder:stringBuilderH];
    [self generateContentM:requests config:configInfo filenameH:filenameH filenameM:filenameM stringBuilder:stringBuilderM];
    //写入文件
    [Common writeToFile:filenameH outputPath:outputPath content:stringBuilderH];
    [Common writeToFile:filenameM outputPath:outputPath content:stringBuilderM];
}

+ (void)generateContentH:(NSArray*)models
                config:(ConfigInfo*)config
                filename:(NSString*)filename
         stringBuilder:(NSMutableString*)stringBuilder {
    //版权信息
    [Common copyRight:filename projectName:filename author:@"" stringBuilder:stringBuilder];
    //引入#import
    [stringBuilder appendString:@"#import <UIKit/UIKit.h>\n"];
    [stringBuilder appendFormat:@"#import \"%@.h\"\n",config.responseModel];
    [stringBuilder appendFormat:@"#import \"%@Model.h\"\n\n",config.prefix];
    //@interface
    [stringBuilder appendFormat:@"@interface %@Request : NSObject\n\n",config.prefix];
    
    for (RequestInfo *request in models) {
        if(request.comment.jcs_isValid){
            [stringBuilder appendString:@"/**\n"];
            [stringBuilder appendFormat:@"  %@\n",request.comment];
            [stringBuilder appendString:@" */\n"];
        }
        [stringBuilder appendFormat:@"- (void)request%@WithHub:(BOOL)hub params:(NSDictionary *)params completion:(void(^)(%@ *result,%@,NSDictionary *originResponse))completion;\n",request.name.jcs_catpureUpper,config.responseModel,[self getDataClass:request.dataClass]];
    }
    
    [stringBuilder appendString:@"\n@end"];
}

+ (void)generateContentM:(NSArray*)models
                config:(ConfigInfo*)config
                  filenameH:(NSString*)filenameH filenameM:(NSString*)filenameM
         stringBuilder:(NSMutableString*)stringBuilder {
    //版权信息
    [Common copyRight:filenameM projectName:filenameM author:@"" stringBuilder:stringBuilder];
    //引入#import
    [stringBuilder appendString:@"#import <UIKit/UIKit.h>\n"];
    [stringBuilder appendFormat:@"#import \"%@Request.h\"\n\n",config.prefix];
    //@interface
    [stringBuilder appendFormat:@"@implementation %@Request : NSObject\n",config.prefix];
    
//    for (RequestInfo *request in requests) {
//
//    }
    
    [stringBuilder appendString:@"@end"];
}

+ (NSString*)getDataClass:(NSString*)type {
    //nil 或 null 则默认NSDictionary类型
    if([type isEqualToString:@"nil"] || [type isEqualToString:@"null"]) {
        return @"NSDictionary *";
    }
    
    NSString *originType = type;
    NSString *limitType = nil; //泛型类
    NSString *realType = nil; //真实类型
    NSString *realLimitType = nil; //泛型真实类型
    
    if([originType containsString:@"<"] && [originType containsString:@">"]){ //泛型
        NSInteger start = [originType rangeOfString:@"<"].location;
        NSInteger end = [originType rangeOfString:@">"].location;
        limitType = [originType substringWithRange:NSMakeRange(start+1, end - start-1)];
        originType = [originType substringToIndex:start];
        NSLog(@"");
    }
    //去空格
    originType = [originType jcs_trimWhitespace];
    limitType = [limitType jcs_trimWhitespace];
    
    //基础类型
    realType = [[Common propertyTypeMap] valueForKey:originType];
    //Model类型
    if(!realType.jcs_isValid && [MessageParser propertyIsMessage:originType]){
        realType = [MessageParser transPropertyType:originType];
    }
    
    //基础类型
    realLimitType = [[Common propertyTypeMap] valueForKey:limitType];
    //Model类型
    if(!realLimitType.jcs_isValid && [MessageParser propertyIsMessage:limitType]){
        realLimitType = [MessageParser transPropertyType:limitType];
    }
    
    if(realType.jcs_isValid && realLimitType.jcs_isValid){
        return [NSString stringWithFormat:@"%@<%@ *> *",realType,realLimitType];
    } else if(realType.jcs_isValid){
        return [NSString stringWithFormat:@"%@ *",realType];
    }
    
    return [NSString stringWithFormat:@"%@ *",type];
}
@end
