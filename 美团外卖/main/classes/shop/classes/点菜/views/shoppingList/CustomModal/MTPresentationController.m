//
//  MTPresentationController.m
//  MT_waimai[007]
//
//  Created by HM on 16/8/8.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "MTPresentationController.h"

@implementation MTPresentationController



#pragma mark - 实现布局视图的方法
// 系统提供的容器视图将要布局结束子控件后调用!
- (void)containerViewWillLayoutSubviews {
    
    [super containerViewWillLayoutSubviews];
    
    // 替换为自己想要的效果!
    // 1.获取容器视图
    UIView *containerV = self.containerView;
    
    // MARK: - 添加一个遮罩视图
    UIView *maskView = [[UIView alloc] init];
    
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.4;
    
    // 将遮罩视图插入到第0个位置!最底下的子控件!
    [containerV insertSubview:maskView atIndex:0];
    
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(containerV);
        
    }];
    
    // 2.获取要显示的控制器的视图
    UIView *presentedV = self.presentedView;
    
    presentedV.backgroundColor = [UIColor magentaColor];
    // 3.添加
    [containerV addSubview:presentedV];
    
    // 4.布局
    [presentedV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(containerV);
        make.height.mas_equalTo(320);
        
    }];
    
    
    
    
    // MARK: - 销毁的操作
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
#warning - 不能直接添加给containView!
    [maskView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction2:)];
    [presentedV addGestureRecognizer:tap2];
    

}

// 点按销毁控制器
- (void)tapAction:(UITapGestureRecognizer *)recognizer {

    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];

}

// 点按销毁控制器
- (void)tapAction2:(UITapGestureRecognizer *)recognizer {
    
    // 如果触摸点的y值!大于了多少,直接返回!
    // 获取触摸点的位置
    CGPoint loc = [recognizer locationInView:self.presentedView];
    
    if (loc.y > 59) {
        return;
    }
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    
}



@end
