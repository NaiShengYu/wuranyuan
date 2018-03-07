//
//  PubulicObj.m
//  APPDemoForAll
//
//  Created by 俞乃胜 on 17/2/9.
//  Copyright © 2017年 俞乃胜. All rights reserved.
//

#import "PubulicObj.h"

@implementation PubulicObj
#pragma  --判断是否是手机号码
+ (NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return @"手机号长度只能是11位";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return @"是";
        }else{
            return @"请输入正确的电话号码";
        }
    }
    return nil;
}
//#pragma mark --判断是否登录
//+ (BOOL)isLoging{
//    
//    FMDBTOOL *tool =[[FMDBTOOL alloc]init];
//    NSDictionary *userInfo =[tool selectData];
//    NSString *code =[userInfo objectForKey:@"userid"];
//    if (userInfo.allKeys.count ==0) {
//        return NO;
//    }
//    if ([code integerValue] !=0) {
//        return YES;
//    }
//    return NO;
//}
#pragma mark -- 系统缓存大小
+ (float)getFileSize
{
    NSFileManager *manager =[NSFileManager defaultManager]
    ;
    NSString *path =[NSString stringWithFormat:@"%@/Library/",NSHomeDirectory()];
    DLog(@"path ==%@",path);
    NSArray *childerFiles =[manager subpathsAtPath:path];
    CGFloat size;
    for (NSString *fileName in childerFiles) {
        
        NSString *absolutePath =[path stringByAppendingString:fileName];
        //DLog(@"absolutePath======%@",absolutePath);
        size +=[manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
    }
    return size/1024.0/1024.0;
}

//+ (void)getUserInfo{
//    NSString *urlstr =[NSString stringWithFormat:@"%@app_user.php?app=user_info&userid=%@",BaseURL,[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"]];
//    DLog(@"urlstr==%@",urlstr);
//    [AFNetRequest HttpGetCallBack:urlstr Parameters:nil success:^(id responseObject) {
//        DLog(@"responseObject==%@",responseObject);
//        for (NSDictionary *dic in responseObject[@"data"]) {
//        }
//     } failure:^(NSError *error) {
//        
//    } isShowHUD:YES];
//}


+ (NSDate *)getNowDateWithDate:(NSDate *)date{
    // 获取当前系统的准确事件(+8小时)
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    
    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    
    return dateNow;
}


+ (NSInteger)getDifferenceByDate:(NSString *)date {
    //获得当前时间
    NSDate *now = [NSDate date];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *oldDate = [dateFormatter dateFromString:date];
    DLog(@"oldDate==%@",oldDate);
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:oldDate  toDate:now  options:0];
    return [comps day];
}


/**
 根据 PHAsset 来获取 媒体文件(视频或图片)相关信息：文件名、文件上传类型（data 或 path）
 
 @param asset  PHAsset对象
 @param completion 成功回调
 */
+ (void)getMediaInfoFromAsset: (PHAsset *)asset completion: (void(^)(NSString *name, id pathData))completion {
    if (!asset) {
        return;
    }
    NSString *mediaName;
    
     if (asset.mediaType == PHAssetMediaTypeVideo ||
             asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) {
        //视频文件名
        mediaName = [self getMediaNameWithPHAsset:asset extensionName:@"IMG.MOV"];
        
        NSString *videoPath = [NSTemporaryDirectory() stringByAppendingString:mediaName];
        BOOL success = [[NSFileManager defaultManager] fileExistsAtPath:videoPath];
        //当前处理方式：本地的视频 直接返回路径，非本地的也不存储到本地，直接返回data
        if (success) {
            !completion ?  : completion(mediaName, videoPath);
        }else{
            NSData *videoData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:videoPath]];
            !completion ?  : completion(mediaName, videoData);
        }
    }
}
#pragma mark - privary

/**
 获取媒体文件名称
 
 @param asset     PHAsset对象
 @param extension 媒体文件的拓展名（.PNG等）
 @return asset为nil时，返回默认自定义时间(按时间命名)，不为nil则返回原图名称
 */
+ (NSString *)getMediaNameWithPHAsset: (PHAsset *)asset extensionName: (NSString *)extension {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *mediaName;
    //空的情况，返回自定义名称（按时间命名）
    if (!asset) {
        mediaName = [formatter stringFromDate:date];
        return [NSString stringWithFormat:@"%@%@",mediaName,extension];
    }
    PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
    //获取本地原图的名称
    if (resource.originalFilename) {
        mediaName = resource.originalFilename;
    }else {
        mediaName = [NSString stringWithFormat:@"%@%@",[formatter stringFromDate:date],extension];
    }
    return mediaName;
}
+ (void)judgeSystemVersionWithTableView:(UITableView *)tableView{
    if(@available(iOS 11.0, *)){
        tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
}

+ (UIImage *)changeImage:(UIImage *)image WithSize:(CGSize )size{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);//*1
    CGRect imageRect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:imageRect];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();//*2
    UIGraphicsEndImageContext();//*3
    return result;

}

@end
