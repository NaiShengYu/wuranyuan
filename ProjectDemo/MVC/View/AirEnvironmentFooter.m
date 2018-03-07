//
//  AirEnvironmentFooter.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/8.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "AirEnvironmentFooter.h"

@interface AirEnvironmentFooter ()
{
    NSDate*nowDate;
    
}
@property (nonatomic,strong) UIScrollView *scr ;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *nameArray;
@property (nonatomic,assign)NSInteger segementIndex;

@property (nonatomic,strong)NSMutableArray *timeArray;
@property (nonatomic,strong)NSMutableArray *dateArray;
@end
@implementation AirEnvironmentFooter

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.dataArray =[[NSMutableArray alloc]init];
        self.nameArray =[[NSMutableArray alloc]init];
        _scr =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, screenWigth, imgHeght(200)+20)];
        _scr.contentSize =CGSizeMake(960, imgHeght(200));
        [self.contentView addSubview:_scr];
        _segementIndex =0;
        UISegmentedControl *seagment =[[UISegmentedControl alloc]initWithItems:@[@"24小时",@"30天"]];
        seagment.frame =CGRectMake(screenWigth-120, 10, 110, 35);
        seagment.selectedSegmentIndex =0;
        [self.contentView addSubview:seagment];
        [seagment addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventValueChanged];
        
        
        nowDate =[PubulicObj getNowDateWithDate:[NSDate date]];
        _timeArray =[[NSMutableArray alloc]init];
        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
        formatter.dateFormat =@"HH:00";
        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        for (int i =1; i <=24; i ++) {
            NSDate *lastDate = [[NSDate alloc]initWithTimeInterval:-60*60*(24-i) sinceDate:nowDate];
            [_timeArray addObject:[formatter stringFromDate:lastDate]];
        }
        
        _dateArray =[[NSMutableArray alloc]init];
        NSDateFormatter *formatter1 =[[NSDateFormatter alloc]init];
        formatter1.dateFormat =@"YYYY-MM-dd";
        [formatter1 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        for (int i =1; i <=30; i ++) {
            NSDate *lastDate = [[NSDate alloc]initWithTimeInterval:-60*60*24*(30-i) sinceDate:nowDate];
            
            [_dateArray addObject:[formatter1 stringFromDate:lastDate]];
        }
        
        
    }
    
    return self;
    
    
    
}
- (void)changeSelect:(UISegmentedControl *)segment{
    
    DLog(@"%ld",(long)segment.selectedSegmentIndex);
    
    self.segementIndex = segment.selectedSegmentIndex;
//    blockSelf.lineChart.xLabels =blockSelf.nameArray;
 
    [self getHoursData];
    
    
    
}

- (void)setCurrentModel:(FactorModel *)currentModel{
    if (_currentModel ==currentModel) {
        return;
    }
    _currentModel =currentModel;
    
    [self getHoursData];
}

- (void)creatLine{
    
    NSInteger num = self.segementIndex ==0 ?24:30;
    CGFloat w =self.segementIndex ==0?40:70;
    _lineChart =[[LineChartView alloc]initWithFrame:CGRectMake(5, 10,  num*w+30+40+10, imgHeght(200))];
    _scr.contentSize=CGSizeMake(num *w+30+40+10, imgHeght(200));
    self.lineChart.xArray =self.segementIndex==0?self.timeArray:self.dateArray;
    self.lineChart.xLab =self.segementIndex ==0?@"时间":@"日期";
    self.lineChart.yLab =[NSString stringWithFormat:@"%@ ug/m3",self.currentModel.name];
    self.lineChart.currentDate =nowDate;
    [_scr addSubview:_lineChart];

}

#pragma mark --获取24小时数据
- (void)getHoursData{
 
    
    NSDate*nowDate =[PubulicObj getNowDateWithDate:[NSDate date]];
    NSDate *lastDate = [[NSDate alloc]initWithTimeInterval:-60*60*24 sinceDate:nowDate];
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    formatter.dateFormat =@"YYYY-MM-dd";
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    NSString *nowTime =[formatter stringFromDate:nowDate];
    NSString *lastTime = [formatter stringFromDate:lastDate];
    
    
    NSString *urlstr = [NSString stringWithFormat:@"%@api/FactorData/GetFactVal?refId=%@&fromType=0&dType=H&vType=0&facId=%@&dataType=0&sDate=%@&eDate=%@",BASEURL,self.pageModel.Id,_currentModel.Id,nowTime,nowTime];
    
    if (self.segementIndex ==1) {
        lastDate = [[NSDate alloc]initWithTimeInterval:-60*60*24*30 sinceDate:nowDate];
        lastTime = [formatter stringFromDate:lastDate];
        urlstr = [NSString stringWithFormat:@"%@api/FactorData/GetFactVal?refId=%@&fromType=0&dType=D&vType=0&facId=%@&dataType=0&sDate=%@&eDate=%@",BASEURL,self.pageModel.Id,_currentModel.Id,lastTime,nowTime];
    }
    //    [parame setObject:lastTime forKey:@"sDate"];
    //    [parame setObject:nowTime forKey:@"eDate"];
    WS(blockSelf);
    [AFNetRequest HttpGetCallBack:urlstr Parameters:nil success:^(id responseObject) {
        [blockSelf.dataArray removeAllObjects];
        [blockSelf.nameArray removeAllObjects];
        NSMutableArray *numArray =[[NSMutableArray alloc]init];
//        NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
//        formatter.dateFormat =@"yyyy-mm-dd HH";
        for (NSDictionary *dic in responseObject) {
            FactorDataModel *dataModel =[[FactorDataModel alloc]initWithDic:dic];
            NSMutableDictionary *dataDic =[[NSMutableDictionary alloc]init];
          
            [dataDic setObject:dataModel.val forKey:@"y"];
            
//            NSDate *date =[formatter dateFromString:dataModel.name];
            
//            [dataDic setObject:dataModel.name forKey:@"x"];
            if (blockSelf.segementIndex==0) {
                [dataDic setObject:[NSString stringWithFormat:@"2018-2-24 %lu",(unsigned long)numArray.count] forKey:@"x"];
            }else{
                [dataDic setObject:[NSString stringWithFormat:@"2018-1-2%lu",numArray.count+6] forKey:@"x"];
            }
            [blockSelf.nameArray addObject:dataModel.val];
            [numArray addObject:dataDic];
        }
        CGFloat maxValue = [[blockSelf.nameArray valueForKeyPath:@"@max.floatValue"] floatValue];
        CGFloat minValue = [[blockSelf.nameArray valueForKeyPath:@"@min.floatValue"] floatValue];
        maxValue =maxValue==0?1:maxValue+maxValue*0.05;
        minValue =minValue-minValue*0.05;
        CGFloat cha =(maxValue -minValue)/4;
        NSMutableArray *lineY =[[NSMutableArray alloc]init];
        for (int i =0; i <5; i ++) {
            [lineY addObject:[NSString stringWithFormat:@"%.2f",minValue +cha*i]];
        }
       
        [blockSelf.lineChart removeFromSuperview];
        [blockSelf creatLine];
        blockSelf.lineChart.toplimit =maxValue;
        blockSelf.lineChart.yArray =lineY;
        blockSelf.lineChart.dataArray =numArray;
        
    } failure:^(NSError *error) {
        
    } isShowHUD:YES];
    
}




@end
