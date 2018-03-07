//
//  MonitorViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "MonitorViewController.h"
#import "MonitorCell.h"
@interface MonitorViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *myTable;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation MonitorViewController

- (UITableView *)myTable{
    if (!_myTable) {
        _myTable =[[UITableView alloc]initWithFrame:CGRectMake(0, StartBarHeight, screenWigth, screenHeight-StartBarHeight) style:UITableViewStyleGrouped];
        [PubulicObj judgeSystemVersionWithTableView:_myTable];
        _myTable.delegate =self;
        _myTable.dataSource =self;
        [_myTable registerClass:[MonitorCell class] forCellReuseIdentifier:@"MonitorCell"];
        
    }
    return _myTable;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray =[[NSMutableArray alloc]initWithObjects:@"项目审批",@"排污许可证管理",@"信访管理",@"日常监管",@"电子处罚",@"应急预案",@"监督检查",@"其他附件", nil];
    
    
    [self.view addSubview:self.myTable];
    [self customNavigationBar];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MonitorCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MonitorCell" forIndexPath:indexPath];
    cell.textLabel.text =self.dataArray[indexPath.row];
    if (indexPath.row ==2) {
        cell.stateLab.hidden =NO;
        cell.stateLab.text =@"1";
    }else{
        cell.stateLab.hidden =YES;
        cell.stateLab.text =@"";
        
    }
    return cell;
}




#pragma mark --自定义导航栏
- (void)customNavigationBar{
    self.title =@"360监控";
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
