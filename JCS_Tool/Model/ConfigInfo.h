//
//  ConfigInfo.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfigInfo : NSObject

/** 前缀 **/
@property (nonatomic, copy) NSString *prefix;
/** 接口响应接受类 **/
@property (nonatomic, copy) NSString *responseModel;
/** 是否生成返回值是RACSignal的接口请求 **/
@property (nonatomic, assign) BOOL signalRequest;


@end

NS_ASSUME_NONNULL_END
