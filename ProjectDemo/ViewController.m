//
//  ViewController.m
//  ProjectDemo
//
//  Created by 俞乃胜, Stephen on 2017/12/6.
//  Copyright © 2017年 俞乃胜, Stephen. All rights reserved.
//

#import "ViewController.h"
#import "HomePageViewController.h"

#import "SiteListViewController.h"
@interface ViewController ()

@property (nonatomic,copy)NSString *nameStr;

@property (nonatomic,copy)NSString *passwordStr;
@property (nonatomic,assign)BOOL isSelect;//是否记住密码


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    self.nameStr =[user objectForKey:@"name"];
    self.passwordStr =[user objectForKey:@"password"];
    if (self.nameStr.length >0) {
        self.isSelect =YES;
    }
    self.view.backgroundColor =[UIColor whiteColor];
    
    __block int i = 0;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status ==AFNetworkReachabilityStatusNotReachable) {
            [SVProgressHUD showErrorWithStatus:@"网络无连接!"];
            DLog(@"网络连接不上");
        }else{
            if (i ==0) {
                [self creatHeaderView];
                i =i +1;
            }
        }}];
    self.automaticallyAdjustsScrollViewInsets =YES;
   
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden =YES;
    NSLog(@"stationName===%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"stationName"]);
    UILabel *lab2 =[self.view viewWithTag:666];
    lab2.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"stationName"];
    [CustomAccount sharedCustomAccount].stationUrl =[[NSUserDefaults standardUserDefaults] objectForKey:@"stationUrl"];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden =NO;
}

