//
//  FactorDataModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/23.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "FactorDataModel.h"

@implementation FactorDataModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
        _date =dic[@"date"];
        _name =dic[@"name"];
        _val =dic[@"val"];
    }
    return self;
    
    
}
@end
