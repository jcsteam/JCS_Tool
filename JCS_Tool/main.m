//
//  main.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"
#import "CommentParser.h"
#import "ConfigParser.h"

#import "ModelGenerator.h"
#import "RequestGenerator.h"

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
        
        //生成模型
        [ModelGenerator generateModels:source configInfo:configInfo outputPath:outputPath];
        //生成Request
        [RequestGenerator generateRequests:source configInfo:configInfo outputPath:outputPath];
    }
    return 0;
}
