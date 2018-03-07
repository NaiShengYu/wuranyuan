//
//  AppDelegate.m
//  ProjectDemo
//
//  Created by 俞乃胜, Stephen on 2017/12/6.
//  Copyright © 2017年 俞乃胜, Stephen. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
@interface AppDelegate ()<BMKLocationServiceDelegate>
{
    BMKMapManager *_mapManager;
    
}
@property (nonatomic,strong)JFLocation *loc;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"ThVgf1vtm9rFdwTF23qVzZIYUZefdZkK"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }else{
        NSLog(@"注册成功");
        
    }

    self.loc =[[JFLocation alloc]init];//定位

    
    //让键盘下去的第三方库
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    
    self.window = [[UIWindow alloc] init];
    ViewController *VC =[[ViewController alloc]init];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:VC];
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    nav.navigationBar.barTintColor =zhuse;
    nav.navigationBar.translucent =NO;
    self.window.backgroundColor =[UIColor whiteColor];
    self.window.rootViewController =nav;
    [self.window makeKeyAndVisible];

 
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
