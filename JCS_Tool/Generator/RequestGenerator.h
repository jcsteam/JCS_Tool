//
//  RequestGenerator.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/17.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestGenerator : NSObject

+ (void)generateRequests:(NSString*)source configInfo:(ConfigInfo*)configInfo outputPath:(NSString*)outputPath;

@end

NS_ASSUME_NONNULL_END
