//
//  CustomAccount.h
//  edrs
//
//  Created by 余文君, July on 15/8/17.
//  Copyright (c) 2015年 julyyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomAccount : NSObject

/**
 *   秘钥
 */
@property (nonatomic,copy)NSString *accessToken;
/**
 *   用户id
 */
@property (nonatomic,copy)NSString *userId;
/**
 *   纬度
 */
@property (nonatomic,copy)NSString *UserLatitude;
/**
 *   经度
 */
@property (nonatomic,copy)NSString *userLongitude;

/**
 *   用户名称
 **/
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *phoneNumber;
@property (nonatomic,copy)NSString *isActive;
/**
 *   全称
 **/

@property (nonatomic,copy)NSString *fullName;

/**
 *   是否是管理员
 **/

@property (nonatomic,assign)BOOL isAdministrators;

@property (nonatomic,copy)NSString *stationUrl;

+(CustomAccount *)sharedCustomAccount;


@end
