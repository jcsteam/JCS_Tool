//
//  HKUserRequest.h 
//  HKUserRequest.h 
//
//  Created by JackCat on 2020.
//  Copyright © 2020/3/14 JackCat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Person/Person.h>
#import <Student/Student.h>
#import "Person.h"
#import 

#import <ReactiveObjC/ReactiveObjC.h>
#import "CommonResponse.h"
#import "HKUserModel.h"

@interface HKUserRequest : NSObject



/**
  获取用户信息接口-Student2
  获取用户信息接口-Student2-2
  获取用户信息接口-Student2-3

  @params Hub 是否转菊花 
  @params params 请求参数 
  @params success 成功回调 
  @params failure 失败回调 
  @return void 
 */
+ (void)requestGetBannerListWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,HKUserStudent2 *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
/**
  获取用户信息接口-Student2
  获取用户信息接口-Student2-2
  获取用户信息接口-Student2-3

  @params classNo 班级号
  @params bannerType banner号
  @params carType 卡车类型
 */
+ (void)requestGetBannerListWithHub:(BOOL)hub classNo:(NSString *)classNo bannerType:(NSInteger )bannerType carType:(HKUserCarType)carType  success:(void(^)(CommonResponse *result,HKUserStudent2 *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetBannerListWithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetBannerListWithHub:(BOOL)hub classNo:(NSString *)classNo bannerType:(NSInteger )bannerType carType:(HKUserCarType)carType ;


/**
  获取用户信息接口-dict

  @params Hub 是否转菊花 
  @params params 请求参数 
  @params success 成功回调 
  @params failure 失败回调 
  @return void 
 */
+ (void)requestGetBannerList2WithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSDictionary *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
/**
  获取用户信息接口-dict

 */
+ (void)requestGetBannerList2WithHub:(BOOL)hub  success:(void(^)(CommonResponse *result,NSDictionary *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetBannerList2WithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetBannerList2WithHub:(BOOL)hub ;


/**
  获取用户信息接-nil

  @params Hub 是否转菊花 
  @params params 请求参数 
  @params success 成功回调 
  @params failure 失败回调 
  @return void 
 */
+ (void)requestGetBannerList3WithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSDictionary *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
/**
  获取用户信息接-nil

 */
+ (void)requestGetBannerList3WithHub:(BOOL)hub  success:(void(^)(CommonResponse *result,NSDictionary *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetBannerList3WithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetBannerList3WithHub:(BOOL)hub ;


/**
  获取用户信息接口

  @params Hub 是否转菊花 
  @params params 请求参数 
  @params success 成功回调 
  @params failure 失败回调 
  @return void 
 */
+ (void)requestGetUserInfoWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray<HKUserPerson *> *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
/**
  获取用户信息接口

 */
+ (void)requestGetUserInfoWithHub:(BOOL)hub  success:(void(^)(CommonResponse *result,NSArray<HKUserPerson *> *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetUserInfoWithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetUserInfoWithHub:(BOOL)hub ;


/**
  获取用户信息接口-list

  @params Hub 是否转菊花 
  @params params 请求参数 
  @params success 成功回调 
  @params failure 失败回调 
  @return void 
 */
+ (void)requestGetUserInfo2WithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
/**
  获取用户信息接口-list

 */
+ (void)requestGetUserInfo2WithHub:(BOOL)hub  success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetUserInfo2WithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetUserInfo2WithHub:(BOOL)hub ;


/**
  获取商品类型列表

  @params Hub 是否转菊花 
  @params params 请求参数 
  @params success 成功回调 
  @params failure 失败回调 
  @return void 
 */
+ (void)requestGetGoodsTypeListWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
/**
  获取商品类型列表

 */
+ (void)requestGetGoodsTypeListWithHub:(BOOL)hub  success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetGoodsTypeListWithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetGoodsTypeListWithHub:(BOOL)hub ;


/**
  获取商品类型列表

  @params Hub 是否转菊花 
  @params params 请求参数 
  @params success 成功回调 
  @params failure 失败回调 
  @return void 
 */
+ (void)requestGetGoodsTypeListGetWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
/**
  获取商品类型列表

 */
+ (void)requestGetGoodsTypeListGetWithHub:(BOOL)hub  success:(void(^)(CommonResponse *result,NSArray *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetGoodsTypeListGetWithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetGoodsTypeListGetWithHub:(BOOL)hub ;


/**
  获取关于App

  @params Hub 是否转菊花 
  @params params 请求参数 
  @params success 成功回调 
  @params failure 失败回调 
  @return void 
 */
+ (void)requestGetAboutAppWithHub:(BOOL)hub params:(NSDictionary *)params success:(void(^)(CommonResponse *result,HKUserAboutApp *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
/**
  获取关于App

 */
+ (void)requestGetAboutAppWithHub:(BOOL)hub  success:(void(^)(CommonResponse *result,HKUserAboutApp *data,NSDictionary *originResponse))success failure:(void(^)(NSError*error))failure;
+ (RACSignal*)requestGetAboutAppWithHub:(BOOL)hub params:(NSDictionary *)params;
+ (RACSignal*)requestGetAboutAppWithHub:(BOOL)hub ;

@end