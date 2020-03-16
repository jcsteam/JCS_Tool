//
//  CommentParser.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "CommentParser.h"
#import "RegexKitLite.h"
#import "Category.h"

#import "JCS_Defines.h"

@implementation CommentParser

/// 对source进行预处理
+ (NSString*)preprocessSourceContent:(NSString*)sourceContent {
    NSMutableString *source = [NSMutableString stringWithString:sourceContent];
    //删除星号注释块
    source = [self removeCommentBlock:source];
    //删除空白行及整行注释
    source = [self removeBlankLine:source];
    return [source copy];
}

/// 删除空白行
+ (NSMutableString*)removeBlankLine:(NSMutableString*)sourceContent {
    //按行进行拆分
    NSMutableArray *comps = [NSMutableArray arrayWithArray:[sourceContent componentsSeparatedByString:@"\n"]];
    //需要删除的行内容
    NSMutableArray *deleteComps = [NSMutableArray array];
    for (NSString *comp in comps) {
        //出去前后空白
        NSString *compProcessed = [comp stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
        //为空，则删除
        if(!compProcessed.jcs_isValid){
            [deleteComps addObject:comp];
            continue;
        }
        //”//“开头，为整行注释，删除
        if([compProcessed hasPrefix:@"//"]){
            [deleteComps addObject:comp];
            continue;
        }
    }
    [comps removeObjectsInArray:deleteComps];
    return [NSMutableString stringWithString:[comps componentsJoinedByString:@"\n"]];
}

/// 删除注释块
+ (NSMutableString*)removeCommentBlock:(NSMutableString*)sourceContent {
    NSArray *list = [sourceContent arrayOfCaptureComponentsMatchedByRegex:kCommentBlockRegex];
    for (NSArray *items in list) {
        NSString *commentBlock = items[0];
        NSRange commentBlockRange = [sourceContent rangeOfString:commentBlock];
        [sourceContent deleteCharactersInRange:commentBlockRange];
    }
    return sourceContent;
}

@end
