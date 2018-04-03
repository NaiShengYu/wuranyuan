//
//  SupervisionAndInspectionInfoViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "SupervisionAndInspectionInfoViewController.h"
#import "SupervisionAndInspectionInfoHeader.h"
#import "SupervisionAndInspectionInfoCell.h"
@interface SupervisionAndInspectionInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTable;

@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation SupervisionAndInspectionInfoViewController

- (UITableView *)myTable{
    if (!_myTable) {
        _myTable =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenWigth, screenHeight-64) style:UITableViewStylePlain];
        _myTable.delegate = self;
        _myTable.dataSource = self;
        _myTable.separatorStyle =UITableViewCellSeparatorStyleNone;
        //        [PubulicObj judgeSystemVersionWithTableView:_myTable];
        
        [_myTable registerClass:[SupervisionAndInspectionInfoCell class] forCellReuseIdentifier:@"SupervisionAndInspectionInfoCell"];
        [_myTable registerClass:[SupervisionAndInspectionInfoHeader class] forHeaderFooterViewReuseIdentifier:@"header"];
        
        
    }
    return _myTable;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray =[[NSMutableArray alloc]init];
    [self customNavigationBar];
    [self.view addSubview:self.myTable];
    [self makeData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SupervisionAndInspectionInfoHeader *header =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SupervisionAndInspectionInfoCell *cell =[tableView dequeueReusableCellWithIdentifier:@"SupervisionAndInspectionInfoCell" forIndexPath:indexPath];
   NSDictionary *dic =self.dataArray[indexPath.row];
    cell.dic =dic;
    return cell;
    
}


#pragma mark --自定义导航栏
- (void)customNavigationBar{
    
    self.title =@"监督性检查";
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

#pragma mark --获取监督性检查详情
- (void)makeData{
    
    WS(blockSelf);
    NSString *urlStr =[NSString stringWithFormat:@"%@api/AppEnterprise/GetMonidataPollutionDetail?id=%@",BASEURL,self.ID];
    [AFNetRequest HttpGetCallBack:urlStr Parameters:nil success:^(id responseObject) {
        
        for (NSDictionary *dic in responseObject) {
            [blockSelf.dataArray addObject:dic];
        }
        [blockSelf.myTable reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error======%@",error);
    } isShowHUD:YES];
 
}

@end
