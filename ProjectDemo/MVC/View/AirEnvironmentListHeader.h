//
//  AirEnvironmentListHeader.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/2/12.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirEnvironmentListHeader : UITableViewHeaderFooterView

//站点名称
@property (nonatomic,strong)UILabel *addressNameLab;
//首要污染物
@property (nonatomic,strong)UILabel *contaminantNameLab;
//aqi值
@property (nonatomic,strong)UILabel *AQINumLab;
//排名
@property (nonatomic,strong)UILabel *numLab;



@end
