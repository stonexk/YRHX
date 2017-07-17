//
//  CouldTransferController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/3.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "CouldTransferController.h"
#import "CouldTransferCell.h"
#import "IssueCreditorTransferController.h"

@interface CouldTransferController ()<UITableViewDelegate,UITableViewDataSource,CouldTransferCellDelegate>

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation CouldTransferController

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
    
    //如果没有内容的话 用这个
/*
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel * jiazaiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 50)];
    jiazaiLabel.text = @"全部加载完啦~";
    jiazaiLabel.textAlignment = NSTextAlignmentCenter;
    jiazaiLabel.textColor = [UIColor darkGrayColor];
    jiazaiLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    jiazaiLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:jiazaiLabel];
*/
    
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back1)];
    
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
    CouldTransferCell * couldTransferCell = [[NSBundle mainBundle]loadNibNamed:@"CouldTransferCell" owner:nil options:nil].lastObject;
    
    couldTransferCell.delegate = self;
    return couldTransferCell;
    
}


//选中某一行cell  
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//跳转界面代理
- (void)CouldTransferCellWith:(CouldTransferCell *)couldTransferCell andbutton:(UIButton *)button
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"IssueTransfer" bundle:nil];
    IssueCreditorTransferController * issueVC = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:issueVC animated:YES];
}

@end
