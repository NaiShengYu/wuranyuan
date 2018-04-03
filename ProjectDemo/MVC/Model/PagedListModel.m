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
     
        _StationId =dic[@"StationId"];
        _StationLat =dic[@"StationLat"];
        _StationLng =dic[@"StationLng"];
        _StationName =dic[@"StationName"];
        _factorModelArray =[[NSMutableArray alloc]init];

        if (![dic[@"info"] isEqual:[NSNull null]]) {
            _aqiInfoModel =[[PageAQIInfoModel alloc]initWithDic:dic[@"info"]];
            FactorModel *model = [[FactorModel alloc]init];
            model.refid =_aqiInfoModel.facId;
            model.Id =_aqiInfoModel.facId;
            model.val = [NSString stringWithFormat:@"%@ (ug/m3)",_aqiInfoModel.AQI];
            model.name =@"AQI";
            [_factorModelArray addObject:model];
        }
        
    }
    return self;

    
}
@end
