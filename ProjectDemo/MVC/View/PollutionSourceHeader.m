//
//  PollutionSourceHeader.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/9.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "PollutionSourceHeader.h"

@implementation PollutionSourceHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        WS(blockSelf);
        _titleLab =[UILabel new];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =10;
            make.left.equalTo(blockSelf.contentView).offset =10;
            make.width.lessThanOrEqualTo(@(screenWigth-20));
        }];
        _titleLab.font =FontSize(15);
        _titleLab.numberOfLines =2;
        _titleLab.adjustsFontSizeToFitWidth =YES;
        _titleLab.backgroundColor =[UIColor redColor];
        
        _infoLab =[UILabel new];
        [self.contentView addSubview:_infoLab];
        [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.titleLab.mas_bottom).offset =10;
            make.right.equalTo(blockSelf.contentView).offset =-90;
            make.bottom.equalTo(blockSelf.contentView).offset =-15;
            make.left.equalTo(blockSelf.titleLab).offset =0;
        }];
        _infoLab.font =FontSize(14);
        _infoLab.numberOfLines =0;
        
        _but =[UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.contentView addSubview:_but];
        [_but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(blockSelf.contentView).offset =-10;
            make.width.offset =80;
            make.centerY.equalTo(blockSelf.infoLab.mas_centerY).offset =0;
        }];
        [_but setTitle:@"360监控" forState:(UIControlStateNormal)];
        
        [_but setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _but.layer.cornerRadius =5;
        _but.backgroundColor =zhuse;
       
    }
    return self;
}


@end
