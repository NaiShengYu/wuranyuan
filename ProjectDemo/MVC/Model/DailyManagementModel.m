//
//  DailyManagementModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/30.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "DailyManagementModel.h"

@implementation DailyManagementModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
        _CONTEXT=dic[@"CONTEXT"];
        _IMPROVECONTEXT =dic[@"IMPROVECONTEXT"];
        _RN =dic[@"RN"];
        _SUPERVISEDATE =dic[@"SUPERVISEDATE"];
        _SUPERVISOR=dic[@"SUPERVISOR"];
    }
    return self;
}
@end
