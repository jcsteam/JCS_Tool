//
//  JCS_Request.h
//  JCS_Test
//
//  Created by 永平 on 2020/3/17.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCS_Request : AFHTTPSessionManager

+ (instancetype)sharedInstance;

+ (instancetype)sharedInstance;

/// 获取BaseUrl
+ (NSString*)getBaseUrl;
/// 对参数进行预处理，如加密、添加公共参数等，无特殊操作则直接 return params;
+ (NSDictionary*)preprocessParams:(NSDictionary*)params;
/// 返回响应中的data属性
/// 例如服务端响应内容如下
/// {
///     code:10000,
///     msg:"成功",
///     success:true,
///     data:{}
/// }
/// 则在该方法中 return [requestParams valueForKey:@"data"];
+ (id)dataInResponse:(NSDictionary*)response url:(NSString*)url requestParams:(NSDictionary*)requestParams;
/// 请求错误时，该方法会被调用，自行处理错误逻辑
+ (void)errorRequest:(NSError*)error url:(NSString*)url requestParams:(NSDictionary*)requestParams;
/// 菊花显示与隐藏
+ (void)showQueryHub;
+ (void)showRequestErrorHub:(NSError*)error;
+ (void)hideRequestHub;


@end

NS_ASSUME_NONNULL_END
