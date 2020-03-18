//
//  HKUserRequest.h 
//  HKUserRequest.h 
//
//  Created by JackCat on 2020.
//  Copyright © 2020/3/14 JackCat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "CommonResponse.h"
#import "HKUserModel.h"

@interface HKUserRequest : NSObject

/**
  获取用户信息接口-Student2
 */
+ (void)requestGetBannerListWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,HKUserStudent2 *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (void)requestGetBannerListWithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,HKUserStudent2 *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetBannerListWithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetBannerListWithParams:(NSDictionary *)params;
/**
  获取用户信息接口-dict
 */
+ (void)requestGetBannerList2WithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSDictionary *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (void)requestGetBannerList2WithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSDictionary *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetBannerList2WithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetBannerList2WithParams:(NSDictionary *)params;
/**
  获取用户信息接-nil
 */
+ (void)requestGetBannerList3WithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSDictionary *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (void)requestGetBannerList3WithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSDictionary *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetBannerList3WithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetBannerList3WithParams:(NSDictionary *)params;
/**
  获取用户信息接口
 */
+ (void)requestGetUserInfoWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray<HKUserPerson *> *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (void)requestGetUserInfoWithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray<HKUserPerson *> *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetUserInfoWithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetUserInfoWithParams:(NSDictionary *)params;
/**
  获取用户信息接口-list
 */
+ (void)requestGetUserInfo2WithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (void)requestGetUserInfo2WithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetUserInfo2WithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetUserInfo2WithParams:(NSDictionary *)params;
/**
  获取商品类型列表
 */
+ (void)requestGetGoodsTypeListWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (void)requestGetGoodsTypeListWithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetGoodsTypeListWithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetGoodsTypeListWithParams:(NSDictionary *)params;
/**
  获取商品类型列表
 */
+ (void)requestGetGoodsTypeListGetWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (void)requestGetGoodsTypeListGetWithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetGoodsTypeListGetWithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetGoodsTypeListGetWithParams:(NSDictionary *)params;
/**
  获取关于App
 */
+ (void)requestGetAboutAppWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,HKUserAboutApp *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (void)requestGetAboutAppWithParams:(NSDictionary *)params success:(void(^)(CommonResponse *result,HKUserAboutApp *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetAboutAppWithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetAboutAppWithParams:(NSDictionary *)params;

@end