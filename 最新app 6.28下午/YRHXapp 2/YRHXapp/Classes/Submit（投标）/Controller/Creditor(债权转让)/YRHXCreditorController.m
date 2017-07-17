//
//  YRHXCreditorController.m
//  YRHXapp
//
//  Created by Apple on 2017/4/21.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXCreditorController.h"
#import "CreditorTransferCell.h"
#import "YRHXCarryOnCreditorController.h"

@interface YRHXCreditorController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation YRHXCreditorController

//债权转让的界面



//懒加载
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, tableViewHeight - 15)];
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

    [self setUpLastFooterView];
}

//设置底部视图
- (void)setUpLastFooterView
{
    UIButton * LastFooterView =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 30)];
    [LastFooterView setTitle:@"全部加载完啦~" forState:UIControlStateNormal];
    [LastFooterView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    LastFooterView.titleLabel.font = [UIFont systemFontOfSize:10];
    LastFooterView.backgroundColor = [UIColor groupTableViewBackgroundColor];    
    self.tableView.tableFooterView = LastFooterView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
//组高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}


#pragma 数据源方法===============
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreditorTransferCell * creditorCell = [[NSBundle mainBundle]loadNibNamed:@"CreditorTransferCell" owner:nil options:nil].lastObject;

    
    return creditorCell;

    
    
}

//选中某一行cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YRHXCarryOnCreditorController" bundle:nil];
    
    YRHXCarryOnCreditorController * acceptVC = [sb instantiateInitialViewController];
    
    [self.navigationController pushViewController:acceptVC animated:YES];
}






@end
