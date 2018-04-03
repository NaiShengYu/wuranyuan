//
//  MapViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/9.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "MapViewController.h"
#import "MapAnnotationView.h"

#import "PagedListModel.h"
#import "FactorModel.h"
@interface MapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (nonatomic,strong)BMKMapView *mapView;


@property (nonatomic,strong)BMKLocationService *location;

@property (nonatomic,strong)NSMutableArray *annotationArray;

@property (nonatomic,strong)NSMutableArray *bottomTitleArray;

@property (nonatomic,strong)UIButton *lastBut;


@end

@implementation MapViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.bottomTitleArray =[[NSMutableArray alloc]init];
    FactorModel *factModel =[[FactorModel alloc]init];
    factModel.name =@"AQI";
    [self.bottomTitleArray addObject:factModel];
    
    _mapView =[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, screenWigth, screenHeight-SafeAreaBottomHeight-54)];
    _mapView.showsUserLocation =YES;//是否显示定位
    _mapView.zoomLevel =9;
    _mapView.userTrackingMode =BMKUserTrackingModeFollow;
    [self.view addSubview:_mapView];
    _mapView.delegate =self;
    
    BMKLocationViewDisplayParam *param =[[BMKLocationViewDisplayParam alloc]init];
    param.locationViewOffsetY = 0;//偏移量
    param.locationViewOffsetX = 0;
    param.isAccuracyCircleShow =NO;//设置是否显示定位的那个精度圈
    //    param.isRotateAngleValid = NO;//跟随态旋转角度是否生效
    [_mapView updateLocationViewWithParam:param];
    
    _location =[[BMKLocationService alloc]init];
    _location.delegate =self;
    //设定定位的最小更新距离
    _location.distanceFilter =30;
    [_location startUserLocationService];
    
    [self getItemIdWithModel];
    [self customNavigationBar];
    
    _annotationArray =[[NSMutableArray alloc]init];
    
    for (NSInteger i =0; i <self.airEnvironmentArray.count; i ++) {
        PagedListModel *model =self.airEnvironmentArray[i];
        BMKPointAnnotation *annotation =[[BMKPointAnnotation alloc]init];
        annotation.coordinate =CLLocationCoordinate2DMake([model.StationLat floatValue], [model.StationLng floatValue]);
        annotation.title =[NSString stringWithFormat:@"%@",model.aqiInfoModel.AQI];
        [_annotationArray addObject:annotation];

    }
    [self.mapView addAnnotations:_annotationArray];

}
- (void)setAirEnvironmentArray:(NSMutableArray *)airEnvironmentArray{
    
    _airEnvironmentArray = airEnvironmentArray;
     
}
- (void)creatBottomeBut{
    UIView *bottomView =[UIView new];
    [self.view addSubview:bottomView];
    WS(blockSelf);
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blockSelf.mapView.mas_bottom).offset =0;
        make.left.equalTo(blockSelf.view).offset =0;
        make.bottom.equalTo(blockSelf.view).offset =0;
        make.right.equalTo(blockSelf.view).offset =0;
    }];
    bottomView.backgroundColor =zhuse;
    
    
    CGFloat w =(screenWigth-(self.bottomTitleArray.count +1)*10)/self.bottomTitleArray.count;
    for (int i =0; i <self.bottomTitleArray.count; i ++) {
        FactorModel *model =self.bottomTitleArray[i];
        UIButton *but =[[UIButton alloc]initWithFrame:CGRectMake(10 +(w+10)*i, 10, w, 34)];
        [bottomView addSubview:but];
        but.layer.cornerRadius =4;
        but.layer.masksToBounds =YES;
   
        but.backgroundColor =RGBA(55, 150, 230, 1);
        
        [but setTitle:model.name forState:UIControlStateNormal];
        but.tag =2300+i;
        [but addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
        if (i ==0) {
            _lastBut =but;
            but.backgroundColor =[UIColor grayColor];
        }
        
    }
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    
        if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
            static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
            MapAnnotationView * annotationView = (MapAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
            if (annotationView == nil) {
                annotationView = [[MapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
 
            }
            DLog(@"%f---%f",annotation.coordinate.latitude,annotation.coordinate.longitude);;
            annotationView.titleLab.text =annotation.title;
            

            return annotationView;
        }
        return nil;
 
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    MapAnnotationView * annotationView = (MapAnnotationView *)view;
    NSLog(@"%@",annotationView.titleLab.text);
    //保证可以重复点击
    annotationView.selected =NO;
    [mapView mapForceRefresh];
    
}

#pragma mark --改变筛选状态
- (void)changeSelect:(UIButton *)but{
    if (_lastBut ==but) {
        return;
    }
    _lastBut.backgroundColor =RGBA(55, 150, 230, 1);
    but.backgroundColor =[UIColor grayColor];


    _lastBut =but;
    FactorModel *model =self.bottomTitleArray [but.tag-2300];
    self.title =[NSString stringWithFormat:@"%@ 分布情况",model.name];


    if (but.tag >2300) {


        [self.mapView removeAnnotations:self.annotationArray];
        [self getItemNumWithModel:model];

    }else{
        for (NSInteger i =0; i <self.airEnvironmentArray.count; i ++) {
            PagedListModel *model =self.airEnvironmentArray[i];
            BMKPointAnnotation *annotation =[[BMKPointAnnotation alloc]init];
            annotation.coordinate =CLLocationCoordinate2DMake([model.StationLat floatValue], [model.StationLng floatValue]);
            DLog(@"%@",model.aqiInfoModel.AQI);
            annotation.title =[NSString stringWithFormat:@"%@",model.aqiInfoModel.AQI];
            [_annotationArray addObject:annotation];
        }
        [self.mapView addAnnotations:_annotationArray];
    }
  
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _mapView.delegate =self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _mapView.delegate =nil;
    
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    DLog(@"方向改变了");
    //    _mapView.centerCoordinate =userLocation.location.coordinate;
    [_mapView updateLocationData:userLocation];
    
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    DLog(@"位置改变了");
//    _mapView.centerCoordinate =userLocation.location.coordinate;
    [_mapView updateLocationData:userLocation];
}


#pragma mark --获取站点因子
- (void)getItemIdWithModel{
    WS(blockSelf);
    if (self.airEnvironmentArray.count ==0) {
        return;
    }
    PagedListModel *pageModel =self.airEnvironmentArray[0];
    NSString *str =[NSString stringWithFormat:@"%@api/location/GetFactors?id=%@",BASEURL,pageModel.StationId];
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
            if (![factorModel.name isEqualToString:@"SO2"] && ![factorModel.name isEqualToString:@"NO2"]) {
                [self.bottomTitleArray addObject:factorModel];
            }
        }

        [blockSelf creatBottomeBut];
    } failure:^(NSError *error) {

    } isShowHUD:YES];
}


