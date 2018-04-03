//
//  SupervisionAndInspectionInfoCell.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "SupervisionAndInspectionInfoCell.h"

@implementation SupervisionAndInspectionInfoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        CGFloat W =(screenWigth-40)/4;
        WS(blockSelf);

        _nameLab =[UILabel new];
        [self.contentView addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset =10;
            make.top.bottom.offset =0;
            make.width.offset =W*1.5;
        }];
        _nameLab.font =FontSize(15);
        _nameLab.textAlignment =NSTextAlignmentCenter;
        _nameLab.adjustsFontSizeToFitWidth =YES;
        
        _numLab =[UILabel new];
        [self.contentView addSubview:_numLab];
        [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(blockSelf.nameLab.mas_right).offset =10;
            make.top.bottom.offset =0;
            make.width.offset =W*1.5;
        }];
        _numLab.font =FontSize(15);
        _numLab.textAlignment =NSTextAlignmentCenter;
        _numLab.adjustsFontSizeToFitWidth =YES;
        
        _typeLab =[UILabel new];
        [self.contentView addSubview:_typeLab];
        [_typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset =-10;
            make.top.bottom.offset =0;
            make.width.offset =W*1;
        }];
        _typeLab.font =FontSize(15);
        _typeLab.textAlignment =NSTextAlignmentCenter;
        _typeLab.adjustsFontSizeToFitWidth =YES;
    }
    
    
    
    return self;
    
}
- (void)setDic:(NSDictionary *)dic{
    _dic =dic;
    
    _nameLab.text =[NSString stringWithFormat:@"%@",dic[@"INAME"]];
    _numLab.text =[NSString stringWithFormat:@"%@(%@)",dic[@"VALUE"],dic[@"UNIT"]];
    _typeLab.text =[NSString stringWithFormat:@"%@",dic[@"TNAME"]];

}
@end
