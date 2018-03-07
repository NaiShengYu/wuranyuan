//
//  PollutionSourceHeader.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/9.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PollutionSourceHeader : UITableViewHeaderFooterView
//标题
@property (nonatomic,strong)UILabel *titleLab;

//企业详情介绍
@property (nonatomic,strong)UILabel *infoLab;

//360监控按钮
@property (nonatomic,strong)UIButton *but;


@end
