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

/// 对参数进行预处理
+ (NSDictionary*)preprocessParams:(NSDictionary*)params;
/// 返回data属性
+ (id)dataInResponse:(NSDictionary*)response url:(NSString*)url requestParams:(NSDictionary*)requestParams;
/// 请求错误
+ (void)errorRequest:(NSError*)error url:(NSString*)url requestParams:(NSDictionary*)requestParams;

+ (void)showQueryHub;
+ (void)showRequestErrorHub:(NSError*)error;
+ (void)hideRequestHub;

@end

NS_ASSUME_NONNULL_END
