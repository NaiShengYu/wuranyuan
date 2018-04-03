//
//  PageAQIInfoModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/20.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "PageAQIInfoModel.h"

@implementation PageAQIInfoModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
        _AQI =dic[@"AQI"];
        _PM25 =dic[@"PM25"];
        _facId =dic[@"facId"];
        _facName =dic[@"facName"];
        
        _aqiModel =[[AQIInfoModel alloc]initWithDic:dic[@"AQIInfo"]];
    }
    return self;
    
}

@end
