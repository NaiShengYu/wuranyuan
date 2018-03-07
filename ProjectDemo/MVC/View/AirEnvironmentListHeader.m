//
//  AirEnvironmentListHeader.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/2/12.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "AirEnvironmentListHeader.h"

@implementation AirEnvironmentListHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        WS(blockSelf);
        UIView *lineView =[UIView new];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =0;
            make.left.equalTo(blockSelf.contentView).offset =0;
            make.right.equalTo(blockSelf.contentView).offset =0;
            make.height.offset =0.8;
        }];
        lineView.backgroundColor =[UIColor groupTableViewBackgroundColor];
        
        
        
        blockSelf.contentView.backgroundColor =[UIColor whiteColor];
        _numLab =[UILabel new];
        [self.contentView addSubview:_numLab];
        [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =0;
            make.left.equalTo(blockSelf.contentView).offset =10;
            make.bottom.equalTo(blockSelf.contentView).offset =0;

        }];
        _numLab.text =@"排名";
        _numLab.textAlignment =NSTextAlignmentCenter;
        _numLab.font =FontSize(screenWigth==320?15:17);
        
        _addressNameLab =[UILabel new];
        [self.contentView addSubview:_addressNameLab];
        [_addressNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =0;
            make.left.equalTo(blockSelf.numLab.mas_right).offset =10;
            make.bottom.equalTo(blockSelf.contentView).offset =0;
            make.width.offset =screenWigth==320?60:80;
        }];
        _addressNameLab.text =@"站点";
        _addressNameLab.textAlignment =NSTextAlignmentCenter;
        _addressNameLab.font =FontSize(screenWigth==320?15:17);
        
        _AQINumLab =[UILabel new];
        [self.contentView addSubview:_AQINumLab];
        [_AQINumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =0;
            make.right.equalTo(blockSelf.contentView).offset =0;
            make.bottom.equalTo(blockSelf.contentView).offset =0;
            
            make.width.offset =screenWigth==320?100:120;
        }];
        _AQINumLab.text =@"AQI(ug/m3)";
        _AQINumLab.textAlignment =NSTextAlignmentCenter;
        _AQINumLab.font =FontSize(screenWigth==320?15:17);
        
        _contaminantNameLab =[UILabel new];
        [self.contentView addSubview:_contaminantNameLab];
        [_contaminantNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =0;
            make.right.equalTo(blockSelf.AQINumLab.mas_left).offset =screenWigth==320?0:-15;
            make.bottom.equalTo(blockSelf.contentView).offset =0;
        }];
        _contaminantNameLab.text =@"主要污染物";
        _contaminantNameLab.textAlignment =NSTextAlignmentCenter;
        _contaminantNameLab.font =FontSize(screenWigth==320?15:17);
        
        
    }
    
    return self;
    
}
@end
