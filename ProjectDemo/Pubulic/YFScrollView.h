//
//  YFScrollView.h
//  滑动
//
//  Created by 俞乃胜 on 16/6/27.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFScrollView : UIView
/**
 *  网络图片
 */
@property(nonatomic,strong)NSArray *urlsArray;

@property(nonatomic,strong)NSArray *dataArray;
/**
 *  相册图片
 */
@property(nonatomic,strong)NSArray *ImagesArry;

/**
 *  选中的是第几个
 */
@property (nonatomic,assign)NSInteger selectNum;

@end
