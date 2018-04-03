//
//  EmissionPermitManagementModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/30.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmissionPermitManagementModel : NSObject
@property (nonatomic,copy)NSString *ISSUEDATE;
@property (nonatomic,copy)NSString *KIND;
@property (nonatomic,copy)NSString *LICENCEID;
@property (nonatomic,copy)NSString *PKID;
@property (nonatomic,copy)NSString *VALIDITY;
@property (nonatomic,copy)NSString *ID;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
