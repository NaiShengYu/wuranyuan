//
//  AirEnvironmentFooter.h
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/8.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FactorModel.h"
#import "FactorDataModel.h"
#import "PagedListModel.h"
#import "LineChartView.h"
@interface AirEnvironmentFooter : UITableViewHeaderFooterView



@property (nonatomic,strong)LineChartView *lineChart;

@property (nonatomic,strong)PagedListModel *pageModel;
@property (nonatomic,strong)FactorModel *currentModel;


@end
