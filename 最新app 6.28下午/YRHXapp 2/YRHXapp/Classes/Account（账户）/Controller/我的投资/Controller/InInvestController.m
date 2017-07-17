//
//  InInvestController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/2.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "InInvestController.h"
#import "InInvestCell.h"
#import "NoRecoverController.h"
#import "DetailInRecoverController.h"

@interface InInvestController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;


@end
//static NSString * cellID = @"cellID";

@implementation InInvestController


//懒加载
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, KscreenHeight-109)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //if判断 有没有内容
    
    
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [UIView new];
  
    //导航栏文字 和 左边按钮
    self.navigationItem.title = nil;
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


#pragma 数据源方法===============
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InInvestCell * InInvestcell = [[NSBundle mainBundle]loadNibNamed:@"InInvestCell" owner:nil options:nil].lastObject;
    
    return InInvestcell;
    
}

//选中某一行cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //根据后台传回来的接口判断 跳转哪个界面 有投资/无投资
    //    if (<#condition#>) {
    //            NoRecoverController * noRecoverVC = [[NoRecoverController alloc]initWithNibName:@"NoRecoverController" bundle:[NSBundle mainBundle]];
    //    [self.navigationController pushViewController:noRecoverVC animated:YES];
    //    }
    
    DetailInRecoverController * inRecoverVC = [DetailInRecoverController new];
    [self.navigationController pushViewController:inRecoverVC animated:YES];
}


@end
