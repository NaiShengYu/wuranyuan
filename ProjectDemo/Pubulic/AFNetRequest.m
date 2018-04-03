//
//  AFNetRequest.m
//  ShangChengApp
//
//  Created by 俞乃胜 on 16/11/30.
//  Copyright © 2016年 俞乃胜. All rights reserved.
//

#import "AFNetRequest.h"
@implementation AFNetRequest
// post 请求
+ (void)HttpPostCallBack:(NSString*)Url  Parameters:(NSDictionary*)dict success:(httpSuccess)success failure:(httpFailure)failure isShowHUD:(BOOL)animation
{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus    status) {
//        if (status ==AFNetworkReachabilityStatusNotReachable) {
//            [SVProgressHUD showErrorWithStatus:@"网络无连接!"];
//            DLog(@"网络连接不上");
//        }else{
            NSString *urlstr = [[NSString stringWithFormat:@"https://%@/%@",[CustomAccount sharedCustomAccount].stationUrl,Url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"URL===%@",urlstr);
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [manager.requestSerializer setValue:[CustomAccount sharedCustomAccount].accessToken forHTTPHeaderField:@"Authorization"];
            DLog(@"accessToken==%@",[CustomAccount sharedCustomAccount].accessToken);
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
            manager.securityPolicy.validatesDomainName = NO;
            manager.securityPolicy.allowInvalidCertificates = YES;
            
            if (animation) {
                        [SVProgressHUD show];
                }
            [manager POST:urlstr parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (animation) {
                    [SVProgressHUD dismiss];
                }
                NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                
//                DLog(@"responseObject==%@",responseObject);
//                DLog(@"str=%@",str);
//                str =[str stringByReplacingOccurrencesOfString:@"\n" withString:instailString];
//                str =[str stringByReplacingOccurrencesOfString:@"\r" withString:instailString];
//                str =[str stringByReplacingOccurrencesOfString:@"\t" withString:instailString];
//                
//                DLog(@"str2=%@",str);
                
                NSData *resData = [[NSData alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
                //系统自带JSON解析
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (success) {
                        success(resultDic);
                    }
                });
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (animation) {
                    [SVProgressHUD dismiss];
                }
                if (error) {
                    failure (error);
                }
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
                DLog(@"%@",error);
                
            }];

//        }
//       }];

    
    
}

+ (void)loginWithPostURL:(NSString *)Url Parameters:(NSDictionary *)dict success:(httpSuccess)success failure:(httpFailure)failure{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus    status) {
//        if (status ==AFNetworkReachabilityStatusNotReachable) {
//            [SVProgressHUD showErrorWithStatus:@"网络无连接!"];
//            DLog(@"网络连接不上");
//        }else{
    
    
    Url = [[NSString stringWithFormat:@"https://%@/%@",[CustomAccount sharedCustomAccount].stationUrl,Url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"URL===%@",Url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:@"Bearer 19848c55-5b1d-4beb-a161-ff8301359710" forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.validatesDomainName = NO;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    
    [SVProgressHUD show];
 
    
    [manager POST:Url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        str =[str stringByReplacingOccurrencesOfString:@"\n" withString:instailString];
        str =[str stringByReplacingOccurrencesOfString:@"\r" withString:instailString];
        str =[str stringByReplacingOccurrencesOfString:@"\t" withString:instailString];
        
        DLog(@"str2=%@",str);
        
        NSData *resData = [[NSData alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingAllowFragments error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(resultDic);
            }
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (error) {
            failure (error);
        }
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        DLog(@"%@",error);
        
    }];
    
    //        }
    //    }];
    
    
    
    
    
}

// get  请求
+ (void)HttpGetCallBack:(NSString*)Url
             Parameters:(NSDictionary*)dict
                success:(httpSuccess)success
                failure:(httpFailure)failure
              isShowHUD:(BOOL)animation{
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    Url = [NSString stringWithString:[Url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:[CustomAccount sharedCustomAccount].accessToken forHTTPHeaderField:@"Authorization"];

        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.securityPolicy.validatesDomainName = NO;
        manager.securityPolicy.allowInvalidCertificates = YES;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        if (animation) {
            [SVProgressHUD show];
        }
        DLog(@"url ===%@",[NSString stringWithFormat:@"https://%@/%@", [CustomAccount sharedCustomAccount].stationUrl, Url]);
        
        DLog(@"accessToken==%@",[CustomAccount sharedCustomAccount].accessToken);
        
        [manager GET:[NSString stringWithFormat:@"https://%@/%@", [CustomAccount sharedCustomAccount].stationUrl, Url] parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (animation) {
                [SVProgressHUD dismiss];
            }
            
            NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            DLog(@"responseObject==%@",responseObject);
            DLog(@"str=%@",str);
            NSError *err;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&err];
            DLog(@"dic==%@",responseDic);
            if (err) {
                DLog(@"err==%@",err);
            }
            
            str =[str stringByReplacingOccurrencesOfString:@"\n" withString:instailString];
            str =[str stringByReplacingOccurrencesOfString:@"\r" withString:instailString];
            str =[str stringByReplacingOccurrencesOfString:@"\t" withString:instailString];
            
            str =[str stringByReplacingOccurrencesOfString:@"\a" withString:instailString];
            str =[str stringByReplacingOccurrencesOfString:@"\b" withString:instailString];
            str =[str stringByReplacingOccurrencesOfString:@"\f" withString:instailString];
            str =[str stringByReplacingOccurrencesOfString:@"\v" withString:instailString];
            str =[str stringByReplacingOccurrencesOfString:@"\e" withString:instailString];
            //                    DLog(@"list===%@",list);
            str =[str stringByReplacingOccurrencesOfString:@"4.94065645841247E-324" withString:@"99.9999"];
            
            DLog(@"str2=%@",str);
            
            NSData *resData = [[NSData alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
            //系统自带JSON解析
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    success(resultDic);
                }
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                DLog(@"error====%@",error);
                [SVProgressHUD dismiss];
                if (animation) {
                    [SVProgressHUD showErrorWithStatus:@"网络错误"];
                }
                if (failure) {
                    failure(error);
                }
            });
        }];
        
        //              }
        //        }];
    });
    
    
}

