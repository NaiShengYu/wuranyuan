//
//  EmissionPermitManagementInfoModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmissionPermitManagementInfoModel : NSObject
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *code;
@property (nonatomic,copy)NSString *credit_no;
@property (nonatomic,copy)NSString *enddate;
@property (nonatomic,copy)NSString *enterid;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *industry;
@property (nonatomic,copy)NSString *issuedate;
@property (nonatomic,copy)NSString *issuing;
@property (nonatomic,copy)NSString *legal;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *registerAdd;
@property (nonatomic,copy)NSString *startdate;
@property (nonatomic,copy)NSString *state;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
