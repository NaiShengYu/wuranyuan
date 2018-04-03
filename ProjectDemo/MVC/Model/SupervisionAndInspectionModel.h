//
//  SupervisionAndInspectionModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/30.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SupervisionAndInspectionModel : NSObject
@property (nonatomic,copy)NSString *CHECKPERSON;
@property (nonatomic,copy)NSString *FLAG;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *INPUTUSER;
@property (nonatomic,copy)NSString *MONITORDATE;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *RESULT;
@property (nonatomic,copy)NSString *RN;
@property (nonatomic,copy)NSString *TEMPLATEID;



- (instancetype)initWithDic:(NSDictionary *)dic;

@end
