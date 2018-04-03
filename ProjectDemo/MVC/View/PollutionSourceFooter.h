//
//  PollutionSourceFooter.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/29.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LineChartView.h"

#import "YinZiModel.h"
#import "PaiKouModel.h"
@interface PollutionSourceFooter : UIView



@property (nonatomic,strong)LineChartView *lineChart;

@property (nonatomic,strong)YinZiModel *yiZiModel;
@property (nonatomic,strong)PaiKouModel *paiKouModel;

@end
