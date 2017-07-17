//
//  AlreadyTransferController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/3.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "AlreadyTransferController.h"
#import "AlreadyTransferCell.h"
#import "YRHXWantBuyController.h"

@interface AlreadyTransferController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation AlreadyTransferController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back1)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor darkGrayColor];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

//懒加载
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, tableViewHeight + 25)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //if判断 有没有内容  应该在跳转前判断 可以设置两个控制器
    
    
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back1)];
    
    [self setUpLastFooterView];
}
- (void)back1 {
    
    [self.navigationController popViewControllerAnimated:YES];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}


//pragma 数据源方法===============
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlreadyTransferCell * transferCell = [[NSBundle mainBundle]loadNibNamed:@"AlreadyTransferCell" owner:nil options:nil].lastObject;
    
    return transferCell;
    
}

//选中某一行cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YRHXWantBuyController * view = [YRHXWantBuyController new];
    [self.navigationController pushViewController:view animated:YES];
    
}




@end
