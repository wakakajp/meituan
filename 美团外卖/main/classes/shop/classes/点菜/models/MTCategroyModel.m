//
//  MTCategroyModel.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/7.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTCategroyModel.h"
#import "MTFoodModel.h"

@implementation MTCategroyModel

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"spus"]) {
        
        NSMutableArray *foods = [NSMutableArray array];
        [value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            MTFoodModel *food = [[MTFoodModel alloc] init];
            [food setValuesForKeysWithDictionary:obj];
            [foods addObject:food];
            
        }];
        
        [super setValue:foods forKey:@"spus"];
        
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
