//
//  PollutionSourceCell.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/9.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "PollutionSourceCell.h"

@implementation PollutionSourceCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        WS(blockSelf);
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        _infoLab =[UILabel new];
        [self.contentView addSubview:_infoLab];
        [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(blockSelf.contentView).offset =10;
            make.bottom.equalTo(blockSelf.contentView).offset =-5;
        }];
        _infoLab.font =FontSize(14);
        _infoLab.backgroundColor =[UIColor redColor];
        _infoLab.textColor =[UIColor whiteColor];
        
        _titleLab =[UILabel new];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =5;
            make.left.equalTo(blockSelf.contentView).offset =10;
            make.bottom.equalTo(blockSelf.infoLab.mas_top).offset =-5;
            make.right.equalTo(blockSelf.contentView).offset =-10;
        }];
        _titleLab.font =FontSize(15);
        _titleLab.numberOfLines =2;
        _titleLab.adjustsFontSizeToFitWidth =YES;
        
        
   

        
    }
    return self;
}

@end
