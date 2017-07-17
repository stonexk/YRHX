//
//  YRHXRewardsDetailController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/14.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXRewardsDetailController.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
#import "RewardsDetailCell.h"


@interface YRHXRewardsDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UITableViewCell * titleCell;

@end

@implementation YRHXRewardsDetailController
//懒加载
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, tableViewHeight - 210 + 64)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [UIView new];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    RewardsDetailCell * cell = [[NSBundle mainBundle]loadNibNamed:@"RewardsDetailCell" owner:nil options:nil].lastObject;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}







@end
