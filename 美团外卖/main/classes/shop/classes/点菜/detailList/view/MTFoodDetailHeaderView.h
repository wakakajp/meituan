//
//  MTFoodDetailHeaderView.h
//  MT_waimai[007]
//
//  Created by HM on 16/8/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "MTBaseView.h"

@class MTFoodModel;
@interface MTFoodDetailHeaderView : MTBaseView

+ (instancetype)foodDetailHeaderView;

/**
 *  要显示详情的菜品模型!
 */
@property (strong, nonatomic) MTFoodModel *foodM;

@end
