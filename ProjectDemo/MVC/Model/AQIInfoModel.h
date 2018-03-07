//
//  AQIInfoModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/23.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AQIInfoModel : NSObject
@property (nonatomic,copy)NSString *AQI;
@property (nonatomic,copy)NSString *AQIClass;
@property (nonatomic,copy)NSString *AQIColor;
@property (nonatomic,copy)NSString *AQILevel;
@property (nonatomic,copy)NSString *Health;
@property (nonatomic,copy)NSString *Idx;
@property (nonatomic,copy)NSString *Suggestion;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
