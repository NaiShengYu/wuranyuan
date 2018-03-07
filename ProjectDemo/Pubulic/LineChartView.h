//
//  LineChartView.h
//  NewLineChart
//
//  Created by Nasheng Yu on 2018/2/23.
//  Copyright © 2018年 Nasheng Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineChartView : UIView

/*
 * X坐标轴刻度
 */
@property (nonatomic,strong)NSMutableArray *xArray;
/*
 * Y坐标轴刻度
 */
@property (nonatomic,strong)NSMutableArray *yArray;

/*
 *  数据坐标
 */
@property (nonatomic,strong)NSMutableArray *dataArray;
/*
 *  X坐标轴名称
 */
@property (nonatomic,copy)NSString *xLab;

/*
 *  Y坐标轴名称
 */
@property (nonatomic,copy)NSString *yLab;
/*
 *  Y坐标上限
 */
@property (nonatomic,assign)CGFloat toplimit;

@property (nonatomic,strong)NSDate *currentDate;

@end
