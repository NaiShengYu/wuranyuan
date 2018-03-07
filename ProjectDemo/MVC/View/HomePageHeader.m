



//
//  HomePageHeader.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/8.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "HomePageHeader.h"

@implementation HomePageHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        _titleLab =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, screenWigth-40, 30)];
        _titleLab.font =FontSize(16);
        _titleLab.adjustsFontSizeToFitWidth =YES;
        [self addSubview:_titleLab];
    }
    return self;
  
}
@end
