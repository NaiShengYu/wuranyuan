

//
//  LettersAndVisitsInfoViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "LettersAndVisitsInfoViewController.h"

#import "LettersAndVisitsInfoCell.h"
@interface LettersAndVisitsInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTable;

@property (nonatomic,strong)NSDictionary *dic;

@property (nonatomic,strong)NSMutableArray *titleOneArray;
@property (nonatomic,strong)NSMutableArray *titleTowArray;

@property (nonatomic,copy)NSString *content;//处理结果
@property (nonatomic,assign)CGFloat contentH;
@end

@implementation LettersAndVisitsInfoViewController


- (UITableView *)myTable{
    if (!_myTable) {
        _myTable =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, screenWigth, screenHeight-64) style:UITableViewStylePlain];
        _myTable.delegate = self;
        _myTable.dataSource = self;
       
//        [PubulicObj judgeSystemVersionWithTableView:_myTable];
        [_myTable registerClass:[LettersAndVisitsInfoCell class] forCellReuseIdentifier:@"LettersAndVisitsInfoCell"];
        
        [_myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

      
        
    }
    return _myTable;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _content =@"";
    _contentH =0;
    self.titleOneArray =[[NSMutableArray alloc]initWithObjects:
                         @"处理状况：",
                         @"处理部门：",
                         @"信访编号：",
                         @"信访时间：",
                         @"投诉主题：",
                         @"信访来源：",
                         @"信访缘由：",
                         @"重要程度：",
                         @"信访录入人",
                         @"投诉内容：",
                         @"投诉人：",
                         @"投诉人电话：",
                         @"涉及企业：",
                         @"环保联络人：",
                         @"联络人电话：", nil];
    self.titleTowArray =[[NSMutableArray alloc]initWithObjects:@"办理日期：",
                         @"办结日期：",
                         @"办案人员：",
                         @"批示领导：",
                         @"处理结果：",
                         @"对领导批示：",
                         @"局领导批示：",
                         @"审核意见：", nil];
    [self.view addSubview:self.myTable];
    [self customNavigationBar];
    [self makeData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return self.titleOneArray.count;
    }
    return self.titleTowArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
       
        if (indexPath.row ==10) {
            return 140;
        }
        return 49;
    }else{
        if (indexPath.row ==4) {
            if (self.contentH +20.0<49.0) {
                return 49;
            }
            return self.contentH +20;
        }
        
    }
    
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *header =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header =[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"header"];
        UILabel *lab =[[UILabel alloc]init];
        [header.contentView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset =-10;
            make.left.offset =10;
        }];
        lab.textColor =[UIColor redColor];
        lab.tag =1000;
    }
    UILabel *lab =[header.contentView viewWithTag:1000];
    if (section ==0) {
        lab.text =@"信 访 内 容";

    }else{
        
        lab.text =@"处 理 情 况";

    }
    
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LettersAndVisitsInfoCell *cell =[tableView dequeueReusableCellWithIdentifier:@"LettersAndVisitsInfoCell" forIndexPath:indexPath];
    if (indexPath.section ==0) {
        cell.leftTitleLab.text =self.titleOneArray[indexPath.row];

        switch (indexPath.row) {
            case 0:
                cell.leftLab.text =self.dic[@"STATEDESC"];
                
                break;
            case 1:
                
                cell.leftLab.text =self.dic[@"DepartmenName"];
                
                break;
            case 2:
                cell.leftLab.text =self.dic[@"SERIALNO"];
                
                break;
            case 3:
                @try {
                    cell.leftLab.text =[self.dic[@"ORDERDATE"] substringToIndex:10];
                } @catch (NSException *exception) {
                } @finally {
                }
                break;
            case 4:
                cell.leftLab.text =self.dic[@"TITLE"];
                
                break;
            case 5:
                cell.leftLab.text =@"";
                
                break;
            case 6:
                cell.leftLab.text =self.dic[@"SourceName"];
                
                break;
            case 7:
                cell.leftLab.text =self.dic[@"ReasonName"];
                
                break;
            case 8:
                cell.leftLab.text =@"重要";
                
                break;
            case 9:
                cell.leftLab.text =self.dic[@"editname"];
                
                break;
            case 10:
                cell.leftLab.text =self.dic[@"SPETITIONCONTENT"];
                
                break;
            case 11:
                cell.leftLab.text =self.dic[@"PETITIONERNAME"];
                
                break;
            case 12:
                cell.leftLab.text =self.dic[@"TELEPHONE"];
                
                break;
            case 13:
                cell.leftLab.text =self.dic[@"name"];
                
                break;
            case 14:
                cell.leftLab.text =self.dic[@"CONTACTNAME"];
                
                break;
            case 15:
                cell.leftLab.text =self.dic[@"CONTACTTEL"];
                break;
            default:
                break;
        }
    }else{
        cell.leftTitleLab.text =self.titleTowArray[indexPath.row];

        switch (indexPath.row) {
            case 0:
                cell.leftLab.text =[self.dic[@"ENDLINEDATE"] substringToIndex:10];
                
                break;
            case 1:
                @try {
                    cell.leftLab.text =[self.dic[@"UPDATEDATETIME"] substringToIndex:10];
                } @catch (NSException *exception) {
                    
                } @finally {
                }
                
                break;
            case 2:
                cell.leftLab.text =self.dic[@"ProcessorName"];
                
                break;
            case 3:
                cell.leftLab.text =[NSString stringWithFormat:@"%@",self.dic[@"SIGNUSERID"]];
                break;
            case 4:
                cell.leftLab.text =self.content;

                break;
            case 5:
            {
                cell.leftLab.text =@"";
            }
                
                break;
            case 6:
                cell.leftLab.text =@"";
                
                break;
            case 7:
                cell.leftLab.text =@"";

                break;
          
            default:
                break;
        }
        
        
        
        
    }
 
    
    return cell;

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
    
    self.title =@"信访管理";
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

