//
//  MTFoodModel.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/7.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTFoodModel.h"

@implementation MTFoodModel

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"description"]) {
        [super setValue:value forKey:@"desc"];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}
@end