#pragma mark --顶部试图
- (void)creatHeaderView{
    
    UIScrollView *scr =[[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, screenWigth, screenHeight)];
    [self.view addSubview:scr];
    CGFloat H =screenHeight;
    if (screenHeight ==480) {
        H =568.0;
    }
    UIView *bigView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWigth, H)];
    [scr addSubview:bigView];
    scr.contentSize =CGSizeMake(screenWigth, H);
    
    
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWigth, imgHeght(180))];
    backView.backgroundColor =zhuse;
    [bigView addSubview:backView];
    
    UIImageView *imgv =[UIImageView new];
    [backView addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset =10;
        make.centerX.offset =-90;
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    imgv.image =[UIImage imageNamed:@"logo5"];
    
    UILabel *lab =[UILabel new];
    [backView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset =10;
        make.left.equalTo(imgv.mas_right).offset =10;
        make.width.offset =180;
    }];
    lab.text =@"环境应急监测决策系统\nEnvironment Disaster\nResponse System";
    lab.textColor =[UIColor whiteColor];
    lab.numberOfLines =3;
    lab.font =FontSize(16);
 
    UIButton *but= [UIButton new];
    [bigView addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).offset =0;
        make.left.equalTo(bigView).offset =0;
        make.right.equalTo(bigView).offset =0;
        make.height.offset =50;
    }];
    but.backgroundColor =[UIColor groupTableViewBackgroundColor];
    [but addTarget:self action:@selector(choseCenter) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *lab2 =[UILabel new];
    [but addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(but).offset =0;
        make.left.equalTo(but).offset =10;
        make.bottom.equalTo(but).offset =0;
        make.width.mas_lessThanOrEqualTo(screenWigth-60);
    }];
    lab2.tag =666;
    lab2.text =[[NSUserDefaults standardUserDefaults] objectForKey:@"stationName"];

    UIImageView *rigthImageV =[UIImageView new];
    [but addSubview:rigthImageV];
    [rigthImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(but).offset =13;
        make.right.equalTo(but).offset =-10;
        make.bottom.equalTo(but).offset =-13;
        make.width.offset=13;
    }];
    rigthImageV.image =[UIImage imageNamed:@"balckarrow_right"];
  
    UITextField *nameT =[UITextField new];
    [bigView addSubview:nameT];
    [nameT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(but.mas_bottom).offset =35;
        make.centerX.offset =0;
        make.width.offset =screenWigth/5*3;
        make.height.offset=40;
    }];
    nameT.placeholder =@"  用户名";
    nameT.font =FontSize(15);
    nameT.layer.borderWidth =1.0;
    nameT.layer.borderColor =[UIColor groupTableViewBackgroundColor].CGColor;
    nameT.layer.cornerRadius =4;
    nameT.layer.masksToBounds =YES;
    [nameT setValue:[NSNumber numberWithInt:9] forKey:@"paddingLeft"];
    [nameT addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    nameT.tag =1002;
    nameT.text =self.nameStr;
    
    UITextField *passwordT =[UITextField new];
    [bigView addSubview:passwordT];
    [passwordT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameT.mas_bottom).offset =15;
        make.centerX.offset =0;
        make.width.offset =screenWigth/5*3;
        make.height.offset=40;
    }];
    passwordT.placeholder =@"  密码";
    passwordT.font =FontSize(15);
    passwordT.layer.borderWidth =1.0;
    passwordT.layer.borderColor =[UIColor groupTableViewBackgroundColor].CGColor;
    passwordT.layer.cornerRadius =4;
    passwordT.layer.masksToBounds =YES;
    [passwordT setValue:[NSNumber numberWithInt:9] forKey:@"paddingLeft"];
    [passwordT addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    passwordT.tag =1001;
    passwordT.text =self.passwordStr;
    passwordT.secureTextEntry=YES;
  
    
    UILabel *lab3 =[UILabel new];
    [bigView addSubview:lab3];
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordT.mas_bottom).offset =25;
        make.left.equalTo(passwordT).offset =0;
    }];
    lab3.text =@"记住密码";
    lab3.font =FontSize(14);
    
    UISwitch *SW =[[UISwitch alloc]init];
    [bigView addSubview:SW];
    [SW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lab3).offset =0;
        make.right.equalTo(passwordT).offset =0;
    }];
    [SW addTarget:self action:@selector(savePassword:) forControlEvents:UIControlEventValueChanged];
    SW.on =self.isSelect;
    
    UIButton *logBut =[UIButton buttonWithType:UIButtonTypeSystem];
    [bigView addSubview:logBut];
    [logBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(SW.mas_bottom).offset =40;
        make.centerX.offset =0;
        make.width.offset =screenWigth/5*3;
        make.height.offset =50;

    }];
    [logBut setTitle:@"登录" forState:UIControlStateNormal];
    logBut.backgroundColor =zhuse;
    logBut.titleLabel.font =FontSize(17);
    [logBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logBut.layer.cornerRadius =5;
    logBut.layer.masksToBounds =YES;
//    logBut.showsTouchWhenHighlighted =YES;
    
    [logBut addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)choseCenter{
    
    SiteListViewController *siteListVC =[[SiteListViewController alloc]init];
    
    [self.navigationController pushViewController:siteListVC animated:YES];
    
    DLog(@"选择中心");
  
}

- (void)savePassword:(UISwitch *)sw{
    self.isSelect =sw.on;
    
    
}

- (void)textChange:(UITextField *)textF{
    //密码
    if (textF.tag ==1001) {
        self.passwordStr =textF.text;

    }
    
    if (textF.tag ==1002) {
        self.nameStr =textF.text;
    }
    
}
- (void)login{
    
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    if (self.nameStr.length ==0 ||self.nameStr ==nil) {
        [SVProgressHUD showErrorWithStatus:@"请填写用户名"];
        return;
    }
    
    if (self.passwordStr.length ==0 ||self.passwordStr ==nil) {
        [SVProgressHUD showErrorWithStatus:@"请填写密码"];
        return;
    }
    if ([CustomAccount sharedCustomAccount].stationUrl.length==0 ||[CustomAccount sharedCustomAccount].stationUrl==nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择站点"];
        return;
    }
    
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    if (self.isSelect) {
        [user setObject:self.nameStr forKey:@"name"];
        [user setObject:self.passwordStr forKey:@"password"];
  

    }else{
        [user setObject:@"" forKey:@"name"];
        [user setObject:@"" forKey:@"password"];
  
    }
    [user synchronize];
    
    NSString *urlStr =[NSString stringWithFormat:@"%@api/login/Login",BASEURL];
 
    NSMutableDictionary *parameter =[[NSMutableDictionary alloc]init];
    [parameter setObject:self.passwordStr forKey:@"Password"];
    [parameter setObject:self.nameStr forKey:@"UserName"];
    [parameter setValue:@"true" forKey:@"rememberStatus"];
    [parameter setValue:[user objectForKey:@"stationId"] forKey:@"sid"];
    [parameter setValue:[user objectForKey:@"stationName"] forKey:@"sname"];
    [parameter setValue:@"1" forKey:@"userdel"];

    
    WS(blockSelf);
    [AFNetRequest loginWithPostURL:urlStr Parameters:parameter success:^(id responseObject) {
        DLog(@"responseObject===%@",responseObject);
        if ([responseObject[@"success"] integerValue] ==1) {
            CustomAccount *account =[CustomAccount sharedCustomAccount];
            account.userId =responseObject[@"userid"];
            NSString *str =responseObject[@"token"];
            str =[str stringByReplacingOccurrencesOfString:instailString withString:@"\n"];
            account.accessToken =[NSString stringWithFormat:@"Bearer %@",str];
            
            [blockSelf GetCurrentUser];
        }else{
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    

    
}

- (void)GetCurrentUser{
    
    UIWindow *window =[[UIApplication sharedApplication].delegate window];
    HomePageViewController *homePageVC =[[HomePageViewController alloc]init];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:homePageVC];
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    nav.navigationBar.barTintColor =zhuse;
    window.rootViewController =nav;

    
}
@end
