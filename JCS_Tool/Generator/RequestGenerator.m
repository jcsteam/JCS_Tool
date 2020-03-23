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

#pragma mark - 生成 H M

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
    [Common imports:stringBuilder];
    [stringBuilder appendString:@" \n\n"];
    [stringBuilder appendFormat:@"#import \"%@.h\"\n",config.responseModel];
    [stringBuilder appendFormat:@"#import \"%@Model.h\"\n\n",config.prefix];
    
    //@interface
    [stringBuilder appendFormat:@"@interface %@Request : NSObject\n\n",config.prefix];
    
    for (RequestInfo *request in models) {
        printf("🍆 正在生成 接口 %s\n",[request.name cStringUsingEncoding:NSUTF8StringEncoding]);
        
        [stringBuilder appendFormat:@"\n\n#pragma mark - %@\n",request.name];
        
        //
        // 参数：hub、params、success、failure
        // 返回：void
        //
        [self requestMethodComment1:request.comment stringBuilder:stringBuilder];
        [stringBuilder appendFormat:@"%@;\n",[self requestMethodSignature1:request.name.jcs_catpureUpper responseModel:config.responseModel dataClass:[self parserDataClass:request]]];
        
        //
        // 参数：hub、自定义参数数组、success、failure
        // 返回：void
        //
        [self requestMethodComment1_params:request.comment params:request.params stringBuilder:stringBuilder];
        [stringBuilder appendFormat:@"%@;\n",[self requestMethodSignature1_params:request.name.jcs_catpureUpper responseModel:config.responseModel dataClass:[self parserDataClass:request] params:request.params]];
        
        if(config.signalRequest){
            //
            // 参数：hub、params
            // 返回：RACSignal
            //
            [self requestMethodComment2:request.comment stringBuilder:stringBuilder];
            [stringBuilder appendFormat:@"%@;\n",[self requestMethodSignature2:request.name.jcs_catpureUpper]];
            
            //
            // 参数：hub、[自定义参数]
            // 返回：RACSignal
            //
            [self requestMethodComment2_params:request.comment params:request.params stringBuilder:stringBuilder];
            [stringBuilder appendFormat:@"%@;\n",[self requestMethodSignature2_params:request.name.jcs_catpureUpper params:request.params]];
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
        
        [stringBuilder appendFormat:@"\n\n#pragma mark - %@\n",request.name];
        
        //
        // 参数：hub、params、success、failure
        // 返回：void
        //
        [self requestMethodComment1:request.comment stringBuilder:stringBuilder];
        [stringBuilder appendFormat:@"%@ { \n",[self requestMethodSignature1:request.name.jcs_catpureUpper responseModel:config.responseModel dataClass:[self parserDataClass:request]]];
        
        [stringBuilder appendFormat:@"    if(hub){ \n"];
        [stringBuilder appendFormat:@"        dispatch_async(dispatch_get_main_queue(), ^{  \n"];
        [stringBuilder appendFormat:@"            [JCS_Request showQueryHub]; \n"];
        [stringBuilder appendFormat:@"        }); \n"];
        [stringBuilder appendFormat:@"    } \n"];
        
        [stringBuilder appendFormat:@"    //参数预处理 \n"];
        [stringBuilder appendFormat:@"    NSDictionary *processedParams = [JCS_Request preprocessParams:params]; \n"];
        
        [stringBuilder appendFormat:@"    NSString *url = nil; \n"];
        [@"" hasPrefix:@""];
        [stringBuilder appendFormat:@"    if([@\"%@\" hasPrefix:@\"/\"] || [[JCS_Request getBaseUrl] hasSuffix:@\"/\"]){ \n",request.url];
        [stringBuilder appendFormat:@"        url = [NSString stringWithFormat:@\"%@%@\",[JCS_Request getBaseUrl]]; \n",@"%@",request.url];
        [stringBuilder appendFormat:@"    } else { \n"];
        [stringBuilder appendFormat:@"        url = [NSString stringWithFormat:@\"%@/%@\",[JCS_Request getBaseUrl]]; \n",@"%@",request.url];
        [stringBuilder appendFormat:@"    } \n"];
        
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
        
        
        //
        // 参数：hub、自定义参数数组、success、failure
        // 返回：void
        //
        [self requestMethodComment1_params:request.comment params:request.params stringBuilder:stringBuilder];
        [stringBuilder appendFormat:@"%@ {\n",[self requestMethodSignature1_params:request.name.jcs_catpureUpper responseModel:config.responseModel dataClass:[self parserDataClass:request] params:request.params]];
        // params 拼接字典
        [self params2Dictionary:request.params stringBuilder:stringBuilder];
        [stringBuilder appendFormat:@"    [self request%@WithHub:hub params:params success:success failure:failure];\n",request.name.jcs_catpureUpper];
        [stringBuilder appendString:@"} \n\n"];
        
        /// 生成信号接口
        if(config.signalRequest){
            
            //
            // 参数：hub、params
            // 返回：RACSignal
            //
            [self requestMethodComment2:request.comment stringBuilder:stringBuilder];
            
            [stringBuilder appendFormat:@"%@ {\n",[self requestMethodSignature2:request.name.jcs_catpureUpper]];
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
            
            //
            // 参数：hub、[自定义参数]
            // 返回：RACSignal
            //
            [self requestMethodComment2_params:request.comment params:request.params stringBuilder:stringBuilder];
            
            // 方法调动时参数部分拼接
            NSMutableString *callParamsString = [NSMutableString string];
            for (MessageProperty *property in request.params) {
                [callParamsString appendFormat:@"%@:%@ ",property.name,property.name];
            }
            
            [stringBuilder appendFormat:@"%@ {\n",[self requestMethodSignature2_params:request.name.jcs_catpureUpper params:request.params]];
            //params 转换为NSDictionary
            [self params2Dictionary:request.params stringBuilder:stringBuilder];
            [stringBuilder appendFormat:@"    return [self request%@WithHub:hub params:params]; \n",request.name.jcs_catpureUpper];
            [stringBuilder appendString:@"} \n"];
        }
    }
    
    [stringBuilder appendString:@"@end"];
}

