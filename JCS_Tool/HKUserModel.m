//
//  HKUserModel.m 
//  HKUserModel.m 
//
//  Created by JackCat on 2020.
//  Copyright © 2020/3/14 JackCat. All rights reserved.
//

#import "HKUserModel.h"

/**
  AboutApp
 */
@implementation HKUserAboutApp
 
- (instancetype)init {
    self = [super init];
    if (self) {
      self.companyName = nil;
      self.fullAppLogo = nil;
      self.appName = nil;
      self.appIntroduction = nil;
      self.appCustomerService = nil;
      self.website = nil;
    }
    return self;
}
 
@end


/**
  Person 第一行 注释
  Person 第二行 注释
 */
@implementation HKUserPerson
 
- (instancetype)init {
    self = [super init];
    if (self) {
      self.addressInfo = [NSMutableDictionary      dictionary]  ;
      self.name = @"张三";
      self.likes = nil;
      self.person = nil;
      self.carType = HKUserCarTypeBieke;
      self.sex = HKUserSexMale;
    }
    return self;
}
 
@end


/**
  商品类型信息
 */
@implementation HKUserGoodsTypeInfo
 
- (instancetype)init {
    self = [super init];
    if (self) {
      self.id = 0;
      self.isDisabled = false;
      self.title = nil;
    }
    return self;
}
 
@end


@implementation HKUserStudent
 
- (instancetype)init {
    self = [super init];
    if (self) {
      self.studentNo = @"0001";
      self.address = @"上海市公安局";
      self.teacher = nil;
    }
    return self;
}
 
@end


@implementation HKUserStudent2
 
- (instancetype)init {
    self = [super init];
    if (self) {
      self.studentNo = @"0002";
    }
    return self;
}
 
@end


