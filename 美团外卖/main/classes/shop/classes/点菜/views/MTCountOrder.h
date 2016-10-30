//
//  MTCountOrder.h
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/8.
//  Copyright © 2016年 jp. All rights reserved.
//


#import "MTBaseControl.h"

@interface MTCountOrder : MTBaseControl

@property (assign,nonatomic) NSInteger foodCount;

@property (assign,nonatomic) CGPoint starP;

@property (assign,nonatomic) BOOL isIncrease;

@end
