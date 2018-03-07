//
//  FactorDataModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/23.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FactorDataModel : NSObject
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *val;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
