//
//  AirEnVironmentInfoViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/8.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "AirEnVironmentInfoViewController.h"
#import "AirEnvironmentCell.h"
#import "AirEnvironmentHeader.h"
#import "AirEnvironmentFooter.h"

@interface AirEnVironmentInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    FactorModel *currentModel;
    NSIndexPath *currentIndex;
    
}
@property (nonatomic,strong)UITableView *myTable;

@property (nonatomic,strong)NSMutableArray *dataArray;



@end

@implementation AirEnVironmentInfoViewController

- (UITableView *)myTable{
    if (!_myTable) {
        _myTable =[[UITableView alloc]initWithFrame:CGRectMake(0, StartBarHeight, screenWigth, screenHeight-StartBarHeight) style:UITableViewStyleGrouped];
        _myTable.delegate =self;
        _myTable.dataSource =self;
        [PubulicObj judgeSystemVersionWithTableView:_myTable];
        [_myTable registerClass:[AirEnvironmentCell class] forCellReuseIdentifier:@"AirEnvironmentCell"];
        [_myTable registerClass:[AirEnvironmentHeader class] forHeaderFooterViewReuseIdentifier:@"AirEnvironmentHeader"];
        [_myTable registerClass:[AirEnvironmentFooter class] forHeaderFooterViewReuseIdentifier:@"AirEnvironmentFooter"];

    }
    return _myTable;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dataArray =[[NSMutableArray alloc]init];
//    for (NSInteger i =0 ; i <10; i ++) {
//        CGFloat a = arc4random()%100;
//        NSString *pm =[NSString stringWithFormat:@"%.1f",a];
//        DLog(@"a==%f,pm===%@",a,pm);
//
//        NSDictionary *dic =@{@"address":@"中科路",@"PM":pm};
//        [self.dataArray addObject:dic];
//
//    }
//    self.message =@"当前空气质量为良，空气质量可接受，但某些污染物可能对极少数异常敏感人群健康有较弱影响。建议：极少数异常敏感人群应减少户外活动";
    
//    self.dic =@{@"AQI":@"63",@"PM2.5":@"52.989ug/m3",@"PM10":@"91,69ug/m3",@"CO":@"4.12ug/m3",@"CO2":@"2.01ug/m3"};
    
    currentIndex =[NSIndexPath indexPathForRow:0 inSection:0];
    [self customNavigationBar];
    [self getItemIdWithModel];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pageModel.factorModelArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    UILabel *lab =[[UILabel alloc]init];
    lab.numberOfLines =0;
    lab.lineBreakMode =NSLineBreakByWordWrapping;
    if (self.pageModel.aqiModel !=nil) {
        lab.text =self.pageModel.aqiModel.Health;
    }
    lab.font =FontSize(14);
    CGSize size =[lab sizeThatFits:CGSizeMake(screenWigth-25-40, MAXFLOAT)];
    CGFloat H =size.height+35;
    if (H <45) {
        H=45;
    }
    return H;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return imgHeght(200)+30+40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AirEnvironmentHeader *header =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AirEnvironmentHeader"];
    
    if (self.pageModel.aqiModel !=nil) {
        header.titleLab.text =self.pageModel.aqiModel.AQILevel;
        header.PMLab.text =self.pageModel.aqiModel.Health;
   
    }
  
    
    return header;
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AirEnvironmentCell *cell =[tableView dequeueReusableCellWithIdentifier:@"AirEnvironmentCell" forIndexPath:indexPath];
    cell.accessoryType =UITableViewCellAccessoryNone;
    FactorModel *model =self.pageModel.factorModelArray[indexPath.row];
    cell.titleLab.text =model.name;
    cell.PMLab.text =model.val;
//    [cell.PMLab mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(cell.contentView).offset =5;
//        make.right.equalTo(cell.contentView).offset =-10;
//        make.bottom.equalTo(cell.contentView).offset =-5;
//        make.width.mas_lessThanOrEqualTo(90);
//    }];
//    [self.myTable selectRowAtIndexPath:currentIndex animated:NO scrollPosition:UITableViewScrollPositionNone];

    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    AirEnvironmentFooter *footer =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"AirEnvironmentFooter"];
    footer.pageModel =self.pageModel;
    footer.currentModel =currentModel;
    
    return footer;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FactorModel *model =self.pageModel.factorModelArray[indexPath.row];
    currentModel =model;
    currentIndex =indexPath;
    [tableView reloadData];

}

#pragma mark --获取站点因子
- (void)getItemIdWithModel{
    WS(blockSelf);
    NSString *str =[NSString stringWithFormat:@"%@api/location/GetFactors?id=%@",BASEURL,self.pageModel.Id];
    [AFNetRequest HttpGetCallBack:str Parameters:nil success:^(id responseObject) {
        for (NSDictionary *dic in responseObject) {
            FactorModel *factorModel =[[FactorModel alloc]initWithDic:dic];
            if ([factorModel.name isEqualToString:@"臭氧"]) {
                factorModel.name =@"O3";
            }
            if ([factorModel.name isEqualToString:@"一氧化碳"]) {
                factorModel.name =@"CO";
            }
            if ([factorModel.name isEqualToString:@"二氧化氮"]) {
                factorModel.name =@"NO2";
            }
            if ([factorModel.name isEqualToString:@"二氧化硫"]) {
                factorModel.name =@"SO2";
            }
            
            [blockSelf.pageModel.factorModelArray addObject:factorModel];
            [blockSelf getItemNumWithModel:factorModel];
        }
        [blockSelf.view addSubview:blockSelf.myTable];
        [blockSelf tableView:blockSelf.myTable didSelectRowAtIndexPath:currentIndex];

    } failure:^(NSError *error) {

    } isShowHUD:YES];
}

#pragma mark --获取因子最新值
-(void)getItemNumWithModel:(FactorModel *)factModel{
        
    NSString *urlStr =[NSString stringWithFormat:@"%@api/FactorData/GetLastRefFacVals",BASEURL];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:factModel.Id forKey:@"facId"];
    [dic setObject:@"0" forKey:@"fromType"];
    NSArray *arr =@[self.pageModel.Id];
    [dic setObject:arr forKey:@"refIds"];
    WS(blockSelf);
    [AFNetRequest HttpPostCallBack:urlStr Parameters:dic success:^(id responseObject) {
        DLog(@"responseObject===%@",responseObject);
        for (NSDictionary *resurlDic in responseObject) {
            factModel.val =[NSString stringWithFormat:@"%@ ug/m3",resurlDic[@"val"]];

        }
        [blockSelf.myTable reloadData];
    } failure:^(NSError *error) {
        
    } isShowHUD:NO];
    
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
    self.title =self.pageModel.name;
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
    [self.pageModel.factorModelArray removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
