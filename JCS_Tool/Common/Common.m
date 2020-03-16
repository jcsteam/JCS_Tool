//
//  Common.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/14.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "Common.h"
#import "Category.h"

@implementation Common

///版权信息
+ (void)copyRight:(NSString*)fileName projectName:(NSString*)projectName author:(NSString*)author stringBuilder:(NSMutableString*)stringBuilder{
    
    NSString *year = @"2020/3/14";
    NSString *date = @"2020";
    if(author.length == 0){
        author = @"JackCat";
    }
    
    [stringBuilder appendString:@"//\n"];
    [stringBuilder appendFormat:@"//  %@ \n",fileName];
    [stringBuilder appendFormat:@"//  %@ \n",projectName];
    [stringBuilder appendString:@"//\n"];
    [stringBuilder appendFormat:@"//  Created by %@ on %@.\n",author,date];
    [stringBuilder appendFormat:@"//  Copyright © %@ %@. All rights reserved.\n",year,author];
    [stringBuilder appendString:@"//\n\n"];

}

/// message 备注
+ (void)messageComment:(NSString*)comment stringBuilder:(NSMutableString*)stringBuilder {
    if(comment.jcs_isValid){
        [stringBuilder appendString:@"/**\n"];
        [stringBuilder appendFormat:@"  %@\n",comment];
        [stringBuilder appendString:@" */\n"];
    }
}

+ (void)writeToFile:(NSString*)filename outputPath:(NSString*)outputPath content:(NSString*)content {
    filename = [outputPath stringByAppendingPathComponent:filename];
    NSError *error = nil;
    BOOL success = [content writeToFile:filename atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(!success || error){
        NSLog(@"文件 %@ 写入失败 %@",filename.lastPathComponent,error);
    }
}

@end
