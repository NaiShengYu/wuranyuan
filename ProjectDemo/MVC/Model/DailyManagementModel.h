//
//  DailyManagementModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/30.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyManagementModel : NSObject

@property (nonatomic,copy)NSString *CONTEXT;
@property (nonatomic,copy)NSString *IMPROVECONTEXT;
@property (nonatomic,copy)NSString *RN;
@property (nonatomic,copy)NSString *SUPERVISEDATE;
@property (nonatomic,copy)NSString *SUPERVISOR;



- (instancetype)initWithDic:(NSDictionary *)dic;

@end
