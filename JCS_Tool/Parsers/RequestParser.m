//
//  RequestParser.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "RequestParser.h"
#import "RegexKitLite.h"
#import "Category.h"
#import "RequestInfo.h"

#import "JCS_Defines.h"

@implementation RequestParser

+ (NSArray*)parseRequest:(NSString*)source configInfo:(ConfigInfo*)configInfo{
    NSArray *list = [source arrayOfCaptureComponentsMatchedByRegex:kRequestRegex];
    NSMutableArray *requests = [NSMutableArray array];
    for (NSArray *items in list) {
        NSString *oriName = items[2];
        //Name 不合法，跳过
        if(!oriName.jcs_isValid){
            continue;
        }
        RequestInfo *request = [[RequestInfo alloc] init];
        request.method = items[1];
        request.name = items[2];
        request.dataClass = items[3];
        request.url = items[4];
        if(request.name.jcs_isValid){
            [requests addObject:request];
            [self parseProperties:items[5] model:(id)request configInfo:configInfo];
        }
    }
    return requests;
}


+ (void)parseProperties:(NSString*)content model:(RequestInfo*)model configInfo:(ConfigInfo*)configInfo{
    if(!content.jcs_isValid){
        return;
    }
    //每行进行分割
    NSArray *components = [content componentsSeparatedByString:@"\n"];
    //属性数组
//    NSMutableArray<EnumProperty*> *properties = [NSMutableArray array];
    //Message备注
    NSMutableString *comment = [NSMutableString string];
    for (NSString *comp in components) {
        if(!comp.jcs_isValid){
            continue;
        }
        //备注
        if([comp containsString:@"desc "]){
            NSArray *list = [comp arrayOfCaptureComponentsMatchedByRegex:kDescRegex];
            if(list.count > 0){
                NSArray *item = list[0];
                [comment appendFormat:@"  %@\n",item[2]];
            }
        }
//        //属性
//        NSArray *list = [comp arrayOfCaptureComponentsMatchedByRegex:kEnumPropertyRegex];
//        if(list.count > 0){
//            NSArray *item = list[0];
//            EnumProperty *property = [[EnumProperty alloc] init];
//            NSString *oriProperyName = item[1];
//            property.name = [NSString stringWithFormat:@"%@%@",model.name,oriProperyName.jcs_catpureUpper];
//            property.value = item[2];
//            //备注信息
//            NSString *comment = item[3];
//            if(comment.jcs_isValid){
//                list = [comment arrayOfCaptureComponentsMatchedByRegex:kLineCommentRegex];
//                if(list.count > 0){
//                    property.comment = list[0][1];
//                }
//            }
//            //对备注进行再次匹配
//            [properties addObject:property];
//
//            _enumPropertiesMap[oriProperyName] = property.name;
//        }
    }
    model.comment = [comment stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
//    model.properties = properties;
}

@end
