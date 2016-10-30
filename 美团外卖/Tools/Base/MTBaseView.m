//
//  MTBaseView.m
//  MeiTuan
//
//  Created by 刘春牢 on 16/7/18.
//  Copyright © 2016年 刘春牢. All rights reserved.
//

#import "MTBaseView.h"

@implementation MTBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {

    [self setupUI];
}

- (void)setupUI {}


@end
