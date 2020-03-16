//
//  main.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"

#import "ConfigParser.h"
#import "MessageParser.h"
#import "EnumParser.h"
#import "CommentParser.h"

#import "ModelGenerator.h"
#import "EnumGenerator.h"

#import "Category.h"
#import "Common.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString *sourcePath = @"/Users/yongping/Documents/Pod库/JCS_Tool/JCS_Tool/source.h";
        NSString *tempOutputPath = @"/Users/yongping/Documents/Pod库/JCS_Tool/JCS_Tool/output.h";
        NSString *outputPath = @"/Users/yongping/Documents/Pod库/JCS_Test/JCS_Test";
        
        //解析之前，先删除(整行注释、空行、*号注释)
        NSString *source = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
        source = [CommentParser preprocessSourceContent:source];
        //预处理后的内容写入临时文件，调试使用
        [source writeToFile:tempOutputPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        //配置信息
        ConfigInfo *configInfo = [ConfigParser parseConfigInfo:sourcePath];
        
        NSMutableString *stringBuilderH = nil; //Model H String
        NSMutableString *stringBuilderM = nil; //Model M String
        NSString *filenameH = nil;
        NSString *filenameM = nil;
        
        //枚举
        NSArray *enums = [EnumParser parseEnumMap:source configInfo:configInfo];
        
        //模型
        {
            NSArray *models = [MessageParser parseModelMap:source configInfo:configInfo];
            stringBuilderH = [NSMutableString string];
            stringBuilderM = [NSMutableString string];
            filenameH = [NSString stringWithFormat:@"%@Model.h",configInfo.prefix];
            filenameM = [NSString stringWithFormat:@"%@Model.m",configInfo.prefix];
            //生成文件
            [ModelGenerator generateModelH:models enumMap:enums config:configInfo filename:(NSString*)filenameH stringBuilder:stringBuilderH];
            [ModelGenerator generateModelM:models config:configInfo  filenameH:(NSString*)filenameH filenameM:(NSString*)filenameM stringBuilder:stringBuilderM];
        }
        //写入文件
        [Common writeToFile:filenameH outputPath:outputPath content:stringBuilderH];
        [Common writeToFile:filenameM outputPath:outputPath content:stringBuilderM];
        
    }
    return 0;
}
