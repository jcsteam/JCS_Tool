//
//  EnumInfo.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnumProperty : NSObject

/** 属性名 **/
@property (nonatomic, copy) NSString *name;
/** 属性值 **/
@property (nonatomic, copy) NSString *value;
/** 备注信息 **/
@property (nonatomic, copy) NSString *comment;

@end

@interface EnumInfo : NSObject

/** 枚举名 **/
@property (nonatomic, copy) NSString *name;
/** 备注 **/
@property (nonatomic, copy) NSString *comment;
/** 属性 **/
@property (nonatomic, strong) NSArray<EnumProperty*> *properties;

@end

NS_ASSUME_NONNULL_END
