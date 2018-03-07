//
//  AirEnvironmentHeader.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/8.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "AirEnvironmentHeader.h"

@implementation AirEnvironmentHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        WS(blockSelf);
        _titleLab =[UILabel new];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =15;
            make.left.equalTo(blockSelf.contentView).offset =10;
            make.width.offset =40;
            make.height.offset =25;
        }];
        _titleLab.font =FontSize(15);
        _titleLab.numberOfLines =2;
        _titleLab.adjustsFontSizeToFitWidth =YES;
        _titleLab.backgroundColor =[UIColor orangeColor];
        _titleLab.textAlignment =NSTextAlignmentCenter;
        
        _PMLab =[UILabel new];
        [self.contentView addSubview:_PMLab];
        [_PMLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =15;
            make.right.equalTo(blockSelf.contentView).offset =-15;
            make.bottom.equalTo(blockSelf.contentView).offset =-15;
            make.left.equalTo(blockSelf.titleLab.mas_right).offset =10;
        
        }];
        _PMLab.font =FontSize(14);
        _PMLab.numberOfLines =0;
//        _PMLab.backgroundColor =[UIColor orangeColor];

        
    }
    return self;
}

@end
