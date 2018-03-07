//
//  HomePageViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/8.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageHeader.h"
#import "HomePageCell.h"
#import "AirEnvironmentViewController.h"//空气环境
#import "PollutionSourceViewController.h"//污染源在线
@interface HomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic,strong)UICollectionView *myCollection;

@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *pickArray;
@end

@implementation HomePageViewController

- (UICollectionView *)myCollection{
    if (!_myCollection) {
        
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing =4;
        layout.minimumInteritemSpacing =4;
        _myCollection =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenWigth, screenHeight) collectionViewLayout:layout];
        _myCollection.delegate =self;
        _myCollection.dataSource =self;
        _myCollection.backgroundColor =[UIColor groupTableViewBackgroundColor];
        [_myCollection registerClass:[HomePageCell class] forCellWithReuseIdentifier:@"HomePageCell"];
        
        [_myCollection registerClass:[HomePageHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomePageHeader"];
  
    }
    return _myCollection;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sectionArray =[[NSMutableArray alloc]initWithObjects:@"环境质量综合分析预警平台",@"应急智慧调度决策",@"污染源在线", nil];
    
    NSArray* arr1 =@[@"voc",@"air",@"water",@"noise",@"soil",@"radiation",@"dust",@"hazard"];
    NSArray *arr2 =@[@"emerg"];
    NSArray *arr3 =@[@"poll"];
    self.pickArray =[[NSMutableArray alloc]initWithObjects:arr1,arr2,arr3, nil];

    
    
    self.title =@"智慧环保预警平台";
    [self.view addSubview:self.myCollection];
  
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionArray.count;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section ==0) {
        return 8;
    }else{
        return 1;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return CGSizeMake((screenWigth-32)/4, (screenWigth-32)/4);
    }else{
        return CGSizeMake(screenWigth-20, imgHeght(140));
        }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(screenWigth, 40);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section ==2) {
        return CGSizeMake(screenWigth, 10);
    }
    return CGSizeMake(0, 0);
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HomePageHeader *header =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomePageHeader" forIndexPath:indexPath];
    
    header.titleLab.text =self.sectionArray[indexPath.section];
    return header;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomePageCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCell" forIndexPath:indexPath];
    NSArray *arr =self.pickArray[indexPath.section];
    cell.imageV.image =[UIImage imageNamed:arr[indexPath.row]];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            {
                switch (indexPath.row) {
                    case 0:
                        {
                            
                            
                        }
                        break;
                    case 1:
                        {
                            AirEnvironmentViewController *airEnvironmentVC =[[AirEnvironmentViewController alloc]init];
                            [self.navigationController pushViewController:airEnvironmentVC animated:YES];
                            
                        }
                        break;
                    case 2:
                        {
                            
                            
                        }
                        break;
                        
                    default:
                        break;
                }
                
            }
            break;
        case 1:
            {
                
                
            }
            break;
        case 2:
            {
                PollutionSourceViewController *pollutionSourceVC =[[PollutionSourceViewController alloc]init];
                [self.navigationController pushViewController:pollutionSourceVC animated:YES];
                
                
            }
            break;
            
        default:
            break;
    }
    
  
    
}

//当cell高亮时返回是否高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    //设置(Highlight)高亮下的颜色
    cell.contentView.backgroundColor =[UIColor blackColor];
}

- (void)collectionView:(UICollectionView *)colView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [colView cellForItemAtIndexPath:indexPath];
    //设置(Nomal)正常状态下的颜色
    cell.contentView.backgroundColor =[UIColor yellowColor];
}

@end
