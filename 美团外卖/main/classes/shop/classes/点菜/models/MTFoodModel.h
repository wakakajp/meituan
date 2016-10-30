//
//  MTFoodModel.h
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/7.
//  Copyright © 2016年 jp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTFoodModel : NSObject

@property (copy,nonatomic) NSString *picture;

@property (copy,nonatomic) NSString *name;

@property (copy,nonatomic) NSString *month_saled_content;

@property (strong,nonatomic) NSNumber *praise_num;

@property (strong,nonatomic) NSNumber *min_price;

@property (assign,nonatomic) NSInteger foodCount;

//不能直接写description,因为使用点语法的时候跟系统的description方法冲突
@property (copy,nonatomic) NSString *desc;

@end
