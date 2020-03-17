//
//  RequestParser.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestParser : NSObject

+ (NSArray*)parseRequest:(NSString*)sourceContent configInfo:(ConfigInfo*)configInfo;

@end

NS_ASSUME_NONNULL_END
