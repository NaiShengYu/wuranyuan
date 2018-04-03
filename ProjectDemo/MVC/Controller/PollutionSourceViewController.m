//
//  AirEnvironmentViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/8.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "PollutionSourceViewController.h"
#import "PollutionSourceCell.h"
#import "PollutionSouceInfoViewController.h"
#import "PollutionSouceMapViewController.h"//地图

#import "PollutionSouceModel.h"
#import "CustomeSearchView.h"//搜索框

@interface PollutionSourceViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic,strong)UITableView *myTable;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,copy)NSString *searchKey;

@property (nonatomic,strong)NSMutableArray *currentArray;

@end

@implementation PollutionSourceViewController

- (UITableView *)myTable{
    if (!_myTable) {
        _myTable =[[UITableView alloc]initWithFrame:CGRectMake(0, StartBarHeight, screenWigth, screenHeight-StartBarHeight) style:UITableViewStyleGrouped];
        _myTable.delegate =self;
        _myTable.dataSource =self;
        [PubulicObj judgeSystemVersionWithTableView:_myTable];
        [_myTable registerClass:[PollutionSourceCell class] forCellReuseIdentifier:@"PollutionSourceCell"];
    }
    return _myTable;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchKey =@"";
    self.dataArray =[[NSMutableArray alloc]init];
    self.currentArray =[[NSMutableArray alloc]init];
    [self.view addSubview:self.myTable];
    [self customNavigationBar];
    [self creatSearchView];
    [self makeData];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.currentArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PollutionSourceCell *cell =[tableView dequeueReusableCellWithIdentifier:@"PollutionSourceCell" forIndexPath:indexPath];
    PollutionSouceModel *model =self.currentArray[indexPath.row];
    cell.titleLab.text =[NSString stringWithFormat:@"%@",model.name];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PollutionSouceInfoViewController *pollutionInfoVC =[[PollutionSouceInfoViewController alloc]init];
    PollutionSouceModel *model =self.currentArray[indexPath.row];
    pollutionInfoVC.souceModel =model;
    pollutionInfoVC.title =model.name;
    [self.navigationController pushViewController:pollutionInfoVC animated:YES];
    
    
    
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
        [self getSearchResult];
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
        [self getSearchResult];
    }
}

#pragma mark --自定义导航栏
- (void)customNavigationBar{
    self.title =@"污染源在线";
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.navigationController.navigationBar.hidden =NO;
    self.tabBarController.tabBar.hidden =YES;
    
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"45"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];    leftBarButtonItem.imageInsets =UIEdgeInsetsMake(0, -10, 0, 10);

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
    PollutionSouceMapViewController *mapVC =[[PollutionSouceMapViewController alloc]init];
    mapVC.pullutionsArray =self.currentArray;
    
    [self.navigationController pushViewController:mapVC animated:YES];
    
}

- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark 获得企业列表
- (void)makeData{
    
    NSString *urlStr =[NSString stringWithFormat:@"%@api/AppEnterprise/GetEnterpriseList?keys=",BASEURL];
  
    WS(blockSelf);
  
    [AFNetRequest HttpGetCallBack:urlStr Parameters:nil success:^(id responseObject) {
                DLog(@"responseObject===%@",responseObject);
        for (NSDictionary *dic in responseObject[@"items"]) {
            PollutionSouceModel *model =[[PollutionSouceModel alloc]initWithDic:dic];
            [blockSelf.dataArray addObject:model];
            [blockSelf.currentArray addObject:model];
        }
        [blockSelf.myTable reloadData];
        
    } failure:^(NSError *error) {
        
    } isShowHUD:YES];
    
}

#pragma mark --获取搜索结果
- (void)getSearchResult{
    NSLog(@"%@",self.searchKey);
    
    [self.currentArray removeAllObjects];
    for (PollutionSouceModel *listModel in self.dataArray) {
  
        if (self.searchKey.length ==0 ||self.searchKey ==nil) {
            [self.currentArray addObject:listModel];
        }
        if ([listModel.name containsString:self.searchKey]) {
            [self.currentArray addObject:listModel];
        }
    }
    [self.myTable reloadData];
    
}

@end

