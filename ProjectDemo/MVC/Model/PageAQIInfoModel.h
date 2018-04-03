//
//  PageAQIInfoModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/20.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQIInfoModel.h"
@interface PageAQIInfoModel : NSObject
@property (nonatomic,copy)NSString *AQI;
@property (nonatomic,copy)NSString *PM25;
@property (nonatomic,copy)NSString *facId;
@property (nonatomic,copy)NSString *facName;

@property (nonatomic,strong)AQIInfoModel *aqiModel;

- (instancetype)initWithDic:(NSDictionary *)dic;
@end
