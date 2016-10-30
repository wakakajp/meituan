//
//  MTCarView.h
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/9.
//  Copyright © 2016年 jp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTFoodModel, MTCarView;

@protocol MTCarViewDelegate <NSObject>

@optional
- (void)bottomCarView:(MTCarView *)carView needsDisplaySelectFoods:(NSMutableArray<MTFoodModel *> *)selectFoods;

@end

@interface MTCarView : UIView

+ (instancetype)carView;

@property (strong,nonatomic) NSMutableArray<MTFoodModel *> *shoppingList;

@property (weak,nonatomic) id<MTCarViewDelegate> delegate;

@property (assign,nonatomic) CGPoint numBtnCenter;

@end
