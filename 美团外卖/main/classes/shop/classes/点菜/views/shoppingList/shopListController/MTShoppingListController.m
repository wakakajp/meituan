//
//  MTShoppingListController.m
//  美团外卖
//
//  Created by 哇咔咔 on 16/8/9.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "MTShoppingListController.h"
#import "MTCustomModal.h"


static NSString *cellID = @"cellID";

@interface MTShoppingListController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tv;

@end

@implementation MTShoppingListController {
    
    /**
     * 负责自定义modal的成员变量 -> 强引用!
     */
    MTCustomModal *_cstModal;
}

#pragma mark - 自定义modal的关键设置
- (instancetype)init {
    self = [super init];
    if (self) {
        // 设置这个属性保证可以看到背后的视图!
        self.modalPresentationStyle = UIModalPresentationCustom;
        
        // 设置代理
        _cstModal = [[MTCustomModal alloc] init];
        self.transitioningDelegate = _cstModal;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [_tv registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = @(indexPath.row).description;
    return cell;
    
    
}



@end