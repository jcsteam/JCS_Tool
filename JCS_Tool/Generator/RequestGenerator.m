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
    if(config.signalRequest){
        [stringBuilder appendString:@"#import <ReactiveObjC/ReactiveObjC.h>\n"];
    }
    [stringBuilder appendFormat:@"#import \"%@.h\"\n",config.responseModel];
    [stringBuilder appendFormat:@"#import \"%@Model.h\"\n\n",config.prefix];
    //@interface
    [stringBuilder appendFormat:@"@interface %@Request : NSObject\n\n",config.prefix];
    
    for (RequestInfo *request in models) {
        printf("🍆 正在生成 接口 %s\n",[request.name cStringUsingEncoding:NSUTF8StringEncoding]);
        
        if(request.comment.jcs_isValid){
            [stringBuilder appendString:@"/**\n"];
            [stringBuilder appendFormat:@"  %@\n",request.comment];
            [stringBuilder appendString:@" */\n"];
        }
        
        //requestGetUserInfoWithHub:params:success:failure:
        NSString *signatureOne = [self requestMethodSignatureOne:request.name.jcs_catpureUpper responseModel:config.responseModel dataClass:[self parserDataClass:request]];
        [stringBuilder appendFormat:@"%@;\n",signatureOne];
        
        //requestGetUserInfoWithParams:success:failure:
        NSString *signatureTwo = [self requestMethodSignatureTwo:request.name.jcs_catpureUpper responseModel:config.responseModel dataClass:[self parserDataClass:request]];
        [stringBuilder appendFormat:@"%@;\n",signatureTwo];
        
        if(config.signalRequest){
            //requestGetUserInfoWithHub:params:
            NSString *signatureThree = [self requestMethodSignatureThree:request.name.jcs_catpureUpper];
            [stringBuilder appendFormat:@"%@;\n",signatureThree];
            
            //requestGetUserInfoWithParams:
            NSString *signatureFour = [self requestMethodSignatureFour:request.name.jcs_catpureUpper];
            [stringBuilder appendFormat:@"%@;\n",signatureFour];
        }
        
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
    [stringBuilder appendString:@"#import <MJExtension/MJExtension.h>\n"];
    [stringBuilder appendString:@"#import \"JCS_Request.h\"\n"];
    [stringBuilder appendFormat:@"#import \"%@Request.h\"\n\n",config.prefix];
    //@interface
    [stringBuilder appendFormat:@"@implementation %@Request : NSObject\n",config.prefix];
    
    for (RequestInfo *request in models) {
        if(request.comment.jcs_isValid){
            [stringBuilder appendString:@"/**\n"];
            [stringBuilder appendFormat:@"  %@\n",request.comment];
            [stringBuilder appendString:@" */\n"];
        }
        
        /**
         requestGetUserInfoWithHub:params:completion:
         */
        NSString *signatureOne = [self requestMethodSignatureOne:request.name.jcs_catpureUpper responseModel:config.responseModel dataClass:[self parserDataClass:request]];
        [stringBuilder appendFormat:@"%@ { \n",signatureOne];
        
        [stringBuilder appendFormat:@"    if(hub){ \n"];
        [stringBuilder appendFormat:@"        dispatch_async(dispatch_get_main_queue(), ^{  \n"];
        [stringBuilder appendFormat:@"            [JCS_Request showQueryHub]; \n"];
        [stringBuilder appendFormat:@"        }); \n"];
        [stringBuilder appendFormat:@"    } \n"];
        
        [stringBuilder appendFormat:@"    //参数预处理 \n"];
        [stringBuilder appendFormat:@"    NSDictionary *processedParams = [JCS_Request preprocessParams:params]; \n"];
        
        [stringBuilder appendFormat:@"    NSString *url = @\"%@\"; \n",request.url];
        [stringBuilder appendFormat:@"    [[JCS_Request sharedInstance] %@:url parameters:processedParams progress:^(NSProgress * _Nonnull uploadProgress) { \n",request.method.uppercaseString];
        [stringBuilder appendFormat:@" \n"];
        [stringBuilder appendFormat:@"    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { \n"];
        
        [stringBuilder appendFormat:@"        if(hub){ \n"];
        [stringBuilder appendFormat:@"            dispatch_async(dispatch_get_main_queue(), ^{  \n"];
        [stringBuilder appendFormat:@"                [JCS_Request hideRequestHub]; \n"];
        [stringBuilder appendFormat:@"            }); \n"];
        [stringBuilder appendFormat:@"        } \n"];
        
        [stringBuilder appendFormat:@"        CommonResponse *result = [CommonResponse mj_objectWithKeyValues:responseObject]; \n"];
        [stringBuilder appendFormat:@"        if(success){ \n"];
        [stringBuilder appendFormat:@"            //获取data数据 \n"];
        [stringBuilder appendFormat:@"            id data = [JCS_Request dataInResponse:responseObject url:url requestParams:processedParams]; \n"];
        
        if([request.dataClass isEqualToString:@"NSDictionary"]
            || [request.dataClass isEqualToString:@"NSMutableDictionary"] ) { //字典类型
            [stringBuilder appendFormat:@"            success(result,data,responseObject); \n"];
            
        } else if([request.dataClass isEqualToString:@"NSArray"]
                  || [request.dataClass isEqualToString:@"NSMutableArray"]){ //数组处理
            if(request.limitClass.jcs_isValid){ //泛型数组
                [stringBuilder appendFormat:@"            if([data isKindOfClass:NSArray.class]){ \n"];
                [stringBuilder appendFormat:@"                NSMutableArray *resultList = [%@ mj_objectArrayWithKeyValuesArray:data]; \n",request.limitClass];
                [stringBuilder appendFormat:@"                success(result,resultList,responseObject); \n"];
                [stringBuilder appendFormat:@"     \n"];
                [stringBuilder appendFormat:@"            } else if([data isKindOfClass:NSDictionary.class]){ \n"];
                [stringBuilder appendFormat:@"                %@ *info = [%@ mj_objectWithKeyValues:data]; \n",request.limitClass,request.limitClass];
                [stringBuilder appendFormat:@"                success(result, @[info].mutableCopy, responseObject); \n"];
                [stringBuilder appendFormat:@"     \n"];
                [stringBuilder appendFormat:@"            } else { \n"];
                [stringBuilder appendFormat:@"                success(result,data,responseObject); \n"];
                [stringBuilder appendFormat:@"            } \n"];
            
            } else { //非泛型
                [stringBuilder appendFormat:@"            success(result,data,responseObject); \n"];
                
            }
            
        } else if([MessageParser propertyIsMessage:request.dataClass]) { //模型
            [stringBuilder appendFormat:@"            %@ *info = [%@ mj_objectWithKeyValues:data]; \n",request.dataClass,request.dataClass];
            [stringBuilder appendFormat:@"            success(result, info, responseObject); \n"];
            
        } else { //异常类型
            [stringBuilder appendFormat:@"        success(result,data,responseObject); \n"];
        }
        [stringBuilder appendFormat:@"        } \n"];
        
        [stringBuilder appendFormat:@"    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { \n"];
        [stringBuilder appendFormat:@"        if(hub){ \n"];
        [stringBuilder appendFormat:@"            dispatch_async(dispatch_get_main_queue(), ^{  \n"];
        [stringBuilder appendFormat:@"                [JCS_Request showRequestErrorHub:error]; \n"];
        [stringBuilder appendFormat:@"            }); \n"];
        [stringBuilder appendFormat:@"        } \n"];
        [stringBuilder appendFormat:@"        //处理错误\n"];
        [stringBuilder appendFormat:@"        [JCS_Request errorRequest:error url:url requestParams:params];\n"];
        [stringBuilder appendFormat:@"        if(failure){\n"];
        [stringBuilder appendFormat:@"            failure(error);\n"];
        [stringBuilder appendFormat:@"        }\n"];
        
        [stringBuilder appendFormat:@"    }]; \n"];
        [stringBuilder appendString:@"} \n\n"];
        
        
        //requestGetUserInfoWithParams:completion:
        NSString *signatureTwo = [self requestMethodSignatureTwo:request.name.jcs_catpureUpper responseModel:config.responseModel dataClass:[self parserDataClass:request]];
        [stringBuilder appendFormat:@"%@ { \n",signatureTwo];
        [stringBuilder appendFormat:@"    [self request%@WithHub:NO params:params success:success failure:failure];\n",request.name.jcs_catpureUpper];
        [stringBuilder appendString:@"} \n"];
        
        if(config.signalRequest){
            /**
             requestGetUserInfoWithHub:params:
             */
            NSString *signatureThree = [self requestMethodSignatureThree:request.name.jcs_catpureUpper];
            [stringBuilder appendFormat:@"%@ {\n",signatureThree];
            [stringBuilder appendFormat:@"    @weakify(self); \n"];
            [stringBuilder appendFormat:@"    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { \n"];
            [stringBuilder appendFormat:@"        @strongify(self); \n"];
            [stringBuilder appendFormat:@"        [self request%@WithHub:hub params:params success:^(%@ *result, %@ *data, id originResponse) { \n",request.name.jcs_catpureUpper,config.responseModel,request.dataClass];
            [stringBuilder appendFormat:@"            [subscriber sendNext:@{@\"result\":result, @\"data\":data, @\"originResponse\":originResponse}]; \n"];
            [stringBuilder appendFormat:@"            [subscriber sendCompleted]; \n"];
            [stringBuilder appendFormat:@"        } failure:^(NSError *error) { \n"];
            [stringBuilder appendFormat:@"           [subscriber sendNext:error]; \n"];
            [stringBuilder appendFormat:@"           [subscriber sendCompleted]; \n"];
            [stringBuilder appendFormat:@"       }]; \n"];
            [stringBuilder appendFormat:@"       return nil; \n"];
            [stringBuilder appendFormat:@"    }]; \n"];
            [stringBuilder appendFormat:@"    return [signal replayLazily]; \n"];
            [stringBuilder appendString:@"} \n"];
            
            /**
             requestGetUserInfoWithParams:
             */
            NSString *signatureFour = [self requestMethodSignatureFour:request.name.jcs_catpureUpper];
            [stringBuilder appendFormat:@"%@ {\n",signatureFour];
            [stringBuilder appendFormat:@"    @weakify(self); \n"];
            [stringBuilder appendFormat:@"    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { \n"];
            [stringBuilder appendFormat:@"        @strongify(self); \n"];
            [stringBuilder appendFormat:@"        [self request%@WithParams:params success:^(%@ *result, %@ *data, id originResponse) { \n",request.name.jcs_catpureUpper,config.responseModel,request.dataClass];
            [stringBuilder appendFormat:@"            [subscriber sendNext:@{@\"result\":result, @\"data\":data, @\"originResponse\":originResponse}]; \n"];
            [stringBuilder appendFormat:@"            [subscriber sendCompleted]; \n"];
            [stringBuilder appendFormat:@"        } failure:^(NSError *error) { \n"];
            [stringBuilder appendFormat:@"           [subscriber sendNext:error]; \n"];
            [stringBuilder appendFormat:@"           [subscriber sendCompleted]; \n"];
            [stringBuilder appendFormat:@"       }]; \n"];
            [stringBuilder appendFormat:@"       return nil; \n"];
            [stringBuilder appendFormat:@"    }]; \n"];
            [stringBuilder appendFormat:@"    return [signal replayLazily]; \n"];
            [stringBuilder appendString:@"} \n"];
        }
    }
    
    [stringBuilder appendString:@"@end"];
}

