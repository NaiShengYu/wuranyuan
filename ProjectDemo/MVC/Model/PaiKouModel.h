//
//  PaiKouModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/28.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PaiKouModel : NSObject
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *ptype;
@property (nonatomic,copy)NSString *typeName;
@property (nonatomic,strong)NSMutableArray *yinZiArray;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
