//
//  WithdrawCashRecordController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/5.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "WithdrawCashRecordController.h"
#import "WithdrawCashRecordCell.h"


@interface WithdrawCashRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation WithdrawCashRecordController

-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width,KscreenHeight - 64)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(turnBack)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor darkGrayColor];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    //导航栏文字 和 左边按钮
    self.navigationItem.title = @"提现记录";
    [self setUpLastFooterView];
}
- (void)turnBack {
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
//组高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


#pragma 数据源方法===============
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WithdrawCashRecordCell * projectcell = [[NSBundle mainBundle]loadNibNamed:@"WithdrawCashRecordCell" owner:nil options:nil].lastObject;
    
    return projectcell;
}

//选中某一行cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




@end
