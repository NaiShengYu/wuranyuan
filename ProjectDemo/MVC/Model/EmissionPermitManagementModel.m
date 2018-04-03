//
//  EmissionPermitManagementModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/30.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "EmissionPermitManagementModel.h"

@implementation EmissionPermitManagementModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
        _ID=dic[@"ID"];
        _ISSUEDATE =dic[@"ISSUEDATE"];
        _KIND =dic[@"KIND"];
        _LICENCEID =dic[@"LICENCEID"];
        _PKID=dic[@"PKID"];
        _VALIDITY =dic[@"VALIDITY"];
    }
    return self;
}
@end
