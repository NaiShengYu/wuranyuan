//
//  PollutionSouceModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/28.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PollutionSouceModel : NSObject
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *lat;
@property (nonatomic,copy)NSString *lng;
@property (nonatomic,copy)NSString *stvalue;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *value;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *count;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
