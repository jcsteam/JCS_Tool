//
//  RequestInfo.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestInfo : NSObject

/** <#备注#> **/
@property (nonatomic, copy) NSString *method;
/** <#备注#> **/
@property (nonatomic, copy) NSString *name;
/** <#备注#> **/
@property (nonatomic, copy) NSString *comment;
/** <#备注#> **/
@property (nonatomic, copy) NSString *dataClass;
/** 泛型类型 **/
@property (nonatomic, copy) NSString *limitClass;
/** <#备注#> **/
@property (nonatomic, copy) NSString *url;


@end

NS_ASSUME_NONNULL_END
