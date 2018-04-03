//
//  EmissionPermitManagementCell.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "EmissionPermitManagementCell.h"

@implementation EmissionPermitManagementCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
        WS(blockSelf);
      
        
        _lab2 =[[UILabel alloc]init];
        [self.contentView addSubview:_lab2];
        [_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset =10;
            make.right.offset =0;
        }];
        _lab2.font =FontSize(15);
        _lab2.textAlignment =NSTextAlignmentRight;
        
        _lab1 =[[UILabel alloc]init];
        [self.contentView addSubview:_lab1];
        [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset =10;
            make.right.equalTo(blockSelf.lab2.mas_left).offset =-8;
        }];
        _lab1.font =FontSize(15);
        _lab1.adjustsFontSizeToFitWidth =YES;
        
        _lab3 =[[UILabel alloc]init];
        [self.contentView addSubview:_lab3];
        [_lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset =10;
            make.bottom.offset =-10;

        }];
        _lab3.font =FontSize(15);
        
        _lab4 =[[UILabel alloc]init];
        [self.contentView addSubview:_lab4];
        [_lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset =-10;
            make.right.offset =0;
        }];
        _lab4.font =FontSize(15);
        
    }
    
    
    return self;
    
    
    
}

- (void)setModel:(EmissionPermitManagementModel *)model{
    _model =model;
    _lab1.text =[NSString stringWithFormat:@"许可证编号:%@",model.LICENCEID];
    _lab2.text =[NSString stringWithFormat:@"许可证类型:%@",model.KIND];
    _lab3.text =[NSString stringWithFormat:@"发证时间:%@",model.ISSUEDATE];
    _lab4.text =[NSString stringWithFormat:@"有效期:%@",model.VALIDITY];

    
    
    
}

@end
