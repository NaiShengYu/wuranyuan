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

@property (nonatomic,strong)NSMutableArray *currentArray;
@property (nonatomic,strong)NSMutableArray *haveDataArray;
@property (nonatomic,strong)NSMutableArray *currentHaveDataArray;
@property (nonatomic,strong)NSMutableArray *noDataArray;
@property (nonatomic,strong)NSMutableArray *currentNoDataArray;

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
    self.currentArray =[[NSMutableArray alloc]init];
    self.haveDataArray =[[NSMutableArray alloc]init];
    self.noDataArray =[[NSMutableArray alloc]init];
    self.currentNoDataArray =[[NSMutableArray alloc]init];
    self.currentHaveDataArray =[[NSMutableArray alloc]init];

    
    [self.view addSubview:self.myTable];
    [self customNavigationBar];
    [self creatSearchView];
    [self creatBottomBut];
    [self makeData2];
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
        NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"StationId" ascending:NO];

        //这个数组保存的是排序好的对象
        NSArray *arr = (NSMutableArray *)[self.currentHaveDataArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1,sortDescriptor2, nil]];
        self.currentHaveDataArray =[[NSMutableArray alloc]initWithArray:arr];
//        [self.dataArray sortUsingDescriptors:@[sortDescriptor1,sortDescriptor2]];

        
    }
    if (but ==self.pmBut) {
        self.aqiBut.selected =NO;
        //这里类似KVO的读取属性的方法，直接从字符串读取对象属性，注意不要写错
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"PM25" ascending:NO];
        NSSortDescriptor *sortDescriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"StationId" ascending:NO];

        //这个数组保存的是排序好的对象
       NSArray *arr= (NSMutableArray *)[self.currentHaveDataArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor,sortDescriptor2, nil]];
        self.currentHaveDataArray =[[NSMutableArray alloc]initWithArray:arr];

    }
    [self.currentArray removeAllObjects];
    for (PagedListModel *model in self.currentHaveDataArray) {
        [self.currentArray addObject:model];
    }
    for (PagedListModel *model in self.currentNoDataArray) {
        [self.currentArray addObject:model];
    }
    [self.myTable reloadData];
    but.selected =!but.selected;
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.currentArray.count;
 
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
    if (self.aqiBut.selected) {
        header.AQINumLab.text =@"AQI(ug/m3)";
    }else{
        header.AQINumLab.text =@"PM2.5(ug/m3)";
    }
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AirEnvironmentCell *cell =[tableView dequeueReusableCellWithIdentifier:@"AirEnvironmentCell" forIndexPath:indexPath];
    PagedListModel *model =self.currentArray[indexPath.row];
    cell.numLab.text =[NSString stringWithFormat:@"第%ld",indexPath.row+1];
    cell.isAQI =self.aqiBut.selected;
    cell.listModel =model;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PagedListModel *model =self.currentArray[indexPath.row];
    if (model.aqiInfoModel ==nil) {
        return;
    }
    AirEnVironmentInfoViewController *airInfoVC =[[AirEnVironmentInfoViewController alloc]init];
    
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
    
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"45"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    leftBarButtonItem.imageInsets =UIEdgeInsetsMake(0, -10, 0, 10);

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
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
    mapVC.airEnvironmentArray =self.haveDataArray;
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)makeData2{
    
    WS(blockSelf);
    NSString *urlStr =@"api/FactorData/GetLastAQIValsForPhone";
    [AFNetRequest HttpGetCallBack:urlStr Parameters:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        for (NSDictionary *dic in responseObject) {
            PagedListModel *listModel =[[PagedListModel alloc]initWithDic:dic];
            if (![dic[@"info"] isEqual:[NSNull null]]) {
                listModel.AQI =[listModel.aqiInfoModel.AQI floatValue];
                listModel.PM25 =[listModel.aqiInfoModel.PM25 floatValue];
                [blockSelf.haveDataArray addObject:listModel];
                [blockSelf.currentHaveDataArray addObject:listModel];

            }else{
                [blockSelf.noDataArray addObject:listModel];
                [blockSelf.currentNoDataArray addObject:listModel];
            }
        }
        [blockSelf changeSelect:blockSelf.aqiBut];
        
    } failure:^(NSError *error) {
        
    } isShowHUD:YES];

}

#pragma mark --获取搜索结果
- (void)makeData{
    NSLog(@"%@",self.searchKey);
    [self.currentHaveDataArray removeAllObjects];
 
    for (PagedListModel *listModel in self.haveDataArray) {
        if (self.searchKey.length ==0 ||self.searchKey ==nil) {
            [self.currentHaveDataArray addObject:listModel];
        }
        if ([listModel.StationName containsString:self.searchKey]) {
            [self.currentHaveDataArray addObject:listModel];
        }
    }
    [self.currentNoDataArray removeAllObjects];
    for (PagedListModel *listModel in self.noDataArray) {
        if (self.searchKey.length ==0 ||self.searchKey ==nil) {
            [self.currentNoDataArray addObject:listModel];
        }
        if ([listModel.StationName containsString:self.searchKey]) {
            [self.currentNoDataArray addObject:listModel];
        }
    }
    if (self.aqiBut.selected) {
        self.aqiBut.selected =NO;
        [self changeSelect:self.aqiBut];
    }else{
        self.pmBut.selected =NO;
        [self changeSelect:self.pmBut];
    }
    
}

@end
