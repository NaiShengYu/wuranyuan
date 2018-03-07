//
//  LineChartView.m
//  NewLineChart
//
//  Created by Nasheng Yu on 2018/2/23.
//  Copyright © 2018年 Nasheng Yu. All rights reserved.
//

#import "LineChartView.h"

//左距离
#define leftDistance 30
//下距离
#define bottomeDistance 30
//上距离
#define topDistance 30
//柱形图宽度
#define histogramW 15

//主要颜色
#define myColor zhuse



//X轴单位长度
@interface LineChartView()
{
    CGFloat Xwight;
}
@end


@implementation LineChartView


- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor blackColor];
        self.toplimit =1;
  
    }
    return self;
  
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray =dataArray;
    [self setNeedsDisplay];
 
}



- (void)drawRect:(CGRect)rect {
    
    Xwight =self.xArray.count==24?40:70;
    
    UIFont *font =[UIFont systemFontOfSize:10];
    CGFloat viewWight =self.bounds.size.width;//视图总宽度
    CGFloat viewHeight =self.bounds.size.height;//视图总高度
    CGContextRef context =UIGraphicsGetCurrentContext();

    //坐标轴颜色
    CGContextSetStrokeColorWithColor(context, myColor.CGColor);
    //坐标轴线条宽度
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokePath(context);
// 画X坐标轴
    //X轴起始点
    CGContextMoveToPoint(context, leftDistance, viewHeight-bottomeDistance);
   //X轴终点
    CGContextAddLineToPoint(context, viewWight-10, viewHeight-bottomeDistance);
    //X坐标名称
    [self.xLab drawAtPoint:CGPointMake(viewWight-40, viewHeight-bottomeDistance +2) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:myColor}];
    CGContextStrokePath(context);

    //X轴箭头
    CGContextMoveToPoint(context, viewWight-10, viewHeight-bottomeDistance);
    CGContextAddLineToPoint(context, viewWight-15, viewHeight-bottomeDistance-5);
    CGContextMoveToPoint(context, viewWight-10, viewHeight-bottomeDistance);
    CGContextAddLineToPoint(context, viewWight-15, viewHeight-bottomeDistance+5);
    CGContextStrokePath(context);
    
    //Y轴起点
    CGContextMoveToPoint(context, leftDistance, viewHeight-bottomeDistance);
    //Y轴终点
    CGContextAddLineToPoint(context, leftDistance, topDistance);
   //Y轴名称
    [self.yLab drawAtPoint:CGPointMake(leftDistance +8, topDistance) withAttributes:@{NSForegroundColorAttributeName:myColor,NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    CGContextStrokePath(context);
   //Y轴箭头
    CGContextMoveToPoint(context, leftDistance, topDistance);
    CGContextAddLineToPoint(context, leftDistance-5, topDistance+5);
    CGContextMoveToPoint(context, leftDistance, topDistance);
    CGContextAddLineToPoint(context, leftDistance+5, topDistance+5);
    CGContextStrokePath(context);
    
    
    //坐标轴颜色
    CGContextSetStrokeColorWithColor(context, myColor.CGColor);
    //坐标轴线条宽度
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokePath(context);
    //X坐标轴刻度
    for (int i =0 ; i <self.xArray.count; i++) {
        CGContextMoveToPoint(context, leftDistance+30.0 + Xwight*i,viewHeight-bottomeDistance);
        CGContextAddLineToPoint(context, leftDistance+30.0 + Xwight*i, viewHeight-bottomeDistance-5);
        CGContextStrokePath(context);
        
        CGSize size =[self.xArray[i] boundingRectWithSize:CGSizeMake(40, 10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;

        [self.xArray[i] drawAtPoint:CGPointMake(leftDistance+30.0 + Xwight*i-size.width/2, viewHeight-bottomeDistance+5) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:myColor}];
        CGContextStrokePath(context);
    }
    
   //Y轴坐标刻度
    CGFloat verticalH = (viewHeight-bottomeDistance-topDistance-10)/self.yArray.count;
    for (int i =0; i <self.yArray.count ; i ++) {
        CGContextSetStrokeColorWithColor(context, myColor.CGColor);
        
        CGContextMoveToPoint(context, leftDistance, viewHeight-bottomeDistance-verticalH*i-20);
        CGContextAddLineToPoint(context, leftDistance+5, viewHeight-bottomeDistance-verticalH*(i)-20);
        CGContextStrokePath(context);
        
        //纵坐标字符串长度
        CGSize size =[self.yArray[i] boundingRectWithSize:CGSizeMake(40, 10) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        //纵坐标点刻度
        [self.yArray[i] drawAtPoint:CGPointMake(leftDistance-size.width-2, viewHeight-bottomeDistance-verticalH*(i)-7-20) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:myColor}];
        CGContextStrokePath(context);
    }
    //X轴有效刻度总长度
    CGFloat xAllWight =Xwight *self.xArray.count;
    //Y轴有效刻度总长度
    CGFloat yAllHeight =verticalH *(self.yArray.count-1);
    //时间长度
    CGFloat alltime = self.xArray.count ==30? 60*60*24*30:60*60*24;
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    formatter.dateFormat =self.xArray.count ==30? @"yyyy-MM-dd":@"yyyy-MM-dd HH";
    NSString* nowString =[formatter stringFromDate:[NSDate date]];
    NSDate *nowdate =[PubulicObj getNowDateWithDate:[formatter dateFromString:nowString]];
    
    
    //上限虚线
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context, leftDistance, viewHeight-bottomeDistance-20-90);
    CGContextAddLineToPoint(context, viewWight-10, viewHeight-bottomeDistance-20-90);
    //设置虚线排列的宽度间隔，下面的arr中的数字表示先绘制先绘制1个点在绘制1个点
    CGFloat arr[]={4,1};
    //最后一个“1”表示排列的个数
    CGContextSetLineDash(context, 0, arr, 1);
    CGContextDrawPath(context, kCGPathStroke);
    
    //上限虚线
    CGContextMoveToPoint(context, leftDistance, viewHeight-bottomeDistance-20-60);
    CGContextAddLineToPoint(context, viewWight-10, viewHeight-bottomeDistance-20-60);
    //设置虚线排列的宽度间隔，下面的arr中的数字表示先绘制先绘制1个点在绘制1个点
    //最后一个“1”表示排列的个数
    CGContextSetLineDash(context, 0, arr, 1);
    CGContextDrawPath(context, kCGPathStroke);
    
    
    
    
    //具体数据
    CGContextSetStrokeColorWithColor(context, myColor.CGColor);
    if (self.dataArray.count >0) {
        for (int i =0; i <self.dataArray.count ; i ++) {
            if (i <self.dataArray.count-1) {
                NSDictionary *dic0 =self.dataArray[i];
                NSDictionary *dic1 =self.dataArray[i+1];
                NSString *xData0 =dic0[@"x"];
                NSString *yData0 =dic0[@"y"];
                NSString *xData1 =dic1[@"x"];
                NSString *yData1 =dic1[@"y"];
                NSDate *date0 =[PubulicObj getNowDateWithDate:[formatter dateFromString:xData0]];
                NSDate *date1 =[PubulicObj getNowDateWithDate:[formatter dateFromString:xData1]];
                NSTimeInterval time0 = [nowdate timeIntervalSinceDate:date0];
                NSTimeInterval time1 = [nowdate timeIntervalSinceDate:date1];
                NSTimeInterval startTime =self.xArray.count ==30? (time0+60*60*24):time0+60*60;
                NSTimeInterval endTime =self.xArray.count ==30? (time1+60*60*24):time1+60*60;
                
                CGContextMoveToPoint(context, leftDistance+30.0 +(1-startTime/alltime)*xAllWight, viewHeight-([yData0 floatValue]/self.toplimit*yAllHeight)-bottomeDistance-20);
                
                CGContextAddLineToPoint(context, leftDistance+30.0 +(1-endTime/alltime)*xAllWight, viewHeight-([yData1 floatValue]/self.toplimit*yAllHeight)-bottomeDistance-20);
                CGContextStrokePath(context);
    

            }
        }
  
    }
    
    
    
    
    

}


@end
