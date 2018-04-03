//
//  DailyManagementInfoViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "DailyManagementInfoViewController.h"

@interface DailyManagementInfoViewController ()

@end

@implementation DailyManagementInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    UIScrollView *scr =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, screenWigth, screenHeight-64)];
    [self.view addSubview:scr];
    
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWigth-20, screenHeight)];
    NSString *str  =[NSString stringWithFormat:@"执法时间:\n%@\n执法人员:\n%@\n执法内容:\n%@\n执法要求:\n%@",[self.model.SUPERVISEDATE substringToIndex:10],self.model.SUPERVISOR,self.model.CONTEXT,self.model.IMPROVECONTEXT];
    lab.numberOfLines =0;
    
    NSMutableAttributedString *att =[[NSMutableAttributedString alloc]initWithString:str attributes:nil];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 5)];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6+11, 5)];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(22+1+self.model.SUPERVISOR.length+1, 5)];
    [att addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(22+1+self.model.SUPERVISOR.length+1+1+self.model.CONTEXT.length+1+5, 5)];
    
    lab.text =str;
    CGSize size =[lab sizeThatFits:CGSizeMake(screenWigth-20, MAXFLOAT)];
    lab.frame =CGRectMake(10, 10, screenWigth-20, size.height);
    scr.contentSize = CGSizeMake(screenWigth, size.height +20);
    
    lab.attributedText =att;
    [scr addSubview:lab];
    
    [self customNavigationBar];

}

#pragma mark --自定义导航栏
- (void)customNavigationBar{
    
    self.title =@"日常监管";
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

@end
