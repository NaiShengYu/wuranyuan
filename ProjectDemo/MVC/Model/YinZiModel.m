
//
//  YinZiModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/29.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "YinZiModel.h"

@implementation YinZiModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
        _ID=dic[@"id"];
        _name =dic[@"name"];
        _lowvalue =dic[@"lowvalue"];
        _time =dic[@"time"];
        _unit =dic[@"unit"];
        _upvalue =dic[@"upvalue"];
        _value =dic[@"value"];
    }
    return self;
}
@end
