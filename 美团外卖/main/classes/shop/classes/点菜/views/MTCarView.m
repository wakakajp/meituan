//
//  MTCarView.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/9.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTCarView.h"
#import "MTFoodModel.h"
@interface MTCarView ()

@property (weak, nonatomic) IBOutlet UIButton *numberBtn;

@property (weak, nonatomic) IBOutlet UIButton *shoppingCarBtn;

@property (weak, nonatomic) IBOutlet UIButton *checkaccountBtn;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@end

@implementation MTCarView

- (void)awakeFromNib {
    self.shoppingList = nil;
    _numBtnCenter = _numberBtn.center;
}

+ (instancetype)carView {
    return [[NSBundle mainBundle] loadNibNamed:@"MTCarView" owner:nil options:nil].firstObject;
}

- (IBAction)showShoppingCarList:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(bottomCarView:needsDisplaySelectFoods:)]) {
        [_delegate bottomCarView:self needsDisplaySelectFoods:_shoppingList];
    }
}
- (IBAction)checkAccount:(UIButton *)sender {
    NSLog(@"结账");
}

- (void)setShoppingList:(NSMutableArray<MTFoodModel *> *)shoppingList {
    _shoppingList = shoppingList;
    
    __block NSInteger count = 0;
    __block float money = 0;
    
    [shoppingList enumerateObjectsUsingBlock:^(MTFoodModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        count += obj.foodCount;
        money += (obj.foodCount * obj.min_price.floatValue);
    }];
    
    if (count > 0) {
        [_numberBtn setTitle:@(count).description forState:UIControlStateNormal];
        
        _numberBtn.hidden = NO;
        _shoppingCarBtn.selected = YES;
    }else {
        _numberBtn.hidden = YES;
        _shoppingCarBtn.selected = NO;
    }
    
    if (money > 0) {
        _priceLbl.text = [@"¥ " stringByAppendingFormat:@"%.2f", money];
        _priceLbl.textColor = [UIColor redColor];
        
    } else {
        
        _priceLbl.text = @"购物车空空如也~";
        _priceLbl.textColor = [UIColor cz_colorWithHex:0x808080];
    }
    
    if (money > 20) {
        [_checkaccountBtn setTitle:@"结账" forState:UIControlStateNormal];
        [_checkaccountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _checkaccountBtn.backgroundColor = [UIColor yellowColor];
        
    } else {
        
        float shortMoney = 20 - money;
        NSString *shortTitle = [@"还差 " stringByAppendingFormat:@"%.2f", shortMoney];
        [_checkaccountBtn setTitle:shortTitle forState:UIControlStateNormal];
        [_checkaccountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _checkaccountBtn.backgroundColor = [UIColor cz_colorWithHex:0xCCCCCC];
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
