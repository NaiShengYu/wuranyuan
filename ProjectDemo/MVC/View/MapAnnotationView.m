//
//  MapAnnotationView.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/9.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "MapAnnotationView.h"

@implementation MapAnnotationView

- (instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        WS(blockSelf);
//        self.backgroundColor =[UIColor orangeColor];
        self.bounds =CGRectMake(0, 0, 38, 38);
//        self.image =[UIImage imageNamed:@""];
        self.canShowCallout =NO;
        
        UIView *backView =[[UIView alloc]init];
        [self addSubview:backView];
        //        backView.backgroundColor =[UIColor orangeColor];
        backView.backgroundColor =zhuse;
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(blockSelf.mas_bottom).offset =-5;
            make.centerX.offset =0;
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        backView.transform =CGAffineTransformMakeRotation(M_PI_4);


        _titleLab =[[UILabel alloc]init];
        _titleLab.textAlignment =NSTextAlignmentCenter;
        _titleLab.backgroundColor =zhuse;
        _titleLab.textColor =[UIColor whiteColor];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset =0;
            make.bottom.equalTo(blockSelf).offset =-5;
            make.size.mas_equalTo(CGSizeMake(50, 30));
        }];
        _titleLab.adjustsFontSizeToFitWidth =YES;
        _titleLab.numberOfLines =2;
        
        
   
 
    }
    
    return self;
}

@end
