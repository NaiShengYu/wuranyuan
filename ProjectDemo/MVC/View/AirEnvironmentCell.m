//
//  AirEnvironmentCell.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/8.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "AirEnvironmentCell.h"

@implementation AirEnvironmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        WS(blockSelf);
//        self.selectionStyle =UITableViewCellSelectionStyleNone;
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        _numLab =[UILabel new];
        [self.contentView addSubview:_numLab];
        [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =5;
            make.left.equalTo(blockSelf.contentView).offset =10;
            make.bottom.equalTo(blockSelf.contentView).offset =-5;
            make.width.mas_lessThanOrEqualTo(screenWigth-110);
        }];
        _numLab.font =FontSize(screenWigth==320?13:15);
        _numLab.numberOfLines =2;
        _numLab.adjustsFontSizeToFitWidth =YES;
        
        _titleLab =[UILabel new];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =5;
            make.left.equalTo(blockSelf.numLab.mas_right).offset =15;
            make.bottom.equalTo(blockSelf.contentView).offset =-5;
            make.width.mas_lessThanOrEqualTo(screenWigth-110);
        }];
        _titleLab.font =FontSize(screenWigth==320?13:15);
        _titleLab.numberOfLines =2;
        _titleLab.adjustsFontSizeToFitWidth =YES;
//        _titleLab.backgroundColor =[UIColor redColor];
        
        
        _PMLab =[UILabel new];
        [self.contentView addSubview:_PMLab];
        [_PMLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =5;
            make.right.equalTo(blockSelf.contentView).offset =0;
            make.bottom.equalTo(blockSelf.contentView).offset =-5;
            make.width.offset =70;
        }];
//        _PMLab.backgroundColor =[UIColor orangeColor];
        _PMLab.font =FontSize(screenWigth==320?12:14);
        _PMLab.textAlignment =NSTextAlignmentRight;
        
        _backLab =[UILabel new];
        [self.contentView addSubview:_backLab];
        [_backLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(blockSelf.contentView).offset =10;
            make.right.equalTo(blockSelf.contentView).offset =-80;
            make.bottom.equalTo(blockSelf.contentView).offset =-10;
                        make.width.offset =55;
        }];
        //        _PMLab.backgroundColor =[UIColor orangeColor];
        _backLab.font =FontSize(screenWigth==320?12:14);
        _backLab.textAlignment =NSTextAlignmentCenter;
        _backLab.backgroundColor =zhuse;
        _backLab.text =@"PM2.5";
        _backLab.textColor =[UIColor whiteColor];
        _backLab.hidden =YES;
  
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    // 获取 contentView 所有子控件
    NSArray<__kindof UIView *> *subViews = self.contentView.subviews;
    // 创建颜色数组
    NSMutableArray *colors = [NSMutableArray array];
    
    for (UIView *view in subViews) {
        // 获取所有子控件颜色
        [colors addObject:view.backgroundColor ?: [UIColor clearColor]];
    }
    // 调用super
    [super setSelected:selected animated:animated];
    // 修改控件颜色
    for (int i = 0; i < subViews.count; i++) {
        subViews[i].backgroundColor = colors[i];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    // 获取 contentView 所有子控件
    NSArray<__kindof UIView *> *subViews = self.contentView.subviews;
    // 创建颜色数组
    NSMutableArray *colors = [NSMutableArray array];
    
    for (UIView *view in subViews) {
        // 获取所有子控件颜色
        [colors addObject:view.backgroundColor ?: [UIColor clearColor]];
    }
    // 调用super
    [super setHighlighted:highlighted animated:animated];
    // 修改控件颜色
    for (int i = 0; i < subViews.count; i++) {
        subViews[i].backgroundColor = colors[i];
    }
}
@end
