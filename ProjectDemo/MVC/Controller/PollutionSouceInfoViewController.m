//
//  AirEnVironmentInfoViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/8.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "PollutionSouceInfoViewController.h"
#import "AirEnvironmentCell.h"
#import "PollutionSourceHeader.h"
#import "AirEnvironmentFooter.h"
#import "MonitorViewController.h"

@interface PollutionSouceInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTable;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)NSDictionary *dic;

@property (nonatomic,copy)NSString *message;

@end

@implementation PollutionSouceInfoViewController

- (UITableView *)myTable{
    if (!_myTable) {
        
        _myTable =[[UITableView alloc]initWithFrame:CGRectMake(0, StartBarHeight, screenWigth, screenHeight-StartBarHeight) style:UITableViewStyleGrouped];
        _myTable.delegate =self;
        _myTable.dataSource =self;
        [PubulicObj judgeSystemVersionWithTableView:_myTable];
        [_myTable registerClass:[AirEnvironmentCell class] forCellReuseIdentifier:@"AirEnvironmentCell"];
        [_myTable registerClass:[PollutionSourceHeader class] forHeaderFooterViewReuseIdentifier:@"PollutionSourceHeader"];
        [_myTable registerClass:[AirEnvironmentFooter class] forHeaderFooterViewReuseIdentifier:@"AirEnvironmentFooter"];        
        
    }
    return _myTable;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray =[[NSMutableArray alloc]init];
    //    for (NSInteger i =0 ; i <10; i ++) {
    //        CGFloat a = arc4random()%100;
    //        NSString *pm =[NSString stringWithFormat:@"%.1f",a];
    //        DLog(@"a==%f,pm===%@",a,pm);
    //
    //        NSDictionary *dic =@{@"address":@"中科路",@"PM":pm};
    //        [self.dataArray addObject:dic];
    //
    //    }
    self.message =@"当前空气质量为良，空气质量可接受，但某些污染物可能对极少数异常敏感人群健康有较弱影响。建议：极少数异常敏感人群应减少户外活动";
    
    self.dic =@{@"AQI":@"63",@"PM2.5":@"52.989ug/m3",@"PM10":@"91,69ug/m3",@"CO":@"4.12ug/m3",@"CO2":@"2.01ug/m3"};
    
    [self.view addSubview:self.myTable];
    [self customNavigationBar];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dic.allKeys.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    UILabel *lab =[[UILabel alloc]init];
    lab.numberOfLines =0;
    lab.lineBreakMode =NSLineBreakByWordWrapping;
    lab.text =self.message;
    lab.font =FontSize(14);
    CGSize size =[lab sizeThatFits:CGSizeMake(screenWigth-100, MAXFLOAT)];
    CGFloat H =size.height+35;
    if (H <40) {
        H=40;
    }
    return H+30;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return imgHeght(200)+30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PollutionSourceHeader *header =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"PollutionSourceHeader"];
    header.titleLab.text =@"1#排水口PH超标";
    header.infoLab.text =self.message;
    WS(blockSelf);
    [[header.but rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [blockSelf.navigationController pushViewController:[MonitorViewController new] animated:YES];
        
    }];
    
    return header;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AirEnvironmentCell *cell =[tableView dequeueReusableCellWithIdentifier:@"AirEnvironmentCell" forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.accessoryType =UITableViewCellAccessoryNone;
    cell.titleLab.text =self.dic.allKeys[indexPath.row];
    cell.PMLab.text =self.dic[self.dic.allKeys[indexPath.row]];
    [cell.PMLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView).offset =5;
        make.right.equalTo(cell.contentView).offset =-10;
        make.bottom.equalTo(cell.contentView).offset =-5;
        make.width.mas_lessThanOrEqualTo(90);
    }];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    AirEnvironmentFooter *footer =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AirEnvironmentFooter"];
    
    
    
    return footer;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
}

#pragma mark --让cell的横线到最左边
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark --自定义导航栏
- (void)customNavigationBar{
    self.title =@"污染源在线";
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.navigationController.navigationBar.hidden =NO;
    self.tabBarController.tabBar.hidden =YES;
    
    UIButton *img =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
    [img addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [img setImage:[PubulicObj changeImage:[UIImage imageNamed:@"45"] WithSize:CGSizeMake(18, 18)]
         forState:UIControlStateNormal];
    [img setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    UIBarButtonItem *left =[[UIBarButtonItem alloc]initWithCustomView:img];
    left.tintColor =[UIColor lightGrayColor];
    self.navigationItem.leftBarButtonItem =left;
}

- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