#pragma mark - 方法注释

///注释：hub、params、success、failure
+ (void)requestMethodComment1:(NSString*)comment stringBuilder:(NSMutableString*)stringBuilder{
    [stringBuilder appendString:@"\n\n/**\n"];
    [stringBuilder appendFormat:@"  %@\n\n",comment?:@""];
    [stringBuilder appendFormat:@"  @params hub 是否转菊花 \n"];
    [stringBuilder appendFormat:@"  @params params 请求参数 \n"];
    [stringBuilder appendFormat:@"  @params success 成功回调 \n"];
    [stringBuilder appendFormat:@"  @params failure 失败回调 \n"];
    [stringBuilder appendString:@" */\n"];
}
///注释：hub、自定义参数、success、failure
+ (void)requestMethodComment1_params:(NSString*)comment
                              params:(NSArray<MessageProperty*>*)params
                       stringBuilder:(NSMutableString*)stringBuilder{
    [stringBuilder appendString:@"\n\n/**\n"];
    [stringBuilder appendFormat:@"  %@\n\n",comment?:@""];
    [stringBuilder appendFormat:@"  @params hub 是否转菊花 \n"];
    for (MessageProperty *property in params) {
        [stringBuilder appendFormat:@"  @params %@ %@ \n",property.name,property.comment];
    }
    [stringBuilder appendFormat:@"  @params success 成功回调 \n"];
    [stringBuilder appendFormat:@"  @params failure 失败回调 \n"];
    [stringBuilder appendString:@" */\n"];
}

///注释：hub、params
+ (void)requestMethodComment2:(NSString*)comment stringBuilder:(NSMutableString*)stringBuilder{
    [stringBuilder appendString:@"\n\n/**\n"];
    [stringBuilder appendFormat:@"  %@\n\n",comment?:@""];
    [stringBuilder appendFormat:@"  @params hub 是否转菊花 \n"];
    [stringBuilder appendFormat:@"  @params params 请求参数 \n"];
    [stringBuilder appendFormat:@"  @return RACSignal \n"];
    [stringBuilder appendString:@" */\n"];
}
///注释：hub、自定义参数
+ (void)requestMethodComment2_params:(NSString*)comment
                              params:(NSArray<MessageProperty*>*)params
                       stringBuilder:(NSMutableString*)stringBuilder{
    [stringBuilder appendString:@"\n\n/**\n"];
    [stringBuilder appendFormat:@"  %@\n\n",comment?:@""];
    [stringBuilder appendFormat:@"  @params hub 是否转菊花 \n"];
    for (MessageProperty *property in params) {
        [stringBuilder appendFormat:@"  @params %@ %@ \n",property.name,property.comment];
    }
    [stringBuilder appendFormat:@"  @return RACSignal \n"];
    [stringBuilder appendString:@" */\n"];
}

#pragma mark - 方法签名

/**
 获取参数签名：void requestXXXWithHub:params:success:failure:
 
 @params name 接口名称
 @params responseModel response解析类型
 @params dataClass success中data类型
 */
+ (NSString*)requestMethodSignature1:(NSString*)name responseModel:(NSString*)responseModel dataClass:(NSString*)dataClass{
    return [NSString stringWithFormat:@"+ (void)request%@WithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(%@ *result,%@ *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure",name,responseModel,dataClass];
}
+ (NSString*)requestMethodSignature1_params:(NSString*)name responseModel:(NSString*)responseModel dataClass:(NSString*)dataClass params:(NSArray<MessageProperty*>*)params{
    
    NSMutableString *paramsString = [NSMutableString string];
    for (MessageProperty *param in params) {
        [paramsString appendFormat:@"%@:(%@)%@ ",param.name,param.fullTypeString,param.name];
    }
    
    return [NSString stringWithFormat:@"+ (void)request%@WithHub:(BOOL)hub %@ success:(void(^)(%@ *result,%@ *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure",name,paramsString,responseModel,dataClass];
}

/**
获取参数签名：RACSignal* requestXXXWithHub:params:
*/
+ (NSString*)requestMethodSignature2:(NSString*)name{
    return [NSString stringWithFormat:@"+ (RACSignal*)request%@WithHub:(BOOL)hub params:(NSDictionary *)params",name];
}
+ (NSString*)requestMethodSignature2_params:(NSString*)name params:(NSArray<MessageProperty*>*)params{
    NSMutableString *paramsString = [NSMutableString string];
    for (MessageProperty *param in params) {
        [paramsString appendFormat:@"%@:(%@)%@ ",param.name,param.fullTypeString,param.name];
    }
    
    return [NSString stringWithFormat:@"+ (RACSignal*)request%@WithHub:(BOOL)hub %@",name,paramsString];
}

#pragma mark - 私有方法

/// 参数拼接为字典
+ (void)params2Dictionary:(NSArray<MessageProperty*> *)params stringBuilder:(NSMutableString*)stringBuilder {
    [stringBuilder appendFormat:@"    NSMutableDictionary *params = [NSMutableDictionary dictionary];\n"];
    for (MessageProperty *property in params) {
        if(![property.fullTypeString containsString:@"*"]){ //带星号表示基础类型，需要包装
            [stringBuilder appendFormat:@"    params[@\"%@\"] = @(%@);\n",property.name,property.name];
        } else {
            [stringBuilder appendFormat:@"    params[@\"%@\"] = %@;\n",property.name,property.name];
        }
    }
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
