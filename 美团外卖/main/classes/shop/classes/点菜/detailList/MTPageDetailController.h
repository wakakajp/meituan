//
//  MTPageDetailController.h
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/10.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTBaseViewController.h"

@class MTCategroyModel,MTFoodModel,MTCarView;

@interface MTPageDetailController : MTBaseViewController

@property (strong,nonatomic) NSArray<MTCategroyModel *> *categroyList;

@property (strong,nonatomic) NSIndexPath *indexPath;

@property (assign,nonatomic) CGFloat oldAlpha;

@property (weak,nonatomic) MTCarView *carV;

@property (strong,nonatomic) NSMutableArray<MTFoodModel *> *shoppingList;

@end
