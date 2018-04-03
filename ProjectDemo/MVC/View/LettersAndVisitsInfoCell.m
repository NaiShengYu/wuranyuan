//
//  LettersAndVisitsInfoCell.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/4/2.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "LettersAndVisitsInfoCell.h"

@implementation LettersAndVisitsInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        WS(blockSelf);
        self.selectionStyle =UITableViewCellSelectionStyleNone;
        _leftTitleLab =[UILabel new];
        [self.contentView addSubview:_leftTitleLab];
        [_leftTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset =0;
            make.left.offset =10;
        }];
        _leftTitleLab.textColor =zhuse;
        _leftTitleLab.font =FontSize(15);
        
        _leftLab =[UILabel new];
        [self.contentView addSubview:_leftLab];
        [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset =0;
            make.left.equalTo(blockSelf.leftTitleLab.mas_right).offset =10;
            make.right.offset =-10;
            make.top.offset =5;
            make.bottom.offset =-5;
            
        }];
        _leftLab.font =FontSize(15);
        _leftLab.adjustsFontSizeToFitWidth =YES;
        _leftLab.numberOfLines =0;
        
        
    }
    return self;

    
}

@end
