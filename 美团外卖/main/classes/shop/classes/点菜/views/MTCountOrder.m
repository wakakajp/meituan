//
//  MTCountOrder.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/8.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTCountOrder.h"
@interface MTCountOrder ()

@property (weak, nonatomic) IBOutlet UIButton *decreaseButton;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation MTCountOrder

- (void)awakeFromNib {
    
    self.foodCount = 0;
}

- (void)setFoodCount:(NSInteger)foodCount {
    _foodCount = foodCount;
    
    if (foodCount > 0) {
        _decreaseButton.hidden = NO;
        _countLabel.hidden = NO;
    }else {
        _decreaseButton.hidden = YES;
        _countLabel.hidden = YES;
    }
    
    _countLabel.text = @(foodCount).description;
    
    
}

- (IBAction)decreaseFoodCount:(UIButton *)sender {
    
    self.foodCount--;
    self.isIncrease = NO;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (IBAction)increaseFoodCount:(UIButton *)sender {
    
    self.foodCount++;
    self.isIncrease = YES;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    _starP = [self convertPoint:sender.center toView:window];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