// 获取地址请求
+ (void)HttpGetAddressBack:(NSString*)Url  Parameters:(NSDictionary*)dict success:(httpSuccess)success failure:(httpFailure)failure isShowHUD:(BOOL)animation
{

    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    Url = [Url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{

//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if (status ==AFNetworkReachabilityStatusNotReachable) {
//            [SVProgressHUD showErrorWithStatus:@"网络不能连接!"];
//            NSLog(@"网络不能连接");
//        }else{
            if (animation) {
                [SVProgressHUD show];
            }
        
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            
            manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
            manager.securityPolicy.validatesDomainName = NO;
            manager.securityPolicy.allowInvalidCertificates = YES;
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        DLog(@"url ===%@",[NSString stringWithFormat:@"https://%@/%@", [CustomAccount sharedCustomAccount].stationUrl, Url]);
            [manager GET:[NSString stringWithFormat:@"https://%@/%@", [CustomAccount sharedCustomAccount].stationUrl, Url] parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (animation) {
                        [SVProgressHUD dismiss];
                    }

                    NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
              
                    DLog(@"responseObject==%@",responseObject);
                    DLog(@"str=%@",str);
                    NSError *err;
                    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&err];
                    DLog(@"dic==%@",responseDic);
                    if (err) {
                        DLog(@"err==%@",err);
                    }

                    str =[str stringByReplacingOccurrencesOfString:@"\n" withString:instailString];
                    str =[str stringByReplacingOccurrencesOfString:@"\r" withString:instailString];
                    str =[str stringByReplacingOccurrencesOfString:@"\t" withString:instailString];

                    str =[str stringByReplacingOccurrencesOfString:@"\a" withString:instailString];
                    str =[str stringByReplacingOccurrencesOfString:@"\b" withString:instailString];
                    str =[str stringByReplacingOccurrencesOfString:@"\f" withString:instailString];
                    str =[str stringByReplacingOccurrencesOfString:@"\v" withString:instailString];
                    str =[str stringByReplacingOccurrencesOfString:@"\e" withString:instailString];
//                    DLog(@"list===%@",list);
                    str =[str stringByReplacingOccurrencesOfString:@"4.94065645841247E-324" withString:@"99.9999"];
                    
                    DLog(@"str2=%@",str);

                    NSData *resData = [[NSData alloc] initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
                    //系统自带JSON解析
                    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];

                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (success) {
                            success(resultDic);
                        }
                    });
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        DLog(@"error====%@",error);
                        [SVProgressHUD dismiss];
                        if (animation) {
                            [SVProgressHUD showErrorWithStatus:@"网络错误"];
                        }
                        if (failure) {
                            failure(error);
                        }
                    });
                }];
           
//              }
//        }];
    });

}

@end
