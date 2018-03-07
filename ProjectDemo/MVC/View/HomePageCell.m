//
//  HomePageCell.m
//  ProjectDemo
//
//  Created by Nasheng Yu on 2018/1/30.
//  Copyright © 2018年 俞乃胜, Stephen. All rights reserved.
//

#import "HomePageCell.h"

@implementation HomePageCell

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    
    if (self) {
        WS(blockSelf);
        _imageV =[[UIImageView alloc]init];
        _imageV.contentMode =UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageV];
        self.contentView.backgroundColor =[UIColor orangeColor];
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(blockSelf.contentView).insets =UIEdgeInsetsMake(0, 0, 0, 0);
        }];
        
        
    }
    
    
    return self;
    
  
}
@end
