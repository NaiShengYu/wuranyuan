//
//  SiteListViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/10.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "SiteListViewController.h"

#import "EditSiteViewController.h"
@interface SiteListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTable;

@property (nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation SiteListViewController


- (UITableView *)myTable{
    if (!_myTable) {
        _myTable =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWigth, screenHeight) style:UITableViewStyleGrouped];
        _myTable.delegate =self;
        _myTable.dataSource =self;
        
        
        
    }
    return _myTable;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray =[[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"site"]];

    [self.view addSubview:self.myTable];
    
    [self customNavigationBar];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if (indexPath.row ==self.dataArray.count) {
        cell.textLabel.text =@"添加站点";
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }else{
        NSDictionary *dic =self.dataArray[indexPath.row];
        cell.textLabel.text =dic[@"stationName"];
        cell.detailTextLabel.text =dic[@"stationUrl"];
        
        //如果当前是选择项，则加上accessorycheckmark
        if ([dic[@"stationSelected"] integerValue] ==1) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        else{
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
 
    }
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==self.dataArray.count) {
        EditSiteViewController *editSiteVC =[[EditSiteViewController alloc]init];
        WS(blockSelf);
        editSiteVC.successBlock = ^() {
            blockSelf.dataArray =[[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"site"]];
            [tableView reloadData];
            NSIndexPath *indext =[NSIndexPath indexPathForRow:blockSelf.dataArray.count-1 inSection:0];
            [blockSelf tableView:tableView didSelectRowAtIndexPath:indext];
        };
  
        [self.navigationController pushViewController:editSiteVC animated:YES];
    }else{
        
        //数据更新
        for (int i = 0; i < [self.dataArray count]; i++) {
            if ([self.dataArray[i][@"stationSelected"] isEqualToString:@"1"]) {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:self.dataArray[i]];
                [dict setObject:@"0" forKey:@"stationSelected"];
                [self.dataArray replaceObjectAtIndex:i withObject:dict];
                break;
            }
        }
        NSMutableDictionary *item = [[NSMutableDictionary alloc]initWithDictionary:self.dataArray[indexPath.row]];
        [item setObject:@"1" forKey:@"stationSelected"];
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:item];
        NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
        [userdefaults setObject:self.dataArray forKey:@"site"];
        [userdefaults setObject:item[@"stationId"] forKey:@"stationId"];
        [userdefaults setObject:item[@"stationName"] forKey:@"stationName"];
        [userdefaults setObject:item[@"stationUrl"] forKey:@"stationUrl"];
        [userdefaults synchronize];
        [CustomAccount sharedCustomAccount].stationUrl =item[@"stationUrl"];
        [tableView reloadData];
//        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark --自定义导航栏
- (void)customNavigationBar{
    self.title =@"选择站点";
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.navigationController.navigationBar.hidden =NO;
    self.tabBarController.tabBar.hidden =YES;
    
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"45"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    leftBarButtonItem.imageInsets =UIEdgeInsetsMake(0, -10, 0, 10);

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
 
}

- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}




@end
