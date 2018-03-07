//
//  AirEnvironmentCell.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/8.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirEnvironmentCell : UITableViewCell
//标题
@property (nonatomic,strong)UILabel *titleLab;
//pm2.5的值
@property (nonatomic,strong)UILabel *PMLab;
//主要污染物
@property (nonatomic,strong)UILabel *backLab;
//排名
@property (nonatomic,strong)UILabel *numLab;

@end