#pragma mark --获取因子最新值
-(void)getItemNumWithModel:(FactorModel *)factModel{

    NSString *urlStr =[NSString stringWithFormat:@"%@api/FactorData/GetLastRefFacVals",BASEURL];

    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setObject:factModel.Id forKey:@"facId"];
    [dic setObject:@"0" forKey:@"fromType"];
    NSMutableArray *arr =[[NSMutableArray alloc]init];
    for (PagedListModel *model in self.airEnvironmentArray) {
        [arr addObject:model.StationId];
    }

    [dic setObject:arr forKey:@"refIds"];
    WS(blockSelf);


    [AFNetRequest HttpPostCallBack:urlStr Parameters:dic success:^(id responseObject) {
        DLog(@"responseObject===%@",responseObject);
        for (PagedListModel *pageModel in blockSelf.airEnvironmentArray) {
            for (NSDictionary *resurlDic in responseObject) {
                factModel.val =[NSString stringWithFormat:@"%@ ug/m3",resurlDic[@"val"]];
                if ([resurlDic[@"refId"] isEqualToString:pageModel.StationId]) {
                    if ([factModel.name isEqualToString:@"PM2.5"]) {
                        pageModel.PM25 =[resurlDic[@"val"] floatValue];
                    }
                    if ([factModel.name isEqualToString:@"PM10"]) {
                        pageModel.PM10 =[resurlDic[@"val"] floatValue];
                    }
                    if ([factModel.name isEqualToString:@"O3"]) {
                        pageModel.O3 =[resurlDic[@"val"] floatValue];
                    }
                    if ([factModel.name isEqualToString:@"CO"]) {
                        DLog(@"%@,co的值：%@",pageModel.StationName,resurlDic[@"val"]);
                        pageModel.CO =[resurlDic[@"val"] floatValue];
                    }
                }
            }

        }

        [blockSelf.mapView removeAnnotations:blockSelf.annotationArray];
        [blockSelf.annotationArray removeAllObjects];
        if ([factModel.name isEqualToString:@"PM2.5"]) {
            for (NSInteger i =0; i <blockSelf.airEnvironmentArray.count; i ++) {
                PagedListModel *model =blockSelf.airEnvironmentArray[i];
                BMKPointAnnotation *annotation =[[BMKPointAnnotation alloc]init];
                annotation.coordinate =CLLocationCoordinate2DMake([model.StationLat floatValue], [model.StationLng floatValue]);
                annotation.title =[NSString stringWithFormat:@"%.2f",model.PM25];
                [blockSelf.annotationArray addObject:annotation];
            }
            [blockSelf.mapView addAnnotations:blockSelf.annotationArray];
        }
        if ([factModel.name isEqualToString:@"PM10"]) {
            for (NSInteger i =0; i <blockSelf.airEnvironmentArray.count; i ++) {
                PagedListModel *model =blockSelf.airEnvironmentArray[i];
                BMKPointAnnotation *annotation =[[BMKPointAnnotation alloc]init];
                annotation.coordinate =CLLocationCoordinate2DMake([model.StationLat floatValue], [model.StationLng floatValue]);
                annotation.title =[NSString stringWithFormat:@"%.2f",model.PM10];
                [blockSelf.annotationArray addObject:annotation];
            }
            [blockSelf.mapView addAnnotations:blockSelf.annotationArray];
        }
        if ([factModel.name isEqualToString:@"O3"]) {
            for (NSInteger i =0; i <blockSelf.airEnvironmentArray.count; i ++) {
                PagedListModel *model =blockSelf.airEnvironmentArray[i];
                BMKPointAnnotation *annotation =[[BMKPointAnnotation alloc]init];
                annotation.coordinate =CLLocationCoordinate2DMake([model.StationLat floatValue], [model.StationLng floatValue]);
                annotation.title =[NSString stringWithFormat:@"%.2f",model.O3];
                [blockSelf.annotationArray addObject:annotation];
            }
            [blockSelf.mapView addAnnotations:blockSelf.annotationArray];
        }
        if ([factModel.name isEqualToString:@"CO"]) {
            for (NSInteger i =0; i <blockSelf.airEnvironmentArray.count; i ++) {
                PagedListModel *model =blockSelf.airEnvironmentArray[i];
                BMKPointAnnotation *annotation =[[BMKPointAnnotation alloc]init];
                annotation.coordinate =CLLocationCoordinate2DMake([model.StationLat floatValue], [model.StationLng floatValue]);
                annotation.title =[NSString stringWithFormat:@"%.2f",model.CO];
                [blockSelf.annotationArray addObject:annotation];
            }
            [blockSelf.mapView addAnnotations:blockSelf.annotationArray];
        }
//        [blockSelf.myTable reloadData];
    } failure:^(NSError *error) {

    } isShowHUD:NO];
}


#pragma mark --自定义导航栏
- (void)customNavigationBar{
    self.title =@"AQI 分布情况";
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
