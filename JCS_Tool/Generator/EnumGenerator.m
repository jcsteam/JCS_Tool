//
//  EnumGenerator.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "EnumGenerator.h"
#import "EnumInfo.h"
#import "Category.h"
#import "Common.h"

@implementation EnumGenerator

/// 拼接模型文件
+ (void)generateEnums:(NSArray*)enums config:(ConfigInfo*)config stringBuilder:(NSMutableString*)stringBuilder {
    
    if(!(enums && enums.count > 0)){
        return;
    }
    
    for (EnumInfo *enumInfo in enums) {
        
        printf("🍏 正在生成 Enum %s\n",[enumInfo.name cStringUsingEncoding:NSUTF8StringEncoding]);
        //备注
        [Common messageComment:enumInfo.comment stringBuilder:stringBuilder];
        [stringBuilder appendFormat:@"typedef NS_ENUM(NSInteger, %@) { \n",[NSString stringWithFormat:@"%@",enumInfo.name]];
        for (EnumProperty *property in enumInfo.properties) {
            //备注信息
            NSString *comment = @"";
            if(property.comment.jcs_isValid){
                comment = [NSString stringWithFormat:@"//%@",property.comment];
            }
            [stringBuilder appendFormat:@"  %@ = %@, %@ \n",property.name.jcs_catpureUpper,property.value,comment];
        }
        [stringBuilder appendString:@"};\n"];
    }
}

@end
