//
//  MTCategoryView.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/5.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTCategoryView.h"
#import "CZAdditions.h"
@interface MTCategoryView ()

@property (weak,nonatomic) UIView *lineView;

@property (weak,nonatomic) UIButton *firstBtn;

@property (weak,nonatomic) UIButton *selectedBtn;

@end

@implementation MTCategoryView {
    NSArray<UIButton *> *_btnArr;
}
#pragma mark - 按钮点击事件
- (void)clickedBtn: (UIButton *)sender {
    //该方法可以获取数组中某一元素的索引
    _pageNum = [_btnArr indexOfObject:sender];
    
    _firstBtn.selected = NO;
    _selectedBtn.selected = NO;
    sender.selected = YES;
    _selectedBtn = sender;
    
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_firstBtn).offset(_pageNum * _firstBtn.bounds.size.width);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
#pragma mark - 重写set方法
- (void)setOffsetX:(CGFloat)offsetX {
    _offsetX = offsetX;
    
    //计算lineView的centerX的位置
    CGFloat selfOffsetX = _offsetX / self.bounds.size.width * _firstBtn.bounds.size.width;
    
    [_lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_firstBtn).offset(selfOffsetX);
    }];
    
    [self layoutIfNeeded];
    
    //计算当前页
    NSInteger currentPageNum = _offsetX / self.bounds.size.width + 0.5;
    
    [_btnArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
        if (idx == currentPageNum) {
            obj.selected = YES;
        }
    }];
}

#pragma mark - 设置界面
- (void)setupUI {
    //创建三个按钮
    NSArray<NSString *> *categoryNameArr = @[@"点菜",@"评价",@"商家"];
    
    [categoryNameArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton cz_textButton:obj fontSize:14 normalColor:[UIColor cz_colorWithHex:0x555555] selectedColor:[UIColor cz_colorWithHex:0x000000]];
        
        [btn addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        if (idx == 0) {
            _firstBtn = btn;
            _firstBtn.selected = YES;
        }
        
    }];
    _btnArr = self.subviews;
    [self.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [self.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
    }];
    
    //创建黄色条线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor cz_colorWithHex:0xffd900];
    
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(2);
        make.bottom.equalTo(_firstBtn);
        make.width.equalTo(_firstBtn);
        make.centerX.equalTo(_firstBtn);
    }];
    
    _lineView = lineView;
}

@end