#pragma mark --获取信访详情
- (void)makeData{
    
    WS(blockSelf);
    NSString *urlStr =[NSString stringWithFormat:@"%@api/AppEnterprise/GetPetitionByid?id=%@",BASEURL,self.ID];
    [AFNetRequest HttpGetCallBack:urlStr Parameters:nil success:^(id responseObject) {
        blockSelf.dic =responseObject;
        
        //对处理结果去标签
        NSString *str = blockSelf.dic[@"RESULTCONTENT"];
        str =[str stringByReplacingOccurrencesOfString:@"<div" withString:@""];
        str =[str stringByReplacingOccurrencesOfString:@"style=" withString:@""];
        str =[str stringByReplacingOccurrencesOfString:@"\"TEXT-JUSTIFY: inter-ideograph; TEXT-ALIGN: justify; FONT-SIZE: 14px\"" withString:@""];
        str =[str stringByReplacingOccurrencesOfString:@"id=" withString:@""];
        str =[str stringByReplacingOccurrencesOfString:@"\"resultContent_td\"" withString:@""];
        str =[str stringByReplacingOccurrencesOfString:@"<p class=" withString:@""];
        str =[str stringByReplacingOccurrencesOfString:@">" withString:@""];
        str =[str stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
        str =[str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
        str =[str stringByReplacingOccurrencesOfString:@"\"p0\"" withString:@""];
        str =[str stringByReplacingOccurrencesOfString:@"</p" withString:@""];
        str =[str stringByReplacingOccurrencesOfString:@"<br /" withString:@"\n"];
        str =[str stringByReplacingOccurrencesOfString:@"</div" withString:@""];
        
        UILabel *lab =[UILabel new];
        lab.text =str;
        lab.numberOfLines =0;
        lab.font =FontSize(15);
        CGSize size = [lab sizeThatFits:CGSizeMake(screenWigth-110, MAXFLOAT)];
        
        blockSelf.contentH =size.height;

        blockSelf.content =str;
        [blockSelf.myTable reloadData];
    } failure:^(NSError *error) {
        
    } isShowHUD:YES];
    
    
    
    
}

@end
