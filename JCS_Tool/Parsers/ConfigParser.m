//
//  ConfigParser.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ConfigParser.h"
#import "RegexKitLite.h"

#import "JCS_Defines.h"

@implementation ConfigParser

+ (ConfigInfo*)parseConfigInfo:(NSString*)sourcePath {
    NSString *sourceString = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    
    ConfigInfo *configInfo = [[ConfigInfo alloc] init];
    
    NSArray *list = [sourceString arrayOfCaptureComponentsMatchedByRegex:kConfigRegex];
    if(list.count > 0){
        NSArray *contents = list[0];
        NSString *jsonString = [NSString stringWithFormat:@"{%@}",contents[2]];
        NSError *error = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
        if(result){
            configInfo.prefix = [result valueForKey:@"prefix"];
            configInfo.responseModel = [result valueForKey:@"responseModel"];
        }
    }
    
    return configInfo;
}

@end
