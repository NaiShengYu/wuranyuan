//
//  EmissionPermitManagementInfoModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "EmissionPermitManagementInfoModel.h"

@implementation EmissionPermitManagementInfoModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
        _ID=dic[@"ID"];
        _address =dic[@"address"];
        _code =dic[@"code"];
        _credit_no =dic[@"credit_no"];
        _enddate=dic[@"enddate"];
        _enterid=dic[@"enterid"];
        _industry =dic[@"industry"];
        _issuedate =dic[@"issuedate"];
        _issuing =dic[@"issuing"];
        _legal =dic[@"legal"];
        _name =dic[@"name"];
        _registerAdd =dic[@"registerAdd"];
        _startdate =dic[@"startdate"];
        _state =dic[@"state"];
    }
    return self;
}
@end
