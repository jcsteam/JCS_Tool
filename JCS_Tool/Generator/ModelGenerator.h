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

+ (void)generateModelH:(NSArray*)models
               enumMap:(NSArray*)enums
       config:(ConfigInfo*)config
     filename:(NSString*)filename
         stringBuilder:(NSMutableString*)stringBuilder;

+ (void)generateModelM:(NSArray*)models
       config:(ConfigInfo*)config
         filenameH:(NSString*)filenameH
             filenameM:(NSString*)filenameM
         stringBuilder:(NSMutableString*)stringBuilder;

@end

NS_ASSUME_NONNULL_END
