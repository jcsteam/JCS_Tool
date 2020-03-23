//
//  HKUserRequest.m 
//  HKUserRequest.m 
//
//  Created by JackCat on 2020.
//  Copyright © 2020/3/14 JackCat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJExtension/MJExtension.h>
#import "JCS_Request.h"
#import "HKUserRequest.h"

@implementation HKUserRequest : NSObject
/**
  获取用户信息接口-Student2
  获取用户信息接口-Student2-2
  获取用户信息接口-Student2-3
 */
+ (void)requestGetBannerListWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,HKUserStudent2 *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    if(hub){ 
        dispatch_async(dispatch_get_main_queue(), ^{  
            [JCS_Request showQueryHub]; 
        }); 
    } 
    //参数预处理 
    NSDictionary *processedParams = [JCS_Request preprocessParams:params]; 
    NSString *url = @"/getBannerList.action"; 
    [[JCS_Request sharedInstance] GET:url parameters:processedParams progress:^(NSProgress * _Nonnull uploadProgress) { 
 
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request hideRequestHub]; 
            }); 
        } 
        CommonResponse *result = [CommonResponse mj_objectWithKeyValues:responseObject]; 
        if(success){ 
            //获取data数据 
            id data = [JCS_Request dataInResponse:responseObject url:url requestParams:processedParams]; 
            HKUserStudent2 *info = [HKUserStudent2 mj_objectWithKeyValues:data]; 
            success(result, info, responseObject); 
        } 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request showRequestErrorHub:error]; 
            }); 
        } 
        //处理错误
        [JCS_Request errorRequest:error url:url requestParams:params];
        if(failure){
            failure(error);
        }
    }]; 
} 

+ (void)requestGetBannerListWithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,HKUserStudent2 *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    [self requestGetBannerListWithHub:NO params:params success:success failure:failure];
} 
+ (RACSignal*)requestGetBannerListWithHub:(BOOL)hub params:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetBannerListWithHub:hub params:params success:^(CommonResponse *result, HKUserStudent2 *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
+ (RACSignal*)requestGetBannerListWithParams:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetBannerListWithParams:params success:^(CommonResponse *result, HKUserStudent2 *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
/**
  获取用户信息接口-dict
 */
+ (void)requestGetBannerList2WithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSDictionary *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    if(hub){ 
        dispatch_async(dispatch_get_main_queue(), ^{  
            [JCS_Request showQueryHub]; 
        }); 
    } 
    //参数预处理 
    NSDictionary *processedParams = [JCS_Request preprocessParams:params]; 
    NSString *url = @"/getBannerList.action"; 
    [[JCS_Request sharedInstance] GET:url parameters:processedParams progress:^(NSProgress * _Nonnull uploadProgress) { 
 
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request hideRequestHub]; 
            }); 
        } 
        CommonResponse *result = [CommonResponse mj_objectWithKeyValues:responseObject]; 
        if(success){ 
            //获取data数据 
            id data = [JCS_Request dataInResponse:responseObject url:url requestParams:processedParams]; 
            success(result,data,responseObject); 
        } 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request showRequestErrorHub:error]; 
            }); 
        } 
        //处理错误
        [JCS_Request errorRequest:error url:url requestParams:params];
        if(failure){
            failure(error);
        }
    }]; 
} 

+ (void)requestGetBannerList2WithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSDictionary *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    [self requestGetBannerList2WithHub:NO params:params success:success failure:failure];
} 
+ (RACSignal*)requestGetBannerList2WithHub:(BOOL)hub params:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetBannerList2WithHub:hub params:params success:^(CommonResponse *result, NSDictionary *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
+ (RACSignal*)requestGetBannerList2WithParams:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetBannerList2WithParams:params success:^(CommonResponse *result, NSDictionary *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
/**
  获取用户信息接-nil
 */
+ (void)requestGetBannerList3WithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSDictionary *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    if(hub){ 
        dispatch_async(dispatch_get_main_queue(), ^{  
            [JCS_Request showQueryHub]; 
        }); 
    } 
    //参数预处理 
    NSDictionary *processedParams = [JCS_Request preprocessParams:params]; 
    NSString *url = @"/getBannerList.action"; 
    [[JCS_Request sharedInstance] GET:url parameters:processedParams progress:^(NSProgress * _Nonnull uploadProgress) { 
 
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request hideRequestHub]; 
            }); 
        } 
        CommonResponse *result = [CommonResponse mj_objectWithKeyValues:responseObject]; 
        if(success){ 
            //获取data数据 
            id data = [JCS_Request dataInResponse:responseObject url:url requestParams:processedParams]; 
            success(result,data,responseObject); 
        } 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request showRequestErrorHub:error]; 
            }); 
        } 
        //处理错误
        [JCS_Request errorRequest:error url:url requestParams:params];
        if(failure){
            failure(error);
        }
    }]; 
} 

