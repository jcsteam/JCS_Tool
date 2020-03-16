//
//  MessageInfo.m
//  JCS_Tool
//
//  Created by 永平 on 2020/3/13.
//  Copyright © 2020 yongping. All rights reserved.
//

#import "MessageInfo.h"

@implementation MessageProperty
- (NSString *)comment {
    if(_comment && _comment.length > 0){
        return _comment;
    }
    return @"";
}
@end

@implementation MessageInfo

- (NSString *)comment {
    if(_comment && _comment.length > 0){
        return _comment;
    }
    return @"";
}

@end
