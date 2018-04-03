//
//  PaiKouModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/28.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "PaiKouModel.h"

@implementation PaiKouModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
        _ID=dic[@"id"];
        _name =dic[@"name"];
        _ptype =dic[@"ptype"];
        _typeName =dic[@"typename"];
        _yinZiArray =[[NSMutableArray alloc]init];
    }
    return self;
    
    
}
@end
