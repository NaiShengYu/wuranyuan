//
//  ProjectApprovalViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/30.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "LettersAndVisitsViewController.h"
#import "ProjectApprovalModel.h"

#import "LettersAndVisitsInfoViewController.h"
@interface LettersAndVisitsViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic,strong)UITableView *myTable;

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,assign)NSInteger pageIndex;


@end

@implementation LettersAndVisitsViewController

- (UITableView *)myTable{
    if (!_myTable) {
        _myTable =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenWigth, screenHeight-64) style:UITableViewStyleGrouped];
        _myTable.delegate = self;
        _myTable.dataSource = self;
        _myTable.emptyDataSetSource =self;
        _myTable.emptyDataSetDelegate =self;
        [PubulicObj judgeSystemVersionWithTableView:_myTable];
        [_myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        MJRefreshBackNormalFooter *backFooter =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self makeData];
        }];
        _myTable.mj_footer =backFooter;
        
    }
    return _myTable;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIndex =1;
    self.dataArray =[[NSMutableArray alloc]init];
    [self customNavigationBar];
    [self.view addSubview:self.myTable];
    [self makeData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ProjectApprovalModel *model =self.dataArray[indexPath.row];
    cell.textLabel.numberOfLines =0;
    cell.textLabel.font =FontSize(15);
    cell.textLabel.adjustsFontSizeToFitWidth =YES;
    @try {
        cell.textLabel.text =[NSString stringWithFormat:@"信访标题：%@\n投诉时间：%@\n结束时间：%@\n状态：%@",model.TITLE,[model.ORDERDATE substringToIndex:10],[model.CLOSECASEDATE substringToIndex:10],model.STATEDESC];

    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProjectApprovalModel *model =self.dataArray[indexPath.row];

    LettersAndVisitsInfoViewController *infoVC =[[LettersAndVisitsInfoViewController alloc]init];
    infoVC.ID =model.ID;
    [self.navigationController pushViewController:infoVC animated:YES];

}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text =@"企业没有信访管理\n❛‿˂̵✧";
    return [[NSAttributedString alloc] initWithString:text attributes:nil];
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
    
    self.title =@"信访管理列表";
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

- (void)makeData{
    NSString *urlStr =[NSString stringWithFormat:@"%@api/AppEnterprise/GetPetitionList?id=%@&pageindx=%ld&pageSize=10",BASEURL,self.souceModel.ID,(long)self.pageIndex];
    WS(blockSelf);
    [AFNetRequest HttpGetCallBack:urlStr Parameters:nil success:^(id responseObject) {
        DLog(@"responseObject===%@",responseObject);
        for (NSDictionary *dic in responseObject[@"items"]) {
            ProjectApprovalModel *model =[[ProjectApprovalModel alloc]initWithDic:dic];
            
            [blockSelf.dataArray addObject:model];
        }
        
        if (blockSelf.pageIndex*10 <[responseObject[@"count"] integerValue]) {
            [blockSelf.myTable.mj_footer endRefreshing];
        }else{
            [blockSelf.myTable.mj_footer endRefreshingWithNoMoreData];
        }
        
        [blockSelf.myTable reloadData];
        
        
    } failure:^(NSError *error) {
        [blockSelf.myTable.mj_footer endRefreshing];
        
    } isShowHUD:YES];
}

@end


