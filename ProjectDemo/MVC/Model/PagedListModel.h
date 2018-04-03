//
//  PagedListModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/10.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageAQIInfoModel.h"
#import "FactorModel.h"
@interface PagedListModel : NSObject

@property (nonatomic,copy)NSString *StationId;
@property (nonatomic,copy)NSString *StationLat;
@property (nonatomic,copy)NSString *StationLng;
@property (nonatomic,copy)NSString *StationName;

@property (nonatomic,assign)CGFloat AQI;

@property (nonatomic,assign)CGFloat PM25;

@property (nonatomic,assign)CGFloat PM10;

@property (nonatomic,assign)CGFloat O3;

@property (nonatomic,assign)CGFloat CO;


@property (nonatomic,strong)PageAQIInfoModel *aqiInfoModel;


@property (nonatomic,strong)NSMutableArray *factorModelArray;



- (instancetype)initWithDic:(NSDictionary *)dic;

@end
