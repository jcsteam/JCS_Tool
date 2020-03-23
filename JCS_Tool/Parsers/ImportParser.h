//
//  ImportParser.h
//  JCS_Tool
//
//  Created by 永平 on 2020/3/23.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImportParser : NSObject

+ (NSArray*)parseImportInfo:(NSString*)sourceString;

@end

NS_ASSUME_NONNULL_END
