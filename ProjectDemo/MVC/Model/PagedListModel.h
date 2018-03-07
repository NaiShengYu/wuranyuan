//
//  PagedListModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/10.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQIInfoModel.h"
@interface PagedListModel : NSObject

@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *areacode;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *code;
@property (nonatomic,copy)NSString *district;
@property (nonatomic,copy)NSString *Id;
@property (nonatomic,copy)NSString *isauto;
@property (nonatomic,copy)NSString *lat;
@property (nonatomic,copy)NSString *lng;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *province;
@property (nonatomic,copy)NSString *radius;
@property (nonatomic,copy)NSString *refid;
@property (nonatomic,copy)NSString *street;
@property (nonatomic,copy)NSString *subtype;
@property (nonatomic,copy)NSString *type;
@property (nonatomic,strong)AQIInfoModel *aqiModel;

@property (nonatomic,copy)NSString *AQILevel;
@property (nonatomic,assign)CGFloat AQI;
@property (nonatomic,copy)NSString *Health;

@property (nonatomic,copy)NSString *ceshi;


@property (nonatomic,copy)NSString *PM10;
@property (nonatomic,copy)NSString *PM25;
@property (nonatomic,copy)NSString *CO;
@property (nonatomic,copy)NSString *O3;


@property (nonatomic,strong)NSMutableArray *factorModelArray;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
