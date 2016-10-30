//
//  MTCategroyCell.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/7.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTCategroyCell.h"

@implementation MTCategroyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    self.textLabel.numberOfLines = 2;
    self.textLabel.textColor = [UIColor cz_colorWithHex:0x464646];
    self.textLabel.font = [UIFont systemFontOfSize:13];
    self.contentView.backgroundColor = [UIColor cz_colorWithHex:0xf8f8f8];
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    UIView *separatorView = [[UIView alloc] init];
    separatorView.backgroundColor = [UIColor grayColor];
    separatorView.alpha = 0.5;
    [self.contentView addSubview:separatorView];
    
    [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor cz_colorWithHex:0xffd900];
    [self.selectedBackgroundView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self.selectedBackgroundView);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(4);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
