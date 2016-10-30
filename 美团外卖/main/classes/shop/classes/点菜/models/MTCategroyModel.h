//
//  MTCategroyModel.h
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/7.
//  Copyright © 2016年 jp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTFoodModel;

@interface MTCategroyModel : NSObject

@property (copy,nonatomic) NSString *name;

@property (strong,nonatomic) NSArray<MTFoodModel *> *spus;

@end
