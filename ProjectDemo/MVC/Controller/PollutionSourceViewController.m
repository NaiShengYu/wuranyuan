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
#import "PagedListModel.h"
#import "PollutionSouceMapViewController.h"//地图

#import "CustomeSearchView.h"//搜索框

@interface PollutionSourceViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic,strong)UITableView *myTable;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,copy)NSString *searchKey;

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
    for (NSInteger i =0 ; i <10; i ++) {
        CGFloat a = arc4random()%100;
        NSString *pm =[NSString stringWithFormat:@"%.1f",a];
        DLog(@"a==%f,pm===%@",a,pm);

        NSDictionary *dic =@{@"address":@"中科路",@"PM":pm};
        [self.dataArray addObject:dic];

    }
    [self.view addSubview:self.myTable];
    [self customNavigationBar];
    [self creatSearchView];
//    [self makeData];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
    
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
//    PagedListModel *model =self.dataArray[indexPath.row];
    NSDictionary *dic =self.dataArray[indexPath.row];
    
    cell.titleLab.text =dic[@"address"];
    cell.infoLab.text =[NSString stringWithFormat:@"AQI:%@",dic[@"PM"]];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PollutionSouceInfoViewController *plooutionInfoVC =[[PollutionSouceInfoViewController alloc]init];
    [self.navigationController pushViewController:plooutionInfoVC animated:YES];
    
    
    
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
    [dic setObject:@"0" forKey:@"type"];
    [dic setObject:@"3" forKey:@"subType"];
    WS(blockSelf);
    
    [AFNetRequest HttpPostCallBack:urlStr Parameters:dic success:^(id responseObject) {
        DLog(@"responseObject===%@",responseObject);
        [blockSelf.dataArray removeAllObjects];
        for (NSDictionary *items in responseObject[@"Items"]) {
            PagedListModel *model =[[PagedListModel alloc]initWithDic:items];
            [blockSelf.dataArray addObject:model];
        }
//        [blockSelf getAQI];
        
        [blockSelf.myTable reloadData];
        
    } failure:^(NSError *error) {
        
    } isShowHUD:YES];
}
@end

