//
//  EmissionPermitManagementInfoViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "EmissionPermitManagementInfoViewController.h"

#import "EmissionPermitManagementInfoModel.h"
@interface EmissionPermitManagementInfoViewController ()
@property (nonatomic,strong)EmissionPermitManagementInfoModel *infoModel;

@property (nonatomic,strong)UILabel *infoLab1;

@property (nonatomic,strong)UILabel *infoLab2;

@end

@implementation EmissionPermitManagementInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatLab];
    [self customNavigationBar];
    [self makeData];
  
}

- (void)creatLab{
    WS(blockSelf);
    _infoLab1 =[[UILabel alloc]init];
    [self.view addSubview:_infoLab1];
    [_infoLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =10;
        make.top.offset =70;
        make.right.offset =-10;
    }];
    _infoLab1.numberOfLines =0;
    _infoLab1.font =FontSize(15);
    
    _infoLab2 =[[UILabel alloc]init];
    [self.view addSubview:_infoLab2];
    [_infoLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset =10;
        make.right.offset =-10;
        make.top.equalTo(blockSelf.infoLab1.mas_bottom).offset =20;
    }];
    _infoLab2.numberOfLines =0;
    _infoLab2.font =FontSize(15);
    _infoLab2.textAlignment =NSTextAlignmentRight;
    
    
    
}


#pragma mark --自定义导航栏
- (void)customNavigationBar{
    
    self.title =@"排污许可证";
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

#pragma mark --获取排污许可证详情
- (void)makeData{
    
    WS(blockSelf);
    NSString *urlStr =[NSString stringWithFormat:@"%@api/AppEnterprise/GetPollutePermit?id=%@",BASEURL,self.ID];
    [AFNetRequest HttpGetCallBack:urlStr Parameters:nil success:^(id responseObject) {
        @try {
            blockSelf.infoLab1.text =[NSString stringWithFormat:@"单位名称：%@\n\n注册地址：%@\n\n法人代表：%@\n\n生产经营场所地址：%@\n\n行业类别：%@\n\n统一信用代码：%@\n\n有效日期：%@至%@",responseObject[@"name"],responseObject[@"registerAdd"],responseObject[@"legal"],responseObject[@"address"],responseObject[@"industry"],responseObject[@"code"],[responseObject[@"startdate"] substringToIndex:10],[responseObject[@"enddate"] substringToIndex:10]];
            
            blockSelf.infoLab2.text =[NSString stringWithFormat:@"发证机关：%@\n\n发证日期：%@",responseObject[@"issuing"],[responseObject[@"issuedate"] substringToIndex:10]];
            
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        
        
    } failure:^(NSError *error) {
        
    } isShowHUD:YES];
    
    
    
    
}

@end
