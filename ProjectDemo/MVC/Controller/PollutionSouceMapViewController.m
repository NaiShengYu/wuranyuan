//
//  MapViewController.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/9.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "PollutionSouceMapViewController.h"
#import "MapAnnotationView.h"
#import "PollutionSouceInfoViewController.h"
#import "PollutionSouceModel.h"
#import "FactorModel.h"
@interface PollutionSouceMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (nonatomic,strong)BMKMapView *mapView;


@property (nonatomic,strong)BMKLocationService *location;

@property (nonatomic,strong)NSMutableArray *annotationArray;

@property (nonatomic,strong)NSMutableArray *bottomTitleArray;

@property (nonatomic,strong)UIButton *lastBut;


@end

@implementation PollutionSouceMapViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    self.bottomTitleArray =[[NSMutableArray alloc]init];
    FactorModel *factModel =[[FactorModel alloc]init];
    factModel.name =@"AQI";
    [self.bottomTitleArray addObject:factModel];
    
    _mapView =[[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, screenWigth, screenHeight-SafeAreaBottomHeight)];
    _mapView.showsUserLocation =YES;//是否显示定位
    _mapView.zoomLevel =9;
    _mapView.userTrackingMode =BMKUserTrackingModeFollow;
    [self.view addSubview:_mapView];
    _mapView.delegate =self;
    
//    //添加图层覆盖物，可画出区域边界
//    NSArray *arr =@[@[@"121.266375",@"30.339198"],@[@"121.84474",@"29.854256"],@[@"121.542335",@"29.546055"],@[@"121.046757",@"29.60536"]];
//    CLLocationCoordinate2D *coors = malloc([arr count]*sizeof(CLLocationCoordinate2D));
//    for (int i =0; i <arr.count; i ++) {
//        coors[i].longitude =[arr[i][0] doubleValue];
//        coors[i].latitude =[arr[i][1] doubleValue];
//    }
//
//    BMKPolygon *gon =[BMKPolygon polygonWithCoordinates:coors count:arr.count] ;
//    [_mapView addOverlay:gon];
//
//    NSArray *arr1 =@[@[@"121.957424",@"30.180482"],@[@"122.110351",@"30.160499"],@[@"122.328819",@"29.962451"]];
//    CLLocationCoordinate2D *coors1 = malloc([arr count]*sizeof(CLLocationCoordinate2D));
//    for (int i =0; i <arr1.count; i ++) {
//        coors1[i].longitude =[arr1[i][0] doubleValue];
//        coors1[i].latitude =[arr1[i][1] doubleValue];
//    }
//
//    BMKPolygon *gon1 =[BMKPolygon polygonWithCoordinates:coors1 count:arr1.count] ;
//    [_mapView addOverlay:gon1];
//
    
    
    
    
    BMKLocationViewDisplayParam *param =[[BMKLocationViewDisplayParam alloc]init];
    param.locationViewOffsetY = 0;//偏移量
    param.locationViewOffsetX = 0;
    param.isAccuracyCircleShow =NO;//设置是否显示定位的那个精度圈
    //    param.isRotateAngleValid = NO;//跟随态旋转角度是否生效
    [_mapView updateLocationViewWithParam:param];
    
    _location =[[BMKLocationService alloc]init];
    //设定定位的最小更新距离
    _location.distanceFilter =30;
    [_location startUserLocationService];
    
    [self customNavigationBar];
    
    
    
    
    
    _annotationArray =[[NSMutableArray alloc]init];

    for (NSInteger i =0; i <self.pullutionsArray.count; i ++) {
        PollutionSouceModel *model =self.pullutionsArray[i];
        BMKPointAnnotation *annotation =[[BMKPointAnnotation alloc]init];
        annotation.coordinate =CLLocationCoordinate2DMake([model.lat floatValue], [model.lng floatValue]);
        annotation.title =[NSString stringWithFormat:@"%@",model.name];
        [_annotationArray addObject:annotation];
    }
    [self.mapView addAnnotations:_annotationArray];
    
}

//绘制覆盖区域
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay{
   
    if ([overlay isKindOfClass:[BMKPolygon class]]) {
        BMKPolygonView *gon =[[BMKPolygonView alloc]initWithPolygon:overlay];
        gon.strokeColor =zhuse;
        gon.lineWidth =0.1;
        gon.fillColor =[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:0.2];
        NSLog(@"中心点坐标：%f---%f",overlay.coordinate.latitude,overlay.coordinate.longitude);
        
        return gon;
    }
    return nil;
 
}


- (void)setPullutionsArray:(NSMutableArray *)pullutionsArray{
    _pullutionsArray =pullutionsArray;
    
    
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
    DLog(@"%@",annotationView.titleLab.text);
    for (PollutionSouceModel *model in self.pullutionsArray) {
        if ([model.name containsString:annotationView.titleLab.text]) {
            PollutionSouceInfoViewController *pollutionInfoVC =[[PollutionSouceInfoViewController alloc]init];
            pollutionInfoVC.souceModel =model;
            pollutionInfoVC.title =model.name;
            [self.navigationController pushViewController:pollutionInfoVC animated:YES];
        }
    }
    annotationView.selected =NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _location.delegate =self;
    _mapView.delegate =self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _mapView.delegate =nil;
    _location.delegate =nil;
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    DLog(@"方向改变了");
    //    _mapView.centerCoordinate =userLocation.location.coordinate;
    [_mapView updateLocationData:userLocation];
    
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    DLog(@"位置改变了");
    NSLog(@"%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //    _mapView.centerCoordinate =userLocation.location.coordinate;
    [_mapView updateLocationData:userLocation];
}



#pragma mark --自定义导航栏
- (void)customNavigationBar{
    self.title =@"污染源在线 分布情况";
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

