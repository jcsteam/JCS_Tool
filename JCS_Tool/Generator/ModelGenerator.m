//
//  ModelGenerator.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "ModelGenerator.h"
#import "MessageInfo.h"
#import "Common.h"
#import "Category.h"
#import "MessageParser.h"
#import "EnumParser.h"

#import "EnumGenerator.h"

@interface ModelGenerator()

@end

@implementation ModelGenerator

+ (void)generateModels:(NSString*)source configInfo:(ConfigInfo*)configInfo outputPath:(NSString*)outputPath {

    NSMutableString *stringBuilderH = [NSMutableString string]; //Model H String
    NSMutableString *stringBuilderM = [NSMutableString string]; //Model M String
    NSString *filenameH = [NSString stringWithFormat:@"%@Model.h",configInfo.prefix];
    NSString *filenameM = [NSString stringWithFormat:@"%@Model.m",configInfo.prefix];
    
    //枚举
    NSArray *enums = [EnumParser parseEnumMap:source configInfo:configInfo];
    //模型
    NSArray *models = [MessageParser parseModelMap:source configInfo:configInfo];
    if((!models || models.count == 0) && (!enums || enums.count == 0)){
        return;
    }
    //生成文件
    [ModelGenerator generateContentH:models enumMap:enums config:configInfo filename:(NSString*)filenameH stringBuilder:stringBuilderH];
    [ModelGenerator generateContentM:models config:configInfo  filenameH:(NSString*)filenameH filenameM:(NSString*)filenameM stringBuilder:stringBuilderM];
    
    //写入文件
    [Common writeToFile:filenameH outputPath:outputPath content:stringBuilderH];
    [Common writeToFile:filenameM outputPath:outputPath content:stringBuilderM];
}

+ (void)generateContentH:(NSArray*)models
                enumMap:(NSArray*)enums
                config:(ConfigInfo*)config
                filename:(NSString*)filename
         stringBuilder:(NSMutableString*)stringBuilder {
    
    //版权信息
    [Common copyRight:filename projectName:filename author:@"" stringBuilder:stringBuilder];
    //引入#import
    [stringBuilder appendString:@"#import <UIKit/UIKit.h>\n\n"];
    //@class 声明
    for (MessageInfo *message in models) {
        [stringBuilder appendFormat:@"@class %@;\n",[NSString stringWithFormat:@"%@",message.name]];
    }
    //枚举
    if(enums.count > 0){
        [stringBuilder appendString:@"\n\n"];
        [EnumGenerator generateEnums:enums config:config stringBuilder:stringBuilder];
    }
    //body
    [stringBuilder appendString:@"\n\n"];
    for (MessageInfo *message in models) {
        printf("🍇 正在生成 Model %s\n",[message.name cStringUsingEncoding:NSUTF8StringEncoding]);
        [self generateContentH:message config:config stringBuilder:stringBuilder];
    }
}
+ (void)generateContentH:(MessageInfo*)model config:(ConfigInfo*)config stringBuilder:(NSMutableString*)stringBuilder{
    NSString *messageName = [NSString stringWithFormat:@"%@",model.name];
    //备注
    [Common messageComment:model.comment stringBuilder:stringBuilder];
    if([model.superType isEqualToString:@"NSObject"]){
        [stringBuilder appendFormat:@"@interface %@ : %@\n",messageName,model.superType];
    } else { //继承类
        [stringBuilder appendFormat:@"@interface %@ : %@\n",messageName,[NSString stringWithFormat:@"%@",model.superType]];
    }
    //遍历生成属性
    for (MessageProperty *property in model.properties) {
        //备注
        [stringBuilder appendFormat:@"/** %@ */\n",property.comment];
        //属性
        NSString *modifierString = [self modifierString:property.type];
        //FIXME: 泛型暂不支持
//        if(property.limit1.length > 0 ) { //泛型单独处理
//            NSString *type = [[self propertyTypeMap] valueForKey:property.type];
//            if([property.type containsString:@"list"]){ //数组
//                NSString *limitTypeString = [self typeComponent:property.limit1];
//                [stringBuilder appendFormat:@"@property (nonatomic, %@) %@<%@> *%@;\n",modifierString,type,limitTypeString,property.name];
//            } else {
//                NSString *limitTypeString1 = [self typeComponent:property.limit1];
//                NSString *limitTypeString2 = [self typeComponent:property.limit2];
//                [stringBuilder appendFormat:@"@property (nonatomic, %@) %@<%@,%@> *%@;\n",modifierString,type,limitTypeString1,limitTypeString2,property.name];
//            }
//        } else {
        NSString *typeString = [Common typeComponent:property.type];
        if(!typeString.jcs_isValid){ //propertyTypeMap未匹配，则为引用类型
            if(property.isMessage){ //是否是message类型
                typeString = [NSString stringWithFormat:@"%@ *",property.type];
                
            } else if(property.isEnum){
                modifierString = @"assign";
                typeString = [NSString stringWithFormat:@"%@ ",property.type];
            }
        }
        [stringBuilder appendFormat:@"@property (nonatomic, %@) %@%@;\n",modifierString,typeString,property.name];
//        }
    }
    
    [stringBuilder appendString:@"@end\n\n\n"];
    
}

