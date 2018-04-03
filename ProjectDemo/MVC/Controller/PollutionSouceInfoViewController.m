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
#import "PollutionSourceFooter.h"
#import "MonitorViewController.h"

#import "PaiKouModel.h"
#import "YinZiModel.h"
@interface PollutionSouceInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTable;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)PollutionSourceFooter *footerView;


@end

@implementation PollutionSouceInfoViewController

- (UITableView *)myTable{
    if (!_myTable) {
        
        _myTable =[[UITableView alloc]initWithFrame:CGRectMake(0, StartBarHeight, screenWigth, screenHeight-StartBarHeight-(imgHeght(200)+30+40)) style:UITableViewStyleGrouped];
        _myTable.delegate =self;
        _myTable.dataSource =self;
        [PubulicObj judgeSystemVersionWithTableView:_myTable];
        [_myTable registerClass:[AirEnvironmentCell class] forCellReuseIdentifier:@"AirEnvironmentCell"];
        [_myTable registerClass:[PollutionSourceHeader class] forHeaderFooterViewReuseIdentifier:@"PollutionSourceHeader"];
    }
    return _myTable;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray =[[NSMutableArray alloc]init];
    
    self.view.backgroundColor =[UIColor whiteColor];
    _footerView =[[PollutionSourceFooter alloc]init];
    _footerView.frame =CGRectMake(0, screenHeight-(imgHeght(200)+30+40), screenWigth, imgHeght(200)+30+40);
    [self.view addSubview:_footerView];
    [self.view addSubview:self.myTable];
    [self customNavigationBar];
    [self makeData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    PaiKouModel *paikouModel =self.dataArray[section];
    return paikouModel.yinZiArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
//    UILabel *lab =[[UILabel alloc]init];
//    lab.numberOfLines =0;
//    lab.lineBreakMode =NSLineBreakByWordWrapping;
////    lab.text =self.message;
//    lab.font =FontSize(14);
//    CGSize size =[lab sizeThatFits:CGSizeMake(screenWigth-100, MAXFLOAT)];
//    CGFloat H =size.height+35;
//    if (H <40) {
//        H=40;
//    }
//    return H+30;
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PollutionSourceHeader *header =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"PollutionSourceHeader"];

    PaiKouModel *paikouModel =self.dataArray[section];
    header.name.text =[NSString stringWithFormat:@"%@(%@)",paikouModel.typeName,paikouModel.name];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PaiKouModel *paikouModel =self.dataArray[indexPath.section];
    YinZiModel *yinzi = paikouModel.yinZiArray[indexPath.row];
    
    AirEnvironmentCell *cell =[tableView dequeueReusableCellWithIdentifier:@"AirEnvironmentCell" forIndexPath:indexPath];
//    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.accessoryType =UITableViewCellAccessoryNone;
    cell.titleLab.text =yinzi.name;
    cell.backLab.hidden =YES;
    cell.PMLab.text =[NSString stringWithFormat:@"%@",yinzi.value];
    [cell.PMLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView).offset =5;
        make.right.equalTo(cell.contentView).offset =-10;
        make.bottom.equalTo(cell.contentView).offset =-5;
        make.width.mas_lessThanOrEqualTo(screenWigth/2);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PaiKouModel *paikouModel =self.dataArray[indexPath.section];
    YinZiModel *yinzi = paikouModel.yinZiArray[indexPath.row];
    _footerView.paiKouModel =paikouModel;
    _footerView.yiZiModel =yinzi;
    
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
//    self.title =@"污染源在线";
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.navigationController.navigationBar.hidden =NO;
    self.tabBarController.tabBar.hidden =YES;
    
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"45"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];    leftBarButtonItem.imageInsets =UIEdgeInsetsMake(0, -10, 0, 10);

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    UIBarButtonItem* rithtBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"360监控" style:UIBarButtonItemStylePlain target:self action:@selector(goMonitorViewController)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rithtBarButtonItem;
    
}

- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goMonitorViewController{
    MonitorViewController *monitorVC =[[MonitorViewController alloc]init];
    monitorVC.souceModel =self.souceModel;
    [self.navigationController pushViewController:monitorVC animated:YES];
}

#pragma mark 获得排口列表
- (void)makeData{
    
    NSString *urlStr =[NSString stringWithFormat:@"%@api/AppEnterprise/GetEnterprisePort?id=%@",BASEURL,self.souceModel.ID];
    
    WS(blockSelf);
    
    [AFNetRequest HttpGetCallBack:urlStr Parameters:nil success:^(id responseObject) {
        DLog(@"responseObject===%@",responseObject);
        for (NSDictionary *dic in responseObject) {
            PaiKouModel *model =[[PaiKouModel alloc]initWithDic:dic];
            [blockSelf.dataArray addObject:model];
            [blockSelf getYinZiLieBiaoWithModel:model];
        }
    } failure:^(NSError *error) {
        
    } isShowHUD:YES];
    
}

- (void)getYinZiLieBiaoWithModel:(PaiKouModel *)model{
    
    NSString *urlStr =[NSString stringWithFormat:@"%@api/AppEnterprise/GetPortOnlinelast?id=%@",BASEURL,model.ID];
    WS(blockSelf);
    [AFNetRequest HttpGetCallBack:urlStr Parameters:nil success:^(id responseObject) {
        DLog(@"responseObject===%@",responseObject);
        for (NSDictionary *dic in responseObject) {
            YinZiModel *yinZiModel =[[YinZiModel alloc]initWithDic:dic];
            [model.yinZiArray addObject:yinZiModel];
        }
        [blockSelf.myTable reloadData];
        
        if (model == blockSelf.dataArray[0]) {
            if (model.yinZiArray.count >0) {
                [blockSelf tableView:blockSelf.myTable didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            }
        }
        
    } failure:^(NSError *error) {
        
    } isShowHUD:YES];
    
}

@end

