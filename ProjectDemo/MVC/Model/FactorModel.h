//
//  FactorModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/23.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FactorModel : NSObject
@property (nonatomic,copy)NSString *catId;
@property (nonatomic,copy)NSString *catIdx;
@property (nonatomic,copy)NSString *datatype;
@property (nonatomic,copy)NSString *facttype;
@property (nonatomic,copy)NSString *Id;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *refid;
@property (nonatomic,copy)NSString *val;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
