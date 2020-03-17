//
//  EnumParser.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/16.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "EnumParser.h"
#import "RegexKitLite.h"
#import "EnumInfo.h"
#import "Category.h"

#import "JCS_Defines.h"

static NSMutableDictionary *_enumNameMap = nil;
static NSMutableDictionary *_enumPropertiesMap = nil;

@implementation EnumParser

+ (NSArray*)parseEnumMap:(NSString*)sourceContent configInfo:(ConfigInfo*)configInfo{
    _enumNameMap = [NSMutableDictionary dictionary];
    _enumPropertiesMap = [NSMutableDictionary dictionary];
    //模型数组
    NSMutableArray *enums = [NSMutableArray array];
    
    NSArray *list = [sourceContent arrayOfCaptureComponentsMatchedByRegex:kEnumRegex];
    for (NSArray *item in list) {
        NSString *oriName = item[1];
        EnumInfo *model = [[EnumInfo alloc] init];
        //Name 不合法，跳过
        if(!oriName.jcs_isValid){
            continue;
        }
        //模型名称
        model.name = [NSString stringWithFormat:@"%@%@",configInfo.prefix,oriName];
        //modelName有效，则将model存储起来
        if(model.name && model.name.length > 0){
            [enums addObject:model];
            _enumNameMap[oriName] = model.name;
            //属性
            [self parseProperties:item[2] model:model configInfo:configInfo];
        }
        
    }
    return enums;
}

+ (void)parseProperties:(NSString*)content model:(EnumInfo*)model configInfo:(ConfigInfo*)configInfo{
    //每行进行分割
    NSArray *components = [content componentsSeparatedByString:@"\n"];
    //属性数组
    NSMutableArray<EnumProperty*> *properties = [NSMutableArray array];
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
        //属性
        NSArray *list = [comp arrayOfCaptureComponentsMatchedByRegex:kEnumPropertyRegex];
        if(list.count > 0){
            NSArray *item = list[0];
            EnumProperty *property = [[EnumProperty alloc] init];
            NSString *oriProperyName = item[1];
            property.name = [NSString stringWithFormat:@"%@%@",model.name,oriProperyName.jcs_catpureUpper];
            property.value = item[2];
            //备注信息
            NSString *comment = item[3];
            if(comment.jcs_isValid){
                list = [comment arrayOfCaptureComponentsMatchedByRegex:kLineCommentRegex];
                if(list.count > 0){
                    property.comment = list[0][1];
                }
            }
            //对备注进行再次匹配
            [properties addObject:property];
            
            _enumPropertiesMap[oriProperyName] = property.name;
        }
    }
    model.comment = [comment stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    model.properties = properties;
}

/// 属性是否是枚举
+ (BOOL)propertyIsEnum:(NSString*)type {
    return [_enumNameMap.allKeys containsObject:type];
}
/// 转换属性类型 "Sex -> JCS_Sex"
+ (NSString*)transPropertyType:(NSString*)type {
    return [_enumNameMap valueForKey:type];
}
/// 转换属性类型 "male -> JCS_SexMale"
+ (NSString*)transPropertyValue:(NSString*)value {
    return [_enumPropertiesMap valueForKey:value];
}

@end
