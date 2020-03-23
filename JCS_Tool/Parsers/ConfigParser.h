//
//  ConfigParser.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConfigParser : NSObject

+ (ConfigInfo*)parseConfigInfo:(NSString*)sourceString;

@end

NS_ASSUME_NONNULL_END
