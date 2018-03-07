//
//  FactorModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/23.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "FactorModel.h"

@implementation FactorModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
        _catId =dic[@"catId"];
        _catIdx =dic[@"catIdx"];
        _datatype =dic[@"datatype"];
        _Id =dic[@"id"];
        _name =dic[@"name"];
        _refid =dic[@"refid"];

    }
    return self;

    
}
    @end
