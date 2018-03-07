//
//  PagedListModel.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/10.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "PagedListModel.h"

@implementation PagedListModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    
    self =[super init];
    if (self) {
        _address =dic[@"address"];
        _areacode =dic[@"areacode"];
        _city =dic[@"city"];
        _code =dic[@"code"];
        _Id =dic[@"id"];
        _isauto =dic[@"isauto"];
        _lat =dic[@"lat"];
        _lng =dic[@"lng"];
        _name =dic[@"name"];
        _province =dic[@"province"];
        _radius =dic[@"radius"];
        _refid =dic[@"refid"];
        _address =dic[@"address"];
        _street =dic[@"street"];
        _subtype =dic[@"subtype"];
        _type =dic[@"type"];

        _PM10 =@"0";
        _PM25 =@"0";
        _O3 =@"0";
        _CO =@"0";
        _AQI =0;
        _AQILevel =@"";
        _Health =@"";
        _factorModelArray =[[NSMutableArray alloc]init];
    }
    return self;

    
}
@end
