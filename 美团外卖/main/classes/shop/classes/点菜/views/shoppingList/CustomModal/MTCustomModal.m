//
//  MTCustomModal.m
//  MT_waimai[007]
//
//  Created by HM on 16/8/8.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "MTCustomModal.h"
#import "MTPresentationController.h"

@implementation MTCustomModal

/**
 *  负责自定义modal时控制器界面显示效果的方法
 *
 *  @param presented  要显示的控制器
 *  @param presenting 负责显示vc的控制器
 *  @param source     从哪里显示!
 *
 *  @return 返回的是一个 UIPresentationController 类型的对象!
 */
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {

    // 这个控制器对象 继承NSObject! 只负责控制器,不负责具体界面展示!
    MTPresentationController *presentC = [[MTPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    return presentC;
    
}

@end
