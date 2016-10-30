//
//  MTFoodHeaderView.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/8.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTFoodHeaderView.h"
@interface MTFoodHeaderView ()

@property (weak,nonatomic) UILabel *titleLabel;

@end

@implementation MTFoodHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    _titleLabel.text = title;    
}
- (void)setupUI {
    self.contentView.backgroundColor = [UIColor cz_colorWithHex:0xf8f8f8];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor cz_colorWithHex:0x404040];
    titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    _titleLabel = titleLabel;
}
@end
