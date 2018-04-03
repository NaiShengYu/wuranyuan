//
//  DailyManagementCell.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyManagementModel.h"
@interface DailyManagementCell : UITableViewCell
/*
 * 执法时间
 */
@property (nonatomic,strong)UILabel *lab1;
/*
 * 执法人员
 */
@property (nonatomic,strong)UILabel *lab2;
/*
 * 执法内容
 */
@property (nonatomic,strong)UILabel *lab3;
/*
 * 执法要求
 */
@property (nonatomic,strong)UILabel *lab4;

@property (nonatomic,strong)DailyManagementModel *model;

@end
