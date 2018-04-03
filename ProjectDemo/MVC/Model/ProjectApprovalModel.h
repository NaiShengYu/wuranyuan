//
//  ProjectApprovalModel.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/30.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectApprovalModel : NSObject
@property (nonatomic,copy)NSString *CLOSECASEDATE;
@property (nonatomic,copy)NSString *CLOSECASESTATE;
@property (nonatomic,copy)NSString *ENDLINEDATE;
@property (nonatomic,copy)NSString *FileData;
@property (nonatomic,copy)NSString *ORDERDATE;
@property (nonatomic,copy)NSString *STATEDESC;
@property (nonatomic,copy)NSString *TITLE;
@property (nonatomic,copy)NSString *ID;


- (instancetype)initWithDic:(NSDictionary *)dic;

@end
