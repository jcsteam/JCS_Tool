//
//  JCS_Request.m
//  JCS_Test
//
//  Created by 永平 on 2020/3/17.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "JCS_Request.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define kBaseUrl @"https://api.jiakeniu.com/"

@implementation JCS_Request

+ (instancetype)sharedInstance {
    static JCS_Request *_request;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _request = [self createInstance];
    });
    return _request;
}

+ (instancetype)createInstance {
    JCS_Request *instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
    instance.requestSerializer.timeoutInterval = 30;
    instance.requestSerializer = [AFJSONRequestSerializer serializer];
    instance.responseSerializer = [AFJSONResponseSerializer serializer];
    instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", nil];
    return instance;
}

/// 参数加密
+ (NSDictionary*)preprocessParams:(NSDictionary*)params {
    return params;
}

/// 处理返回值
+ (id)dataInResponse:(NSDictionary*)response url:(NSString*)url requestParams:(NSDictionary*)requestParams{
    return [response valueForKey:@"data"];
}
/// 请求错误
+ (void)errorRequest:(NSError*)error url:(NSString*)url requestParams:(NSDictionary*)requestParams {
    
}

+ (void)showQueryHub {
    [SVProgressHUD showWithStatus:@"正在加载..."];
}
+ (void)showRequestErrorHub:(NSError*)error {
    if (error && error.userInfo) {
        NSString *tipStr = [[NSString alloc] init];
        if ([error.userInfo objectForKey:NSLocalizedDescriptionKey]) {
            tipStr = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
        }else{
            tipStr = [NSString stringWithFormat:@"ErrorCode%ld", (long)error.code];
        }
        [SVProgressHUD showErrorWithStatus:tipStr];
    }
}
+ (void)hideRequestHub {
    [SVProgressHUD dismiss];
}

@end
