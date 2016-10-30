//
//  MTDetailViewController.h
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/10.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTBaseViewController.h"

@class MTFoodModel;
@interface MTDetailViewController : MTBaseViewController

@property (strong,nonatomic) MTFoodModel *food;

@property (strong,nonatomic) NSIndexPath *indexPath;

@end
