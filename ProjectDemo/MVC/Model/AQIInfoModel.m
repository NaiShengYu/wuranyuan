//
//  AQIInfoModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/23.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "AQIInfoModel.h"

@implementation AQIInfoModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
        _AQI =dic[@"AQI"];
        _AQIClass =dic[@"AQIClass"];
        _AQIColor =dic[@"AQIColor"];
        _AQILevel =dic[@"AQILevel"];
        _Health =dic[@"Health"];
        _Idx =dic[@"Idx"];
        _Suggestion =dic[@"Suggestion"];

    }
    return self;
    
    
}
@end