+ (void)generateContentM:(NSArray*)models
                config:(ConfigInfo*)config
                  filenameH:(NSString*)filenameH filenameM:(NSString*)filenameM
         stringBuilder:(NSMutableString*)stringBuilder {
    //版权信息
    [Common copyRight:filenameM projectName:filenameM author:@"" stringBuilder:stringBuilder];
    //引入#import
    [stringBuilder appendFormat:@"#import \"%@\"\n\n",filenameH];
    //body
    for (MessageInfo *message in models) {
        [self generateContentM:message config:config stringBuilder:stringBuilder];
    }
}
+ (void)generateContentM:(MessageInfo*)model config:(ConfigInfo*)config stringBuilder:(NSMutableString*)stringBuilder{
    NSString *messageName = [NSString stringWithFormat:@"%@",model.name];
    
    //备注
    [Common messageComment:model.comment stringBuilder:stringBuilder];
    //实现
    [stringBuilder appendFormat:@"@implementation %@\n",messageName];
    [stringBuilder appendString:@" \n"];
    [stringBuilder appendString:@"- (instancetype)init {\n"];
    [stringBuilder appendString:@"    self = [super init];\n"];
    [stringBuilder appendString:@"    if (self) {\n"];
    
    //遍历生成属性
    for (MessageProperty *property in model.properties) {
        [stringBuilder appendFormat:@"      self.%@ = %@;\n",property.name,property.defaultValue];
    }
    
    [stringBuilder appendString:@"    }\n"];
    [stringBuilder appendString:@"    return self;\n"];
    [stringBuilder appendString:@"}\n"];
    [stringBuilder appendString:@" \n"];
    [stringBuilder appendString:@"@end\n\n\n"];

}


/// 修复符
+ (NSString*)modifierString:(NSString*)typeString {
    NSString *type = [[Common propertyTypeMap] valueForKey:typeString];
    if([type isEqualToString:@"NSString"]) { return @"copy";}
    else if([type isEqualToString:@"NSMutableArray"]) { return @"strong";}
    else if([type isEqualToString:@"NSMutableDictionary"]) { return @"strong";}
    else if([type isEqualToString:@"NSInteger"]) { return @"assign";}
    else if([type isEqualToString:@"CGFloat"]) { return @"assign";}
    else if([type isEqualToString:@"double"]) { return @"assign";}
    else if([type isEqualToString:@"BOOL"]) { return @"assign";}
    else if([type isEqualToString:@"double"]) { return @"assign";}
    return @"strong";
}


@end
