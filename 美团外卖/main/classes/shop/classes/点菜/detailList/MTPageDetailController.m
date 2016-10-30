//
//  MTPageDetailController.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/10.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTPageDetailController.h"
#import "MTDetailViewController.h"
#import "MTCategroyModel.h"
#import "MTCarView.h"
#import "MTShoppingListController.h"

@interface MTPageDetailController () <UIPageViewControllerDataSource,MTCarViewDelegate>

@end

@implementation MTPageDetailController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    _carV.shoppingList = _shoppingList;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addToCarViewNotification:) name:MTAddFoodToCarViewNotification object:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.alpha = 1;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    self.navigationController.navigationBar.alpha = _oldAlpha;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)addToCarViewNotification:(NSNotification *)noti {
    
    NSLog(@"%@ %@", noti.object, noti.userInfo);
    // 需要添加的菜品
    MTFoodModel *food = noti.userInfo[MTAddFoodKey];
    CGPoint startPoint = [noti.userInfo[MTStartPointKey] CGPointValue];
    
    // MARK: - 添加模型数据信息到集合
    if (![_shoppingList containsObject:food]) {
        [_shoppingList addObject:food];
    }
    
    // 开始动画!
    // - 1.添加图片框
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_food_count_bg"]];
    imgView.center = startPoint;
    
    // - 将图片框添加给窗口
    UIWindow *keyW = [UIApplication sharedApplication].keyWindow;
    [keyW addSubview:imgView];
    
    // - 2.开启核心动画,让图片框运动
    // 1.创建对象
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 通过kvc给动画绑定imgView!
    // 只有kvc可以这么做,其他的对象,不ok!
    [anim setValue:imgView forKey:@"imgV"];
    
    // 2.设置属性
    // - 路径对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    // - 移动到起点
    [path moveToPoint:startPoint];
    // - 添加完美曲线!
    /**
     * 参数1 -> 结束时的点
     * 参数2 -> 控制点
     */
    // 结束点
    CGPoint endP = CGPointMake(50, keyW.bounds.size.height - 45);
    // 控制点
    CGPoint controlP = CGPointMake(startPoint.x - 130, startPoint.y - 120);
    // 添加完美路径
    [path addQuadCurveToPoint:endP controlPoint:controlP];
    
    anim.path = path.CGPath;
    
    // 不让闪回去
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    anim.duration = 1;
    
    // 设置动画的代理
    anim.delegate = self;
    
    // 3.添加
    [imgView.layer addAnimation:anim forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    // 1.移除图片框
    // - 取出图片框
    UIImageView *imgV = [anim valueForKey:@"imgV"];
    // - 移除核心动画
    [imgV.layer removeAllAnimations];
    
    // - 移除
    [imgV removeFromSuperview];
    
    // 2.将数据信息传递给购物车视图!
    _carV.shoppingList = _shoppingList;
    
}

#pragma mark - 移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUI {
    
    UIPageViewController *pageVc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageVc.dataSource = self;
    
    MTDetailViewController *detailVc = [self detailViewControllerWithIdx:_indexPath];
    
    [pageVc setViewControllers:@[detailVc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self cz_addChildController:pageVc intoView:self.view];
    
    MTCarView *carV = [MTCarView carView];
    carV.delegate = self;
    _carV = carV;
    [self.view addSubview:carV];
    
    [carV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(46);
    }];
}

#pragma mark - MTCarView的代理方法
- (void)bottomCarView:(MTCarView *)carView needsDisplaySelectFoods:(NSMutableArray<MTFoodModel *> *)selectFoods {
    MTShoppingListController *shopListVc = [[MTShoppingListController alloc] init];
    
    [self presentViewController:shopListVc animated:YES completion:nil];
}

#pragma mark - pageController的代理方法
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(MTDetailViewController *)viewController {
    
    NSIndexPath *preIndex = [[NSIndexPath alloc] init];
    NSInteger row = viewController.indexPath.row;
    NSInteger section = viewController.indexPath.section;
    
    row --;
    if (row < 0 ) {
        if (section == 0) {
            NSLog(@"已经到顶了");
            return nil;
        }
        section--;
        row = _categroyList[section].spus.count - 1;
    }
    
    preIndex = [NSIndexPath indexPathForRow:row inSection:section];
    MTDetailViewController *detailVc = [self detailViewControllerWithIdx:preIndex];
    
    return detailVc;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(MTDetailViewController *)viewController {
    
    NSIndexPath *nextIndex = [[NSIndexPath alloc] init];
    NSInteger row = viewController.indexPath.row;
    NSInteger section = viewController.indexPath.section;
    
    row++;
    if (row > _categroyList[viewController.indexPath.section].spus.count - 1) {
        section++;
        if (section > _categroyList.count - 1) {
            NSLog(@"最后一个了");
            return nil;
        }
        row = 0;
    }
    
    nextIndex = [NSIndexPath indexPathForRow:row inSection:section];
    MTDetailViewController *detailVc = [self detailViewControllerWithIdx:nextIndex];
    
    return detailVc;
}

#pragma mark - 创建detailViewController
- (MTDetailViewController *)detailViewControllerWithIdx:(NSIndexPath *)indexPath {
    
    MTDetailViewController *detailVc = [[MTDetailViewController alloc] init];
    detailVc.indexPath = indexPath;
    detailVc.food = _categroyList[indexPath.section].spus[indexPath.row];
    
    return detailVc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
