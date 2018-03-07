//
//  AirEnvironmentViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/8.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "AirEnvironmentViewController.h"
#import "AirEnvironmentListHeader.h"
#import "AirEnvironmentCell.h"
#import "AirEnVironmentInfoViewController.h"
#import "PagedListModel.h"
#import "CustomeSearchView.h"//自定义搜索框
#import "MapViewController.h"//地图
#import "FactorModel.h"
#import "AQIInfoModel.h"
@interface AirEnvironmentViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic,strong)UITableView *myTable;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)NSString *searchKey;

@property (nonatomic,strong)UIButton *pmBut;
@property (nonatomic,strong)UIButton *aqiBut;


@end

@implementation AirEnvironmentViewController

- (UITableView *)myTable{
    if (!_myTable) {
        _myTable =[[UITableView alloc]initWithFrame:CGRectMake(0, StartBarHeight, screenWigth, screenHeight-StartBarHeight-SafeAreaBottomHeight-49) style:UITableViewStyleGrouped];
        _myTable.delegate =self;
        _myTable.dataSource =self;
        [PubulicObj judgeSystemVersionWithTableView:_myTable];
        [_myTable registerClass:[AirEnvironmentCell class] forCellReuseIdentifier:@"AirEnvironmentCell"];
        [_myTable registerClass:[AirEnvironmentListHeader class] forHeaderFooterViewReuseIdentifier:@"AirEnvironmentListHeader"];
      
    }
    return _myTable;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.searchKey =@"";
    self.dataArray =[[NSMutableArray alloc]init];
  
    [self.view addSubview:self.myTable];
    [self customNavigationBar];
    [self creatSearchView];
    [self creatBottomBut];
    [self makeData];
}

- (void)creatBottomBut{
    WS(blockSelf);
    CGFloat x =screenWigth/4;
    _pmBut =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_pmBut];
    [_pmBut setTitle:@"PM2.5排序" forState:UIControlStateNormal];
    _pmBut.backgroundColor =zhuse;
    _pmBut.titleLabel.font =FontSize(15);
    [_pmBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_pmBut setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_pmBut setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_pmBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blockSelf.myTable.mas_bottom).offset =10;
        make.centerX.offset =-x;
        make.width.offset =x;
        make.height.offset =29;
    }];
    [_pmBut addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    _aqiBut =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_aqiBut];
    [_aqiBut setTitle:@"AQI排序" forState:UIControlStateNormal];
    _aqiBut.backgroundColor =zhuse;
    _aqiBut.titleLabel.font =FontSize(15);
    [_aqiBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_aqiBut setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_aqiBut setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_aqiBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blockSelf.myTable.mas_bottom).offset =10;
        make.centerX.offset =  x;
        make.width.offset =x;
        make.height.offset =29;
    }];
    [_aqiBut addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
 
}
- (void)changeSelect:(UIButton *)but{
    
    DLog(@"点中的按钮：%@",but.titleLabel.text);
    if (but.selected) {
        return;
    }
    if (but ==self.aqiBut) {
        self.pmBut.selected =NO;
        
        //这里类似KVO的读取属性的方法，直接从字符串读取对象属性，注意不要写错
        NSSortDescriptor *sortDescriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"AQI" ascending:NO];
        NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"Id" ascending:NO];

        //这个数组保存的是排序好的对象
        self.dataArray= [self.dataArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1,sortDescriptor2, nil]];
//        [self.dataArray sortUsingDescriptors:@[sortDescriptor1,sortDescriptor2]];

        [self.myTable reloadData];
        
    }
    if (but ==self.pmBut) {
        self.aqiBut.selected =NO;
        //这里类似KVO的读取属性的方法，直接从字符串读取对象属性，注意不要写错
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"ceshi" ascending:NO];
        //这个数组保存的是排序好的对象
       self.dataArray= [self.dataArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [self.myTable reloadData];

        
        
        
    }
    but.selected =!but.selected;

    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AirEnvironmentListHeader * header =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AirEnvironmentListHeader"];
  
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AirEnvironmentCell *cell =[tableView dequeueReusableCellWithIdentifier:@"AirEnvironmentCell" forIndexPath:indexPath];
    PagedListModel *model =self.dataArray[indexPath.row];
    cell.numLab.text =[NSString stringWithFormat:@"第%ld",indexPath.row+1];
    cell.titleLab.text =model.name;
    if (model.aqiModel !=nil) {
        cell.PMLab.text =[NSString stringWithFormat:@"%.f",model.AQI];
//        cell.PMLab.text =[NSString stringWithFormat:@"%@",model.ceshi];

    }
    cell.backLab.hidden =NO;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AirEnVironmentInfoViewController *airInfoVC =[[AirEnVironmentInfoViewController alloc]init];
    PagedListModel *model =self.dataArray[indexPath.row];

    airInfoVC.pageModel =model;
    
    [self.navigationController pushViewController:airInfoVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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

- (void)creatSearchView{
    CustomeSearchView *searchView =[[CustomeSearchView alloc]initWithFrame:CGRectMake(0, 0, screenWigth, 49)];
    self.myTable.tableHeaderView =searchView;
    searchView.backgroundColor =[UIColor whiteColor];
    searchView.delegate =self;
    searchView.contentInset =UIEdgeInsetsMake(5, 15, 5, 15);
    for (UIView *subView in searchView.subviews) {
        if ([subView isKindOfClass:[UIView class]]) {
            if ([[subView.subviews objectAtIndex:0] isKindOfClass:[UITextField class]]) {
                UITextField *TX = [subView.subviews objectAtIndex:0];
                TX.placeholder =@"搜索站点名称";
                TX.font =FontSize(19);
                UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25,25)];
                imgV.image =[UIImage imageNamed:@"search"];
                TX.leftView =imgV;
            }
        }
    }
    

}

