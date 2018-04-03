

//
//  SupervisionAndInspectionInfoHeader.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "SupervisionAndInspectionInfoHeader.h"

@implementation SupervisionAndInspectionInfoHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat W =(screenWigth-40)/4;
        WS(blockSelf);
        
        _nameLab =[UILabel new];
        [self.contentView addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset =10;
            make.top.bottom.offset =0;
            make.width.offset =W*1.5;
        }];
        _nameLab.textAlignment =NSTextAlignmentCenter;
        _nameLab.adjustsFontSizeToFitWidth =YES;
        _nameLab.text =@"名称";
        
        _numLab =[UILabel new];
        [self.contentView addSubview:_numLab];
        [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(blockSelf.nameLab.mas_right).offset =10;
            make.top.bottom.offset =0;
            make.width.offset =W*1.5;
        }];
        _numLab.textAlignment =NSTextAlignmentCenter;
        _numLab.adjustsFontSizeToFitWidth =YES;
        _numLab.text =@"数值(单位)";

        _typeLab =[UILabel new];
        [self.contentView addSubview:_typeLab];
        [_typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset =-10;
            make.top.bottom.offset =0;
            make.width.offset =W*1;
        }];
        _typeLab.textAlignment =NSTextAlignmentCenter;
        _typeLab.adjustsFontSizeToFitWidth =YES;
        _typeLab.text =@"类型";

    }
    return self;

}

@end
