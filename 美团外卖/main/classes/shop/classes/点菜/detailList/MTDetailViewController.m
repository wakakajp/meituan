//
//  MTDetailViewController.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/10.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTDetailViewController.h"
#import "MTFoodDetailHeaderView.h"
#import "MTFoodModel.h"
#import "UIImageView+WebCache.h"

#define kTopImageVH 280

@interface MTDetailViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UITableView *tv;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;

@property (weak,nonatomic) MTFoodDetailHeaderView *headerView;

@end

@implementation MTDetailViewController

- (void)setupUI {
    
    MTFoodDetailHeaderView *headerV = [MTFoodDetailHeaderView foodDetailHeaderView];
    headerV.bounds = CGRectMake(0, 0, 0, 200);
    _headerView = headerV;
    
    _tv.tableHeaderView = headerV;
    _tv.contentInset = UIEdgeInsetsMake(kTopImageVH, 0, 0, 0);
    _tv.backgroundColor = [UIColor clearColor];
    _tv.showsVerticalScrollIndicator = NO;
    _tv.tableFooterView = [[UIView alloc] init];
    
    NSString *path = [_food.picture stringByDeletingPathExtension];
    NSURL *url = [NSURL URLWithString:path];
    
    [_topImageView sd_setImageWithURL:url];
    
    _headerView.foodM = _food;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (- offsetY < 0) {
        return;
    }
    _imageViewHeight.constant = - offsetY;
    
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
