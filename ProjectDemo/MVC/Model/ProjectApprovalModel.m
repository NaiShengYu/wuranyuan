//
//  ProjectApprovalModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/30.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "ProjectApprovalModel.h"

@implementation ProjectApprovalModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
        _ID=dic[@"id"];
        _CLOSECASEDATE =dic[@"CLOSECASEDATE"];
        _CLOSECASESTATE =dic[@"CLOSECASESTATE"];
        _ENDLINEDATE =dic[@"ENDLINEDATE"];
        _ORDERDATE =dic[@"ORDERDATE"];
        _STATEDESC =dic[@"STATEDESC"];
        _TITLE =dic[@"TITLE"];
    }
    return self;
}
@end
