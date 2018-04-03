//
//  YinZiModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/29.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YinZiModel : NSObject
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *lowvalue;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *unit;
@property (nonatomic,copy)NSString *upvalue;
@property (nonatomic,copy)NSString *value;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
