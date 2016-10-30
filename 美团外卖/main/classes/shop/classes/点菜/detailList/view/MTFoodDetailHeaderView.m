//
//  MTFoodDetailHeaderView.m
//  MT_waimai[007]
//
//  Created by HM on 16/8/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "MTFoodDetailHeaderView.h"
#import "MTFoodModel.h"


@interface MTFoodDetailHeaderView ()

/**
 *  名称
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
/**
 *  月售
 */
@property (weak, nonatomic) IBOutlet UILabel *monthLbl;

/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
/**
 *  简介
 */
@property (weak, nonatomic) IBOutlet UILabel *commentLbl;


@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end


@implementation MTFoodDetailHeaderView

#pragma mark - 创建视图的类方法
+ (instancetype)foodDetailHeaderView {

    return [[NSBundle mainBundle] loadNibNamed:@"MTFoodDetailHeaderView" owner:nil options:nil].lastObject;

}

- (void)awakeFromNib {

    self.foodM = nil;
    
    _addBtn.layer.cornerRadius = 4;
    _addBtn.layer.masksToBounds = YES;
}

#pragma mark - 添加到购物车按钮的事件
- (IBAction)addToCarViewBtnClick:(UIButton *)sender {
    
    _foodM.foodCount++;
    
    CGPoint point = [self convertPoint:sender.center toView:[UIApplication sharedApplication].keyWindow];
    NSDictionary *dict = @{
                           MTAddFoodKey : _foodM,
                           MTStartPointKey : [NSValue valueWithCGPoint:point]
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:MTAddFoodToCarViewNotification object:_foodM userInfo:dict];

}


#pragma mark - 设置数据
- (void)setFoodM:(MTFoodModel *)foodM {

    _foodM = foodM;
    // 分发数据
    _nameLbl.text = foodM.name;
    _monthLbl.text = foodM.month_saled_content;
    _priceLbl.text = [@"¥ " stringByAppendingFormat:@"%.2f", foodM.min_price.floatValue];
    
    _commentLbl.text = [@"好吃不贵 " stringByAppendingFormat:@"%@", _priceLbl.text];
}


















@end
