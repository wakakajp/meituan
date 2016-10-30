//
//  MTShopViewController.m
//  MT_waima                     i[007]
//
//  Created by HM on 16/8/4.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "MTShopViewController.h"
#import "CZAdditions.h"
#import "Masonry.h"
#import "MTCategoryView.h"
#import "MTFoodViewController.h"
#import "MTPageDetailController.h"

#define kHeaderHeight 123

@interface MTShopViewController () <UIScrollViewDelegate,UIGestureRecognizerDelegate,MTFoodViewControllerDelegate>

@property (weak,nonatomic) UIScrollView *scrollView;

@property (weak,nonatomic) UIView *headerView;

@property (weak,nonatomic) MTCategoryView *categoryView;

@property (assign,nonatomic) CGFloat alpha;

@end

@implementation MTShopViewController {

}
#pragma mark - 跳转pageVC的代理方法
- (void)foodViewController:(MTFoodViewController *)foodVc pushPageDetailController:(MTPageDetailController *)pageDetailVc {
    pageDetailVc.oldAlpha = _alpha;
    
    [self.navigationController pushViewController:pageDetailVc animated:YES];
}

#pragma mark - 监听事件
- (void)pageNumChange:(MTCategoryView *)sender {
    [_scrollView scrollRectToVisible:CGRectMake(self.view.bounds.size.width * sender.pageNum, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height) animated:YES];
}

#pragma mark - scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!(scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating)) {
        return;
    }
    _categoryView.offsetX = scrollView.contentOffset.x;
}
#pragma mark - 设置底部滚动视图
- (UIScrollView *)setupScrollContentView {
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    
    scrollV.pagingEnabled = YES;
    scrollV.showsHorizontalScrollIndicator = NO;
    
    NSArray *strArr = @[@"MTFoodViewController",@"MTEvaluationViewController",@"MTStoreViewController"];
    
    NSMutableArray *tempArrM = [NSMutableArray arrayWithCapacity:strArr.count];
    
    [strArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Class clz = NSClassFromString(obj);
        
        UIViewController *vc = [[clz alloc] init];
        
        NSAssert([vc isKindOfClass:[UIViewController class]], @"没有%@控制器",vc);
        
        [self cz_addChildController:vc intoView:scrollV];
        
        if ([vc isKindOfClass:[MTFoodViewController class]]) {
            ((MTFoodViewController *)vc).delegate = self;
        }
        //手误,没有.view,报错
        [tempArrM addObject:vc.view];
    }];
    
    [tempArrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [tempArrM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(scrollV);
        make.bottom.top.equalTo(scrollV);
    }];
    
    return scrollV;
}

#pragma mark - 实现手势监听方法
- (void)panAction:(UIPanGestureRecognizer *)recognizer {
    CGPoint tranlate = [recognizer translationInView:self.view];
    
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    CGFloat headerH = self.headerView.bounds.size.height + tranlate.y;
    
    NSLog(@"%lf",tranlate.y);
    
    //限制header的滚动
    if (headerH > 123) {
        headerH = 123;
    }
    if (headerH < 64) {
        headerH = 64;
    }
    
    if (ABS(tranlate.x) > ABS(tranlate.y)) {
        return;
    }
    
    [_headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(headerH);
    }];
    
    [self.view layoutIfNeeded];
    
    //导航条的透明度
    
    CGFloat headerAlpha = (kHeaderHeight - _headerView.bounds.size.height) / (kHeaderHeight - 64.0);
    
    self.navigationController.navigationBar.alpha = headerAlpha;
    
    _alpha = headerAlpha;
    
    NSLog(@"%lf",headerAlpha);
}
#pragma mark - 添加手势
- (void)addPanGestureRecognizer {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
}

#pragma mark - 搭建界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor magentaColor];
    // MARK: - 1.设置标题
    self.navigationItem.title = @"粮新发现(上地店)";
    // MARK: - 2.让导航条透明!
    self.navigationController.navigationBar.alpha = 0;
    
    // MARK: - 3.搭建主视图界面!
    // 1.顶部视图
    UIView *headerV = [[UIView alloc] init];
    headerV.backgroundColor = [UIColor cz_randomColor];
    
    [self.view addSubview:headerV];
    
    [headerV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(kHeaderHeight);
        
    }];
    
    // 2.中间的分类视图
    MTCategoryView *categoryV = [[MTCategoryView alloc] init];
    
    categoryV.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:categoryV];
    
    [categoryV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(headerV.mas_bottom);
        make.left.right.equalTo(headerV);
        make.height.mas_equalTo(37);
    }];
    
    [categoryV addTarget:self action:@selector(pageNumChange:) forControlEvents:UIControlEventValueChanged];
    
    // 3.底部的滚动视图 UIScrollView!
    UIScrollView *scrollV = [self setupScrollContentView];
    
    scrollV.backgroundColor = [UIColor whiteColor];
    scrollV.delegate = self;
    
    [self.view addSubview:scrollV];
    
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(categoryV.mas_bottom);
        make.left.right.equalTo(categoryV);
        make.bottom.equalTo(self.view);
        
    }];
    
    [self addPanGestureRecognizer];
    
    // MARK: - 属性赋值
    _scrollView = scrollV;
    _headerView = headerV;
    _categoryView = categoryV;
}

#pragma mark - 支持多手势操作
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}











@end
