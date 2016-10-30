//
//  MTFoodViewController.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/5.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTFoodViewController.h"
#import "MTCategroyModel.h"
#import "MTFoodCell.h"
#import "MTCategroyCell.h"
#import "MTFoodHeaderView.h"
#import "MTCountOrder.h"
#import "MTCarView.h"
#import "MTFoodModel.h"
#import "MTShoppingListController.h"
#import "MTPageDetailController.h"

static NSString *categroyCellID = @"categroyCellID";
static NSString *foodCellID = @"foodCellID";
static NSString *headerID = @"headerID";
@interface MTFoodViewController () <UITableViewDelegate,UITableViewDataSource,MTFoodCellDelegate,MTCarViewDelegate>

@property (weak,nonatomic) UITableView *tvCategroy;

@property (weak,nonatomic) UITableView *tvFood;

@property (weak,nonatomic) MTCarView *carV;


@end

@implementation MTFoodViewController {
    
    NSArray<MTCategroyModel *> *_categroyList;
    
    NSMutableArray<MTFoodModel *> *_shoppingList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
    
    [_tvCategroy registerClass:[MTCategroyCell class] forCellReuseIdentifier:categroyCellID];
    [_tvFood registerClass:[MTFoodCell class] forCellReuseIdentifier:foodCellID];
    [_tvFood registerClass:[MTFoodHeaderView class] forHeaderFooterViewReuseIdentifier:headerID];
    
    NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tvCategroy selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    _shoppingList = [NSMutableArray array];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNotification:) name:MTAddFoodToCarViewNotification object:nil];
}

- (void)addNotification:(NSNotification *)noti {
    MTFoodModel *food = noti.userInfo[MTAddFoodKey];
    if (![_shoppingList containsObject:food]) {
        [_shoppingList addObject:food];
    }
    
    _carV.shoppingList = _shoppingList;
    //让菜品刷新列表
    [_tvFood reloadData];
}

#pragma mark - 移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
} 

#pragma mark - MTFoodCell的代理方法
- (void)didFinishIncrease:(MTFoodCell *)foodCell foodModel:(MTFoodModel *)food starPoint:(CGPoint)starP{
    if (![_shoppingList containsObject:food]) {
        [_shoppingList addObject:food];
    }
    
    UIWindow *keyW = [UIApplication sharedApplication].keyWindow;
    UIView *view = self.view;
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_food_count_bg"]];
    
    [view addSubview:imageV];
    
    CGPoint newP = [keyW convertPoint:starP toView:view];
    
    imageV.center = newP;
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:newP];
    
    CGPoint endP = [_carV convertPoint:_carV.numBtnCenter toView:view];
    
    [path addQuadCurveToPoint:endP controlPoint:CGPointMake(newP.x - 130, newP.y -120)];
    
    anim.path = path.CGPath;
    anim.duration = 0.5;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    
    [anim setValue:imageV forKey:@"imageV"];
    
    [imageV.layer addAnimation:anim forKey:nil];
    
}

- (void)didFinishDecrease:(MTFoodCell *)foolcell foodModel:(MTFoodModel *)food{
    if (food.foodCount == 0) {
        [_shoppingList removeObject:food];
    }
    _carV.shoppingList = _shoppingList;
}

// MTCarViewDelegate
- (void)bottomCarView:(MTCarView *)carView needsDisplaySelectFoods:(NSMutableArray<MTFoodModel *> *)selectFoods {
    
    // 1.创建对象
    MTShoppingListController *listVc = [[MTShoppingListController alloc] init];
    
    // 2.modal
    [self presentViewController:listVc animated:YES completion:nil];
    
}

#pragma mark - CAanimation的代理方法

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _carV.shoppingList = _shoppingList;
    
    UIImageView *imageV = [anim valueForKey:@"imageV"];
    
    [imageV.layer removeAllAnimations];
    [imageV removeFromSuperview];
    
}

#pragma mark - tableView的代理方法
//实现tvFood滚动时tvCategroy的联动
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tvCategroy) {
        return;
    }
    
    if (!(tableView.isDragging || tableView.isDecelerating || tableView.isTracking)) {
        return;
    }
    
    NSIndexPath *selectedIdx = [NSIndexPath indexPathForRow:indexPath.section inSection:0];
    [_tvCategroy selectRowAtIndexPath:selectedIdx animated:NO scrollPosition:UITableViewScrollPositionTop];
}

