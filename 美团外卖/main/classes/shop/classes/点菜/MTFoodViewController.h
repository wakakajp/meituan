//
//  MTFoodViewController.h
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/5.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTBaseViewController.h"

@class MTPageDetailController,MTFoodViewController;

@protocol MTFoodViewControllerDelegate <NSObject>


@optional
- (void)foodViewController:(MTFoodViewController *)foodVc pushPageDetailController:(MTPageDetailController *)pageDetailVc;

@end

@interface MTFoodViewController : MTBaseViewController

@property (weak,nonatomic) id<MTFoodViewControllerDelegate> delegate;

@end
