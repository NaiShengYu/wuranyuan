//
//  SupervisionAndInspectionModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/30.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "SupervisionAndInspectionModel.h"

@implementation SupervisionAndInspectionModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
        _CHECKPERSON=dic[@"CHECKPERSON"];
        _FLAG =dic[@"FLAG"];
        _ID =dic[@"ID"];
        _INPUTUSER =dic[@"INPUTUSER"];
        _name=dic[@"NAME"];
        _RESULT=dic[@"RESULT"];
        _RN=dic[@"RN"];
        _TEMPLATEID=dic[@"TEMPLATEID"];
    }
    return self;
}
@end
