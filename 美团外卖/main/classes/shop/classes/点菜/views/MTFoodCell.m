//
//  MTFoodCell.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/7.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTFoodCell.h"
#import "MTFoodModel.h"
#import "UIImageView+WebCache.h"
#import "MTCountOrder.h"

@interface MTFoodCell ()

@property (weak, nonatomic) UIImageView *iconView;

@property (weak, nonatomic) UILabel *nameLbl;

@property (weak, nonatomic) UILabel *monthLbl;

@property (weak, nonatomic) UILabel *starLbl;

@property (weak, nonatomic) UILabel *priceLbl;

@property (weak, nonatomic) UILabel *descLbl;

@property (weak,nonatomic) MTCountOrder *countOrder;

@end

@implementation MTFoodCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)foodCountChanged:(MTCountOrder *)sender {
    
    _food.foodCount = sender.foodCount;
    
    if ([_delegate respondsToSelector:@selector(didFinishIncrease:foodModel:starPoint:)] && sender.isIncrease) {
        [_delegate didFinishIncrease:self foodModel:_food starPoint:sender.starP];
    }
    
    if ([_delegate respondsToSelector:@selector(didFinishDecrease:foodModel:)] && sender.isIncrease == NO) {
        [_delegate didFinishDecrease:self foodModel:_food];
    }
    
}

- (void)setFood:(MTFoodModel *)food {
    _food = food;
    
    NSString *urlStr = [food.picture stringByDeletingPathExtension];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [_iconView sd_setImageWithURL:url];
    _nameLbl.text = food.name;
    _monthLbl.text = food.month_saled_content;
    _starLbl.text = food.praise_num.description;
    _priceLbl.text = [NSString stringWithFormat:@"¥ %@",_food.min_price];
    _descLbl.text = food.desc;
    _countOrder.foodCount = food.foodCount;
}

- (void)setupUI {
    
    UIImageView *iconV = [[UIImageView alloc] init];
    iconV.backgroundColor = [UIColor redColor];
    iconV.layer.cornerRadius = 10;
    iconV.layer.masksToBounds = YES;
    iconV.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:iconV];
    
    UILabel *nameLbl = [[UILabel alloc] init];
    nameLbl.textColor = [UIColor cz_colorWithHex:0x000000];
    nameLbl.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:nameLbl];
    
    UILabel *monthLbl = [[UILabel alloc] init];
    monthLbl.textColor = [UIColor cz_colorWithHex:0x7e7e7e];
    monthLbl.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:monthLbl];
    
    UILabel *starLbl = [[UILabel alloc] init];
    starLbl.textColor = [UIColor cz_colorWithHex:0x7e7e7e];
    starLbl.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:starLbl];
    
    UIImageView *praiseImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_food_review_praise"]];
    [praiseImage sizeToFit];
    [self.contentView addSubview:praiseImage];
    
    UILabel *priceLbl = [[UILabel alloc] init];
    priceLbl.font = [UIFont systemFontOfSize:14];
    priceLbl.textColor = [UIColor cz_colorWithHex:0xfa2a09];
    [self.contentView addSubview:priceLbl];
    
    UILabel *descLbl = [[UILabel alloc] init];
    descLbl.textColor = [UIColor cz_colorWithHex:0x848484];
    descLbl.font = [UIFont systemFontOfSize:11];
    descLbl.numberOfLines = 0;
    [self.contentView addSubview:descLbl];
    
    MTCountOrder *countOrder = [[[NSBundle mainBundle] loadNibNamed:@"MTCountOrder" owner:nil options:nil] firstObject];
    _countOrder = countOrder;
    
    [self.contentView addSubview:countOrder];
    [countOrder addTarget:self action:@selector(foodCountChanged:) forControlEvents:UIControlEventValueChanged];
    
    _iconView = iconV;
    _monthLbl = monthLbl;
    _nameLbl = nameLbl;
    _starLbl = starLbl;
    _priceLbl = priceLbl;
    _descLbl = descLbl;
    
    CGFloat margin = 10;
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(9);
        make.top.equalTo(self.contentView).offset(10);
        make.height.width.mas_equalTo(50);
    }];
    
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(margin);
        make.top.equalTo(_iconView);
    }];
    
    [_monthLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLbl);
        make.top.equalTo(_nameLbl.mas_bottom).offset(margin);
    }];
    
    [praiseImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_monthLbl.mas_right).offset(margin);
        make.top.equalTo(_monthLbl);
    }];
    
    [_starLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(praiseImage.mas_right).offset(margin);
        make.top.equalTo(praiseImage);
    }];
    
    [_priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_monthLbl.mas_bottom).offset(margin);
        make.left.equalTo(_monthLbl);
    }];
    
    [_descLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView);
        make.right.equalTo(self.contentView).offset(- margin);
        make.top.equalTo(_iconView.mas_bottom).offset(16);
    }];
    
    [countOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_priceLbl.mas_top);
        make.right.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(93, 27));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self);
        make.bottom.equalTo(_descLbl).offset(margin);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
