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
#import "ImportParser.h"

#import "ModelGenerator.h"
#import "RequestGenerator.h"

#import "Category.h"
#import "Common.h"

//表情符号
//http://cn.piliapp.com/facebook-symbols/

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        if(!argv[1]){
//            printf("sourcePath 必传\n");
//            return 0;
//        }
        
        NSString *sourceFile = @"/Users/yongping/Documents/Pod库/JCS_Tool/JCS_Tool/source.h";
        
//        NSString *sourceFile = @(argv[1]);
        if(![[NSFileManager defaultManager] fileExistsAtPath:sourceFile]) {
            printf("%s 文件不存在\n",argv[1]);
        }
        
        NSString *outputPath = [sourceFile stringByDeletingLastPathComponent];
        NSString *preprocessFile = [outputPath stringByAppendingPathComponent:@"preprocess.h"];

        //解析之前，先删除(整行注释、空行、*号注释)
        NSString *source = [NSString stringWithContentsOfFile:sourceFile encoding:NSUTF8StringEncoding error:nil];
        
        printf("\n🔨 开始预处理source\n");
        source = [CommentParser preprocessSourceContent:source];
        //预处理后的内容写入临时文件，调试使用
        [source writeToFile:preprocessFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
        printf("🔨 预处理source完成,已存放至preprocess.h\n\n");

        //配置信息
        ConfigInfo *configInfo = [ConfigParser parseConfigInfo:source];
        //Import 信息
        NSArray *imports = [ImportParser parseImportInfo:source];
        [Common configImports:imports];
        
        //生成模型
        [ModelGenerator generateModels:source configInfo:configInfo outputPath:outputPath];
        //生成Request
        [RequestGenerator generateRequests:source configInfo:configInfo outputPath:outputPath];
        
        printf("\n 🎉🎉🎉 生成完毕 🎉🎉🎉 \n");
    }
    return 0;
}
