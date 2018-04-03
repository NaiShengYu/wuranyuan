//
//  MonitorViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "MonitorViewController.h"
#import "MonitorCell.h"

#import "ProjectApprovalViewController.h"//项目审批
#import "EmissionPermitManagementViewController.h"//排污许可证管理
#import "LettersAndVisitsViewController.h"//信访管理
#import "DailyManagementViewController.h"//日常监管
#import "ElectronicPunishmentViewController.h"//电子处罚
#import "SupervisionAndInspectionViewController.h"//监督检查
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
    
    self.dataArray =[[NSMutableArray alloc]initWithObjects:@"项目审批",@"排污许可证管理",@"信访管理",@"日常监管",@"电子处罚",@"监督检查", nil];
    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            {
                ProjectApprovalViewController *projectVC =[[ProjectApprovalViewController alloc]init];
                projectVC.souceModel =self.souceModel;
                [self.navigationController pushViewController:projectVC animated:YES];                
            }
            break;
        case 1:
        {
            EmissionPermitManagementViewController *projectVC =[[EmissionPermitManagementViewController alloc]init];
            projectVC.souceModel =self.souceModel;
            [self.navigationController pushViewController:projectVC animated:YES];
        }
            break;
        case 2:
        {
            LettersAndVisitsViewController *projectVC =[[LettersAndVisitsViewController alloc]init];
            projectVC.souceModel =self.souceModel;
            [self.navigationController pushViewController:projectVC animated:YES];
        }
            break;
        case 3:
        {
            DailyManagementViewController *projectVC =[[DailyManagementViewController alloc]init];
            projectVC.souceModel =self.souceModel;
            [self.navigationController pushViewController:projectVC animated:YES];
        }
            break;
        case 4:
        {
            ElectronicPunishmentViewController *projectVC =[[ElectronicPunishmentViewController alloc]init];
            projectVC.souceModel =self.souceModel;
            [self.navigationController pushViewController:projectVC animated:YES];
        }
            break;
        case 5:
        {
            SupervisionAndInspectionViewController *projectVC =[[SupervisionAndInspectionViewController alloc]init];
            projectVC.souceModel =self.souceModel;
            [self.navigationController pushViewController:projectVC animated:YES];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark --自定义导航栏
- (void)customNavigationBar{
    self.title =@"360监控";
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.navigationController.navigationBar.hidden =NO;
    self.tabBarController.tabBar.hidden =YES;
    
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"45"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];    leftBarButtonItem.imageInsets =UIEdgeInsetsMake(0, -10, 0, 10);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
