//
//  CommentParser.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentParser : NSObject

/// 对source进行预处理
+ (NSString*)preprocessSourceContent:(NSString*)sourceContent;

@end

NS_ASSUME_NONNULL_END
