//
//  ModelGenerator.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModelGenerator : NSObject

+ (void)generateModels:(NSString*)source configInfo:(ConfigInfo*)configInfo outputPath:(NSString*)outputPath;

@end

NS_ASSUME_NONNULL_END
