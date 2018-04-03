//
//  EmissionPermitManagementCell.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmissionPermitManagementModel.h"
@interface EmissionPermitManagementCell : UITableViewCell
/*
 * 许可证编号
 */
@property (nonatomic,strong)UILabel *lab1;
/*
 * 许可证种类
 */
@property (nonatomic,strong)UILabel *lab2;
/*
 * 发证日期
 */
@property (nonatomic,strong)UILabel *lab3;
/*
 * 有效期
 */
@property (nonatomic,strong)UILabel *lab4;

@property (nonatomic,strong)EmissionPermitManagementModel *model;

@end
