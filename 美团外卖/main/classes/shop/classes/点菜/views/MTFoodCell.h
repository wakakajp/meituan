//
//  MTFoodCell.h
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/7.
//  Copyright © 2016年 jp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTFoodModel,MTFoodCell;

@protocol MTFoodCellDelegate<NSObject>

@optional
- (void)didFinishIncrease:(MTFoodCell *)foodCell foodModel:(MTFoodModel *)food starPoint:(CGPoint)starP;

- (void)didFinishDecrease:(MTFoodCell *)foolcell foodModel:(MTFoodModel *)food;

@end

@interface MTFoodCell : UITableViewCell

@property (strong,nonatomic) MTFoodModel *food;

@property (weak,nonatomic) id<MTFoodCellDelegate> delegate;

@end
