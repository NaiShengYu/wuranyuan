//
//  MonitorCell.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/3/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "MonitorCell.h"

@implementation MonitorCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.backgroundColor =[UIColor clearColor];
        CGFloat W =25;
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        _stateLab =[UILabel new];
        [self.contentView addSubview:_stateLab];
        [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset =10;
            make.right.offset =-10;
            make.size.mas_equalTo(CGSizeMake(W, W));
        }];
        _stateLab.layer.cornerRadius =W/2.0;
        _stateLab.layer.masksToBounds =YES;
        _stateLab.backgroundColor =[UIColor redColor];
        _stateLab.textColor =[UIColor whiteColor];
//        _stateLab.hidden =YES;
        _stateLab.textAlignment =NSTextAlignmentCenter;
//        [self.contentView bringSubviewToFront:_stateLab];
//        [_stateLab bringSubviewToFront:self.contentView];
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
