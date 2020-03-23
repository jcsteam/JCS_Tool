//
//  MessageParser.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "MessageParser.h"
#import "RegexKitLite.h"

#import "JCS_Defines.h"
#import "Common.h"
#import "Category.h"

#import "MessageInfo.h"

#import "EnumParser.h"

static NSMutableDictionary *_messageNameMap = nil;

@implementation MessageParser

+ (NSMutableArray*)parseModelMap:(NSString*)sourceContent configInfo:(ConfigInfo*)configInfo{
    //模型数组
    NSMutableDictionary *models = [NSMutableDictionary dictionary];
    
    //非继承类
    NSArray *list = [sourceContent arrayOfCaptureComponentsMatchedByRegex:kMessageRegex];
    for (NSArray *item in list) {
        MessageInfo *model = [[MessageInfo alloc] init];
        NSString *oriName = item[1];
        //Name 不合法，跳过
        if(!oriName.jcs_isValid){
            continue;
        }
        //模型名称
        model.name = oriName;
        model.superType = @"NSObject";
        //modelName有效，则将model存储起来
        models[model.name] = model;
        //属性
        [self parseProperties:item[2] model:model];
    }
    
    //继承类
    list = [sourceContent arrayOfCaptureComponentsMatchedByRegex:kMessageExtendsRegex];
    for (NSArray *item in list) {
        MessageInfo *model = [[MessageInfo alloc] init];
        NSString *oriName = item[1];
        //Name 不合法，跳过
        if(!oriName.jcs_isValid){
            continue;
        }
        //模型名称
        model.name = oriName;
        model.superType = item[2];
        //modelName有效，则将model存储起来
        models[model.name] = model;
        //属性
        [self parseProperties:item[3] model:model];
    }
    
    //后处理
    return [self postHandleMap:models configInfo:configInfo];
}
/// 解析属性
+ (void)parseProperties:(NSString*)content model:(MessageInfo*)model{
    //每行进行分割
    NSArray *components = [content componentsSeparatedByString:@"\n"];
    //属性数组
    NSMutableArray<MessageProperty*> *properties = [NSMutableArray array];
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
        if([comp containsString:@"optional "] || [comp containsString:@"message "]){
            NSArray *list = [comp arrayOfCaptureComponentsMatchedByRegex:kMessagePropertyRegex];
            if(list.count > 0){
                NSArray *item = list[0];
                MessageProperty *property = [[MessageProperty alloc] init];
                property.name = item[3];
                property.defaultValue = item[4];
                //类型
                NSString *type = item[2];
//                if([type containsString:@"<"] && [type containsString:@">"]){ //泛型
//                    if([type containsString:@","]){ //字典泛型
//                        list = [type  arrayOfCaptureComponentsMatchedByRegex:@"(?:\\s*)([\\S]*)(?:\\s*)<(?:\\s*)([\\S]*)(?:\\s*),(?:\\s*)([\\S]*)(?:\\s*)>(?:\\s*)"];
//                        if(list.count > 0){
//                            NSArray *item = list[0];
//                            property.type = item[1];
//                            property.limit1 = item[2];
//                            property.limit2 = item[3];
//                        }
//                    } else { //数组泛型
//                        list = [type  arrayOfCaptureComponentsMatchedByRegex:@"(?:\\s*)([\\S]*)(?:\\s*)<(?:\\s*)([\\S]*)(?:\\s*)>(?:\\s*)"];
//                        if(list.count > 0){
//                            NSArray *item = list[0];
//                            property.type = item[1];
//                            property.limit1 = item[2];
//                        }
//                    }
//                } else {
                    property.type = type;
//                }
                
                //备注信息
                NSString *comment = item[5];
                list = [comment arrayOfCaptureComponentsMatchedByRegex:kLineCommentRegex];
                if(list.count > 0){
                    property.comment = list[0][1];
                }
                //对备注进行再次匹配
                [properties addObject:property];
            }
        }
    }
    
    model.comment = [comment stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    model.properties = properties;
}
/// 后处理Map，对继承属性进行更正、Key替换、继承排序
+ (NSMutableArray*)postHandleMap:(NSMutableDictionary*)map configInfo:(ConfigInfo*)configInfo{
    
    _messageNameMap = [NSMutableDictionary dictionary];
    //前缀添加、属性引用、super替换
    for (NSString *key in map.allKeys) {
        MessageInfo *messageInfo = [map valueForKey:key];
        //Key替换
        NSString *newKey = [NSString stringWithFormat:@"%@%@",configInfo.prefix,key];
        map[newKey] = messageInfo;
        messageInfo.name = newKey;
        //移除老Key
        [map removeObjectForKey:key];
        //super Class
        if(![messageInfo.superType isEqualToString:@"NSObject"]){
            messageInfo.superType = [NSString stringWithFormat:@"%@%@",configInfo.prefix,messageInfo.superType];
        }
        //Key map存储
        _messageNameMap[key] = newKey;
        
        //类属性
        for (MessageProperty *property in messageInfo.properties) {
            
            if([EnumParser propertyIsEnum:property.type]){ //枚举类型
                property.isEnum = YES;
                property.type = [EnumParser transPropertyType:property.type];
                property.defaultValue = [EnumParser transPropertyValue:property.defaultValue];
                property.modifierString = @"assign";
                property.fullTypeString = property.type;
                
            } else if([self propertyIsMessage:property.type]){ //Message类型
                property.isMessage = YES;
                property.type = [self transPropertyType:property.type];
                property.modifierString = @"strong";
                property.fullTypeString = [NSString stringWithFormat:@"%@ *",property.type];
                
            } else if([Common.propertyTypeMap.allKeys containsObject:property.type]){ //
                property.modifierString = [Common modifierString:property.type];
                property.fullTypeString = [Common fullTypeString:property.type];
                property.type = [Common.propertyTypeMap valueForKey:property.type];
                
            } else { //未识别，都当指针处理
                property.modifierString = @"strong";
                property.fullTypeString = [NSString stringWithFormat:@"%@ *",property.type];
            }
        }
    }
    
    // 按继承关系，对继extendsLevel进行计算层级
    NSMutableArray *models = [NSMutableArray array];
    for (MessageInfo *info in map.allValues) {
        if([info.superType isEqualToString:@"NSObject"]){
            info.extendsLevel = 0;
        } else {
            MessageInfo *superClass = map[info.superType];
            NSInteger level = 1;
            while (![superClass.superType isEqualToString:@"NSObject"]) {
                level++;
                superClass = map[superClass.superType];
            }
            info.extendsLevel = level;
        }
        [models addObject:info];
    }
    // 按extendsLevel大小进行排序
    [models sortUsingComparator:^NSComparisonResult(MessageInfo *obj1, MessageInfo *obj2) {
        if(obj1.extendsLevel < obj2.extendsLevel){
            return NSOrderedAscending;
        } else if(obj1.extendsLevel > obj2.extendsLevel) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    return models;
}

/// 属性是否是Message类型
+ (BOOL)propertyIsMessage:(NSString*)type{
    return [_messageNameMap.allKeys containsObject:type] || [_messageNameMap.allValues containsObject:type];
}
/// 转换属性类型 "Person -> JCS_Person"
+ (NSString*)transPropertyType:(NSString*)type {
    for (NSString *key in _messageNameMap) {
        if([key isEqualToString:type] || [_messageNameMap[key] isEqualToString:type]){
            return _messageNameMap[key];
        }
    }
    return nil;
}

@end
