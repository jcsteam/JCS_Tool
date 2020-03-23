//
//  HKUserModel.h 
//  HKUserModel.h 
//
//  Created by JackCat on 2020.
//  Copyright © 2020/3/14 JackCat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Person/Person.h>
#import <Student/Student.h>
#import "Person.h"


@class HKUserAboutApp;
@class HKUserPerson;
@class HKUserGoodsTypeInfo;
@class HKUserStudent;
@class HKUserStudent2;


/**
  这是性别枚举
  Sex 第二行 注释
  Sex 第三行 注释
 */
typedef NS_ENUM(NSInteger, HKUserSex) { 
  HKUserSexMale = 1, //家居 
  HKUserSexFemale = 2, //ajjda  
};
/**
  骑车类型
  Sex 第二行 注释
  Sex 第三行 注释
 */
typedef NS_ENUM(NSInteger, HKUserCarType) { 
  HKUserCarTypeBwm = 1, //aaaa 
  HKUserCarTypeBieke = 2, //ddddd 
};


/**
  AboutApp
 */
@interface HKUserAboutApp : NSObject
/** 公司名称 */
@property (nonatomic, copy) NSString *companyName;
/** logo全地址 */
@property (nonatomic, copy) NSString *fullAppLogo;
/** appName */
@property (nonatomic, copy) NSString *appName;
/** app介绍 */
@property (nonatomic, copy) NSString *appIntroduction;
/** 客服电话 */
@property (nonatomic, copy) NSString *appCustomerService;
/** 公司网址 */
@property (nonatomic, copy) NSString *website;
@end


/**
  Person 第一行 注释
  Person 第二行 注释
 */
@interface HKUserPerson : NSObject
/**  */
@property (nonatomic, strong) NSMutableDictionary *addressInfo;
/** aa  姓名 */
@property (nonatomic, copy) NSString *name;
/** 这是我的喜好 */
@property (nonatomic, strong) NSMutableArray *likes;
/**  */
@property (nonatomic, strong) HKUserPerson *person;
/** 我有一辆汽车 */
@property (nonatomic, assign) HKUserCarType carType;
/**  */
@property (nonatomic, assign) HKUserSex sex;
@end


/**
  商品类型信息
 */
@interface HKUserGoodsTypeInfo : NSObject
/**  */
@property (nonatomic, assign) NSInteger id;
/**  */
@property (nonatomic, assign) BOOL isDisabled;
/**  */
@property (nonatomic, copy) NSString *title;
@end


@interface HKUserStudent : HKUserPerson
/** 学号 */
@property (nonatomic, copy) NSString *studentNo;
/**  */
@property (nonatomic, copy) NSString *address;
/**  */
@property (nonatomic, strong) HKUserPerson *teacher;
@end


@interface HKUserStudent2 : HKUserStudent
/** 学号 */
@property (nonatomic, copy) NSString *studentNo;
@end


