//
//  DailyManagementCell.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "DailyManagementCell.h"

@implementation DailyManagementCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
        WS(blockSelf);
        
        _lab1 =[[UILabel alloc]init];
        [self.contentView addSubview:_lab1];
        [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset =10;
            make.right.offset =0;
        }];
        _lab1.font =FontSize(15);
        _lab1.adjustsFontSizeToFitWidth =YES;
        
        _lab2 =[[UILabel alloc]init];
        [self.contentView addSubview:_lab2];
        [_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset =10;
            make.top.equalTo(blockSelf.lab1.mas_bottom).offset =5;
            make.right.offset = 0;
        }];
        _lab2.font =FontSize(15);
    
        
        _lab3 =[[UILabel alloc]init];
        [self.contentView addSubview:_lab3];
        [_lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset =10;
            make.top.equalTo(blockSelf.lab2.mas_bottom).offset =5;
            make.right.offset = 0;
        }];
        _lab3.font =FontSize(15);
        
        _lab4 =[[UILabel alloc]init];
        [self.contentView addSubview:_lab4];
        [_lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset =10;
            make.top.equalTo(blockSelf.lab3.mas_bottom).offset =5;
            make.right.offset = 0;
        }];
        _lab4.font =FontSize(15);
        
    }
    
    
    return self;
    
    
    
}

- (void)setModel:(DailyManagementModel *)model{
    _model =model;
    _lab1.text =[NSString stringWithFormat:@"执法时间:%@",[model.SUPERVISEDATE substringToIndex:10]];
    _lab2.text =[NSString stringWithFormat:@"执法人员:%@",model.SUPERVISOR];
    _lab3.text =[NSString stringWithFormat:@"执法内容:%@",model.CONTEXT];
    _lab4.text =[NSString stringWithFormat:@"执法要求:%@",model.IMPROVECONTEXT];




}
@end
