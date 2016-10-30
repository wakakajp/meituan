//
//  ViewController.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/4.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "ViewController.h"
#import "MTShopViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)setupUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    [btn addTarget:self action:@selector(clickToShop) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickToShop {
    // 1.创建点餐控制器
    MTShopViewController *shopVc = [[MTShopViewController alloc] init];
    
    // 2.跳转
    [self.navigationController pushViewController:shopVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