//实现tvCategroy点击时tvFood的滚动
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tvFood) {
        MTPageDetailController *pageDetailVc = [[MTPageDetailController alloc] init];
        pageDetailVc.indexPath = indexPath;
        pageDetailVc.categroyList = _categroyList;
        pageDetailVc.shoppingList = _shoppingList;
        
        if ([_delegate respondsToSelector:@selector(foodViewController:pushPageDetailController:)]) {
            [_delegate foodViewController:self pushPageDetailController:pageDetailVc];
        }
        
    }
    
    NSIndexPath *scrollIdx = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
    [_tvFood scrollToRowAtIndexPath:scrollIdx atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//设置自定义组头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _tvCategroy) {
        return 0;
    }
    
    return 23;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MTFoodHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    headerView.title = _categroyList[section].name;
    
    return headerView;
}

#pragma mark - tableView的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _tvCategroy) {
        return 1;
    }
    
    return _categroyList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tvCategroy) {
        return _categroyList.count;
    }
    
    return _categroyList[section].spus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tvCategroy) {
        UITableViewCell *cell = [_tvCategroy dequeueReusableCellWithIdentifier:categroyCellID forIndexPath:indexPath];
        
        cell.textLabel.text = _categroyList[indexPath.row].name;
    
        return cell;
    }
    
    MTFoodCell *cell = [_tvFood dequeueReusableCellWithIdentifier:foodCellID forIndexPath:indexPath];
    cell.food = _categroyList[indexPath.section].spus[indexPath.row];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark - 加载数据
- (void)loadData {
    //加载url
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"food.json" withExtension:nil];
    
    //转为二进制数据
    NSData *totalData = [NSData dataWithContentsOfURL:url];
    
    //反序列化
    NSDictionary *totalDict = [NSJSONSerialization JSONObjectWithData:totalData options:NSJSONReadingMutableContainers error:nil];
    
    //字典转模型
    NSArray<NSDictionary *> *categroyList = totalDict[@"data"][@"food_spu_tags"];
    
    NSMutableArray *tempArrM = [NSMutableArray arrayWithCapacity:categroyList.count];
    [categroyList enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        MTCategroyModel *categroy = [[MTCategroyModel alloc] init];
        [categroy setValuesForKeysWithDictionary:obj];
        
        [tempArrM addObject:categroy];
    }];
    
    _categroyList = tempArrM.copy;
}
#pragma mark - 搭建界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    // MARK: - 1.左侧的分类列表视图
    UITableView *tvCategory = [[UITableView alloc] init];
    tvCategory.rowHeight = 55;
    tvCategory.showsVerticalScrollIndicator = NO;
    tvCategory.delegate = self;
    tvCategory.dataSource = self;
    tvCategory.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tvCategory];
    
    [tvCategory mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self.view);
        make.width.mas_equalTo(86);
        make.bottom.equalTo(self.view).offset(-46);
        
    }];
    
    // MARK: - 2.右侧的菜品列表视图
    UITableView *tvFood = [[UITableView alloc] init];
    
    tvFood.showsVerticalScrollIndicator = NO;
    tvFood.delegate = self;
    tvFood.dataSource = self;
    tvFood.estimatedRowHeight = 120;
    tvFood.rowHeight = UITableViewAutomaticDimension;
    
    [self.view addSubview:tvFood];
    
    [tvFood mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(tvCategory);
        make.right.equalTo(self.view);
        make.left.equalTo(tvCategory.mas_right);
        
    }];
    
    
    // MARK: - 3.底部的购物占位视图
    MTCarView *carV = [MTCarView carView];
    _carV = carV;
    carV.delegate = self;
    
    [self.view addSubview:carV];
    
    [carV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(tvCategory.mas_bottom);
        make.left.equalTo(tvCategory);
        make.right.equalTo(tvFood);
        make.bottom.equalTo(self.view);
        
    }];
    
    // MARK: - 4.成员变量的赋值
    _tvCategroy = tvCategory;
    _tvFood = tvFood;
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