//发送搜索请求
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"] &&searchBar.returnKeyType ==UIReturnKeySearch){
        DLog(@"搜索");
        [self makeData];
        [self.view endEditing:YES];
        
        //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    DLog(@"调用了");
    self.searchKey =searchText;
    if ([searchText  isEqual:@""]) {
        [self makeData];
    }
}


#pragma mark --自定义导航栏
- (void)customNavigationBar{
    self.title =@"环境空气站";
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
    
    UIButton *rightBut =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBut addTarget:self action:@selector(goMap) forControlEvents:UIControlEventTouchUpInside];
    [rightBut setImage:[PubulicObj changeImage:[UIImage imageNamed:@"zuobiao"] WithSize:CGSizeMake(30, 30)]
         forState:UIControlStateNormal];
//    [rightBut setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    UIBarButtonItem *rigth =[[UIBarButtonItem alloc]initWithCustomView:rightBut];
    rigth.tintColor =[UIColor lightGrayColor];
    self.navigationItem.rightBarButtonItem =rigth;
    
}

- (void)goMap{
    MapViewController *mapVC =[[MapViewController alloc]init];
    mapVC.airEnvironmentArray =self.dataArray;
    [self.navigationController pushViewController:mapVC animated:YES];

}

- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 获取站点
- (void)makeData{
    
    NSString *urlStr =[NSString stringWithFormat:@"%@api/location/PagedList",BASEURL];
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:self.searchKey forKey:@"searchKey"];
    [dic setObject:@"0" forKey:@"pageIndex"];
    [dic setObject:@"3" forKey:@"type"];
    [dic setObject:@"3" forKey:@"subType"];
    WS(blockSelf);
    
    [AFNetRequest HttpPostCallBack:urlStr Parameters:dic success:^(id responseObject) {
        DLog(@"responseObject===%@",responseObject);
        [blockSelf.dataArray removeAllObjects];
        for (NSDictionary *items in responseObject[@"Items"]) {
            PagedListModel *model =[[PagedListModel alloc]initWithDic:items];
            [blockSelf.dataArray addObject:model];
        }
        [blockSelf getAQI];

        [blockSelf.myTable reloadData];
        
    } failure:^(NSError *error) {
        
    } isShowHUD:YES];
}

#pragma mark --获取站点aqi最新值
- (void)getAQI{
    
    NSString *urlStr =[NSString stringWithFormat:@"%@api/FactorData/GetLastRefAQIVals",BASEURL];
    
    
    NSMutableArray *refIDs =[[NSMutableArray alloc]init];
    for (PagedListModel *model in self.dataArray) {
        [refIDs addObject:model.Id];
    }
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:refIDs forKey:@"refIds"];
    [dic setObject:@"0" forKey:@"fromType"];
    WS(blockSelf);
    [AFNetRequest HttpPostCallBack:urlStr Parameters:dic success:^(id responseObject) {
        DLog(@"responseObject===%@",responseObject);
        for (int i =0 ;i <blockSelf.dataArray.count; i ++) {
            PagedListModel *pageModel =blockSelf.dataArray[i];

            AQIInfoModel *model;
            NSDictionary *resultDic =responseObject[i];
            
            if(![resultDic[@"info"] isEqual:[NSNull null]]){
                model =[[AQIInfoModel alloc]initWithDic:resultDic[@"info"][@"AQIInfo"]];
                NSString *aqistr =resultDic[@"info"][@"AQIInfo"][@"AQI"];
                pageModel.AQI =[aqistr floatValue];
                pageModel.AQILevel =resultDic[@"info"][@"AQIInfo"][@"AQILevel"];
                pageModel.Health =resultDic[@"info"][@"AQIInfo"][@"Health"];

            }else {
                model =[[AQIInfoModel alloc]init];
                model.AQI =@"0";
                
            }
//            pageModel.ceshi =[NSString stringWithFormat:@"%d",arc4random()%100];
            DLog(@"pageModel==%f",pageModel.AQI);
            pageModel.aqiModel =model;
  
        }
        [blockSelf changeSelect:blockSelf.aqiBut];

       
    } failure:^(NSError *error) {
        
    } isShowHUD:NO];

    
}



@end