+ (NSString*)requestMethodSignatureOne:(NSString*)name responseModel:(NSString*)responseModel dataClass:(NSString*)dataClass{
    return [NSString stringWithFormat:@"+ (void)request%@WithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(%@ *result,%@ *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure",name,responseModel,dataClass];
}
+ (NSString*)requestMethodSignatureTwo:(NSString*)name responseModel:(NSString*)responseModel dataClass:(NSString*)dataClass{
    return [NSString stringWithFormat:@"+ (void)request%@WithParams:(NSDictionary *)params success:(void(^)(%@ *result,%@ *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure",name,responseModel,dataClass];
}
+ (NSString*)requestMethodSignatureThree:(NSString*)name{
    return [NSString stringWithFormat:@"+ (RACSignal*)request%@WithHub:(BOOL)hub params:(NSDictionary *)params",name];
}
+ (NSString*)requestMethodSignatureFour:(NSString*)name{
    return [NSString stringWithFormat:@"+ (RACSignal*)request%@WithParams:(NSDictionary *)params",name];
}

/// 解析返回值中的data类型
+ (NSString*)parserDataClass:(RequestInfo*)request {
    //nil 或 null 则默认NSDictionary类型
    if([Common typeIsDictionary:request.dataClass]) {
        return @"NSDictionary";
    }
    
    if(request.limitClass.jcs_isValid){
        return [NSString stringWithFormat:@"%@<%@ *>",request.dataClass,request.limitClass];
    }
    return request.dataClass;
}
@end
