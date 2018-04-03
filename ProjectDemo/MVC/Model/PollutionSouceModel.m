//
//  PollutionSouceModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/28.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "PollutionSouceModel.h"

@implementation PollutionSouceModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
         _ID = dic[@"id"];
        _lat = dic[@"lat"];
        _lng = dic[@"lng"];
        _stvalue = dic[@"stvalue"];
        _time = dic[@"time"];
        _value = dic[@"value"];
        _name = dic[@"name"];
        _count = dic[@"count"];
    }
    return self;
    
    
}
@end