+ (void)requestGetBannerList3WithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSDictionary *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    [self requestGetBannerList3WithHub:NO params:params success:success failure:failure];
} 
+ (RACSignal*)requestGetBannerList3WithHub:(BOOL)hub params:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetBannerList3WithHub:hub params:params success:^(CommonResponse *result, NSDictionary *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
+ (RACSignal*)requestGetBannerList3WithParams:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetBannerList3WithParams:params success:^(CommonResponse *result, NSDictionary *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
/**
  获取用户信息接口
 */
+ (void)requestGetUserInfoWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray<HKUserPerson *> *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    if(hub){ 
        dispatch_async(dispatch_get_main_queue(), ^{  
            [JCS_Request showQueryHub]; 
        }); 
    } 
    //参数预处理 
    NSDictionary *processedParams = [JCS_Request preprocessParams:params]; 
    NSString *url = @"/getUserInfo.action"; 
    [[JCS_Request sharedInstance] POST:url parameters:processedParams progress:^(NSProgress * _Nonnull uploadProgress) { 
 
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request hideRequestHub]; 
            }); 
        } 
        CommonResponse *result = [CommonResponse mj_objectWithKeyValues:responseObject]; 
        if(success){ 
            //获取data数据 
            id data = [JCS_Request dataInResponse:responseObject url:url requestParams:processedParams]; 
            if([data isKindOfClass:NSArray.class]){ 
                NSMutableArray *resultList = [HKUserPerson mj_objectArrayWithKeyValuesArray:data]; 
                success(result,resultList,responseObject); 
     
            } else if([data isKindOfClass:NSDictionary.class]){ 
                HKUserPerson *info = [HKUserPerson mj_objectWithKeyValues:data]; 
                success(result, @[info].mutableCopy, responseObject); 
     
            } else { 
                success(result,data,responseObject); 
            } 
        } 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request showRequestErrorHub:error]; 
            }); 
        } 
        //处理错误
        [JCS_Request errorRequest:error url:url requestParams:params];
        if(failure){
            failure(error);
        }
    }]; 
} 

+ (void)requestGetUserInfoWithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray<HKUserPerson *> *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    [self requestGetUserInfoWithHub:NO params:params success:success failure:failure];
} 
+ (RACSignal*)requestGetUserInfoWithHub:(BOOL)hub params:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetUserInfoWithHub:hub params:params success:^(CommonResponse *result, NSArray *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
+ (RACSignal*)requestGetUserInfoWithParams:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetUserInfoWithParams:params success:^(CommonResponse *result, NSArray *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
/**
  获取用户信息接口-list
 */
+ (void)requestGetUserInfo2WithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    if(hub){ 
        dispatch_async(dispatch_get_main_queue(), ^{  
            [JCS_Request showQueryHub]; 
        }); 
    } 
    //参数预处理 
    NSDictionary *processedParams = [JCS_Request preprocessParams:params]; 
    NSString *url = @"/getUserInfo.action"; 
    [[JCS_Request sharedInstance] POST:url parameters:processedParams progress:^(NSProgress * _Nonnull uploadProgress) { 
 
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request hideRequestHub]; 
            }); 
        } 
        CommonResponse *result = [CommonResponse mj_objectWithKeyValues:responseObject]; 
        if(success){ 
            //获取data数据 
            id data = [JCS_Request dataInResponse:responseObject url:url requestParams:processedParams]; 
            success(result,data,responseObject); 
        } 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request showRequestErrorHub:error]; 
            }); 
        } 
        //处理错误
        [JCS_Request errorRequest:error url:url requestParams:params];
        if(failure){
            failure(error);
        }
    }]; 
} 

+ (void)requestGetUserInfo2WithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    [self requestGetUserInfo2WithHub:NO params:params success:success failure:failure];
} 
+ (RACSignal*)requestGetUserInfo2WithHub:(BOOL)hub params:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetUserInfo2WithHub:hub params:params success:^(CommonResponse *result, NSArray *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
+ (RACSignal*)requestGetUserInfo2WithParams:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetUserInfo2WithParams:params success:^(CommonResponse *result, NSArray *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
/**
  获取商品类型列表
 */
+ (void)requestGetGoodsTypeListWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    if(hub){ 
        dispatch_async(dispatch_get_main_queue(), ^{  
            [JCS_Request showQueryHub]; 
        }); 
    } 
    //参数预处理 
    NSDictionary *processedParams = [JCS_Request preprocessParams:params]; 
    NSString *url = @"/flyfish/goodstype/getList.action"; 
    [[JCS_Request sharedInstance] POST:url parameters:processedParams progress:^(NSProgress * _Nonnull uploadProgress) { 
 
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request hideRequestHub]; 
            }); 
        } 
        CommonResponse *result = [CommonResponse mj_objectWithKeyValues:responseObject]; 
        if(success){ 
            //获取data数据 
            id data = [JCS_Request dataInResponse:responseObject url:url requestParams:processedParams]; 
            success(result,data,responseObject); 
        } 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request showRequestErrorHub:error]; 
            }); 
        } 
        //处理错误
        [JCS_Request errorRequest:error url:url requestParams:params];
        if(failure){
            failure(error);
        }
    }]; 
} 

+ (void)requestGetGoodsTypeListWithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    [self requestGetGoodsTypeListWithHub:NO params:params success:success failure:failure];
} 
+ (RACSignal*)requestGetGoodsTypeListWithHub:(BOOL)hub params:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetGoodsTypeListWithHub:hub params:params success:^(CommonResponse *result, NSArray *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
+ (RACSignal*)requestGetGoodsTypeListWithParams:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetGoodsTypeListWithParams:params success:^(CommonResponse *result, NSArray *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
/**
  获取商品类型列表
 */
+ (void)requestGetGoodsTypeListGetWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    if(hub){ 
        dispatch_async(dispatch_get_main_queue(), ^{  
            [JCS_Request showQueryHub]; 
        }); 
    } 
    //参数预处理 
    NSDictionary *processedParams = [JCS_Request preprocessParams:params]; 
    NSString *url = @"/flyfish/goodstype/getList-get.action"; 
    [[JCS_Request sharedInstance] GET:url parameters:processedParams progress:^(NSProgress * _Nonnull uploadProgress) { 
 
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request hideRequestHub]; 
            }); 
        } 
        CommonResponse *result = [CommonResponse mj_objectWithKeyValues:responseObject]; 
        if(success){ 
            //获取data数据 
            id data = [JCS_Request dataInResponse:responseObject url:url requestParams:processedParams]; 
            success(result,data,responseObject); 
        } 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request showRequestErrorHub:error]; 
            }); 
        } 
        //处理错误
        [JCS_Request errorRequest:error url:url requestParams:params];
        if(failure){
            failure(error);
        }
    }]; 
} 

+ (void)requestGetGoodsTypeListGetWithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    [self requestGetGoodsTypeListGetWithHub:NO params:params success:success failure:failure];
} 
+ (RACSignal*)requestGetGoodsTypeListGetWithHub:(BOOL)hub params:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetGoodsTypeListGetWithHub:hub params:params success:^(CommonResponse *result, NSArray *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
+ (RACSignal*)requestGetGoodsTypeListGetWithParams:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetGoodsTypeListGetWithParams:params success:^(CommonResponse *result, NSArray *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
/**
  获取关于App
 */
+ (void)requestGetAboutAppWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,HKUserAboutApp *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    if(hub){ 
        dispatch_async(dispatch_get_main_queue(), ^{  
            [JCS_Request showQueryHub]; 
        }); 
    } 
    //参数预处理 
    NSDictionary *processedParams = [JCS_Request preprocessParams:params]; 
    NSString *url = @"/flyfish/params/aboutApp.action"; 
    [[JCS_Request sharedInstance] POST:url parameters:processedParams progress:^(NSProgress * _Nonnull uploadProgress) { 
 
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request hideRequestHub]; 
            }); 
        } 
        CommonResponse *result = [CommonResponse mj_objectWithKeyValues:responseObject]; 
        if(success){ 
            //获取data数据 
            id data = [JCS_Request dataInResponse:responseObject url:url requestParams:processedParams]; 
            HKUserAboutApp *info = [HKUserAboutApp mj_objectWithKeyValues:data]; 
            success(result, info, responseObject); 
        } 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { 
        if(hub){ 
            dispatch_async(dispatch_get_main_queue(), ^{  
                [JCS_Request showRequestErrorHub:error]; 
            }); 
        } 
        //处理错误
        [JCS_Request errorRequest:error url:url requestParams:params];
        if(failure){
            failure(error);
        }
    }]; 
} 

+ (void)requestGetAboutAppWithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,HKUserAboutApp *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure { 
    [self requestGetAboutAppWithHub:NO params:params success:success failure:failure];
} 
+ (RACSignal*)requestGetAboutAppWithHub:(BOOL)hub params:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetAboutAppWithHub:hub params:params success:^(CommonResponse *result, HKUserAboutApp *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
+ (RACSignal*)requestGetAboutAppWithParams:(NSDictionary *)params {
    @weakify(self); 
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) { 
        @strongify(self); 
        [self requestGetAboutAppWithParams:params success:^(CommonResponse *result, HKUserAboutApp *data, id originResponse) { 
            [subscriber sendNext:@{@"result":result, @"data":data, @"originResponse":originResponse}]; 
            [subscriber sendCompleted]; 
        } failure:^(NSError *error) { 
           [subscriber sendNext:error]; 
           [subscriber sendCompleted]; 
       }]; 
       return nil; 
    }]; 
    return [signal replayLazily]; 
} 
@end