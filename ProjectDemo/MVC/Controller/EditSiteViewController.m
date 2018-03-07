//
//  EditSiteViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/10.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "EditSiteViewController.h"

@interface EditSiteViewController ()

@property (nonatomic,copy)NSString *address;

@end

@implementation EditSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavigationBar];
    [self creatView];
}




- (void)creatView{
    self.view.backgroundColor =[UIColor groupTableViewBackgroundColor];
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 10, screenWigth, 50)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 50)];
    titleLab.text =@"地址";
    titleLab.font =FontSize(16);
    [backView addSubview:titleLab];
    
    UITextField *textF =[[UITextField alloc]initWithFrame:CGRectMake(60, 0, screenWigth-70, 50)];
    textF.placeholder =@"edrs.station.gov.cn";
    [textF addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [backView addSubview:textF];
    
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(10, 100, screenWigth-20, 40)];
    lab.text =@"请输入监测站的EDRS链接地址";
    lab.textColor =[UIColor lightGrayColor];
    lab.textAlignment =NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    
    
    
    
    
    
    
    
}

- (void)textChanged:(UITextField *)textF{
    
    self.address =textF.text;
    
    
}

#pragma mark --自定义导航栏
- (void)customNavigationBar{
    self.title =@"添加站点";
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
    UIButton *rightBut =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 18)];
    [rightBut addTarget:self action:@selector(subNewAddress) forControlEvents:UIControlEventTouchUpInside];
    [rightBut setTitle:@"添加" forState:UIControlStateNormal];
    UIBarButtonItem *rigth =[[UIBarButtonItem alloc]initWithCustomView:rightBut];
    rigth.tintColor =[UIColor lightGrayColor];
    self.navigationItem.rightBarButtonItem =rigth;
}

- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 提交
- (void)subNewAddress{
    
    NSString *stationurl = [self.address stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    stationurl = [stationurl stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    [CustomAccount sharedCustomAccount].stationUrl = stationurl;
    
    if (stationurl.length > 0) {
        NSArray *tmpurlarr = [stationurl componentsSeparatedByString:@":"];
        
        NSLog(@"%@", tmpurlarr[0]);
        
        //新增检测站
        WS(blockSelf);
        [AFNetRequest HttpGetAddressBack:@"api/login/getstationName" Parameters:@{@"stationurl":tmpurlarr[0]} success:^(id responseObject) {
            NSMutableDictionary *tmpStation = [[NSMutableDictionary alloc]init];
            [tmpStation setObject:responseObject[@"id"] forKey:@"stationId"];
            [tmpStation setObject:responseObject[@"name"] forKey:@"stationName"];
            [tmpStation setObject:@"0" forKey:@"stationSelected"];
            [tmpStation setObject:stationurl forKey:@"stationUrl"];
            
            NSMutableArray *arr =[[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"site"]];
            BOOL isHave=NO;
            for (NSDictionary *arrDic in arr) {
                if ([arrDic[@"stationUrl"] isEqualToString:stationurl]) {
                    isHave =YES;
                }
            }
            if (isHave ==NO) {
                [arr addObject:tmpStation];
                [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"site"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            blockSelf.successBlock();
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            
        } isShowHUD:YES];
        
    }
}
@end
