//
//  ImportParser.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/23.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ImportParser.h"
#import "RegexKitLite.h"

#import "JCS_Defines.h"

@implementation ImportParser

+ (NSArray*)parseImportInfo:(NSString*)sourceString {
    NSMutableArray *imports = [NSMutableArray array];
    
    //#import <Lib/Lib.h>
    NSArray *importsLib = [self parserImport:sourceString regex:kImportLib];
    for (NSString *content in importsLib) {
        [imports addObject:[NSString stringWithFormat:@"#import <%@>",content]];
    }
    
    //#import "Person.h"
    NSArray *importsClass = [self parserImport:sourceString regex:kImportClass];
    for (NSString *content in importsClass) {
        [imports addObject:[NSString stringWithFormat:@"#import \"%@\"",content]];
    }
    
    return imports;
}

///
+ (NSArray*)parserImport:(NSString*)sourceString regex:(NSString*)regex{
    NSMutableArray *imports = [NSMutableArray array];
    NSArray *list = [sourceString arrayOfCaptureComponentsMatchedByRegex:regex];
    for (NSArray *items in list) {
        NSString *content = items[1];
        if([content hasSuffix:@".h"]){
            [imports addObject:content];
        } else {
            [imports addObject:[NSString stringWithFormat:@"%@.h",content]];
        }
    }
    return imports;
}



@end
