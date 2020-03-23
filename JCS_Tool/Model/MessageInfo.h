//
//  MessageInfo.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface MessageProperty : NSObject

/** <#备注#> **/
@property (nonatomic, copy) NSString *type;
/** <#备注#> **/
@property (nonatomic, copy) NSString *name;
/** <#备注#> **/
@property (nonatomic, copy) NSString *defaultValue;
/** <#备注#> **/
@property (nonatomic, copy) NSString *comment;
/** 是否是枚举类型 **/
@property (nonatomic, assign) BOOL isEnum;
/** 是否是Message类型 **/
@property (nonatomic, assign) BOOL isMessage;

/** 泛型标志1 **/
@property (nonatomic, copy) NSString *limit1;
/** 泛型标志2 **/
@property (nonatomic, copy) NSString *limit2;

/** 完整类型 **/
@property (nonatomic, copy) NSString *fullTypeString;
/** 修饰符 **/
@property (nonatomic, copy) NSString *modifierString;


@end


@interface MessageInfo : NSObject

/** 父类 **/
@property (nonatomic, copy) NSString *superType;
/** 当前类名 **/
@property (nonatomic, copy) NSString *name;
/** 类注释 **/
@property (nonatomic, copy) NSString *comment;
/** 继承级别，用户生成文件时先后顺序，level小生成在上面，level大生成在下面 **/
@property (nonatomic, assign) NSInteger extendsLevel;
/** 属性 **/
@property (nonatomic, strong) NSArray<MessageProperty*> *properties;

@end

NS_ASSUME_NONNULL_END
