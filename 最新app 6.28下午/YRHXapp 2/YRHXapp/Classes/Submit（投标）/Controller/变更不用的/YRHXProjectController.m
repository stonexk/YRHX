//
//  YRHXProjectController.m
//  YRHXapp
//
//  Created by Apple on 2017/4/20.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXProjectController.h"
#import "ProjectCell.h"
#import "YRHXCircleView.h"
#import "Masonry.h"
#import "YRHXStartBuyController.h"

@interface YRHXProjectController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation YRHXProjectController

//投标的精选项目界面


//懒加载
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, tableViewHeight - 27.5)];
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
        
    //导航栏文字 和 左边按钮
    self.navigationItem.title = nil;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

//组高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
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
   ProjectCell * projectcell = [[NSBundle mainBundle]loadNibNamed:@"ProjectCell" owner:nil options:nil].lastObject;

 //添加进度条view
    YRHXCircleView *custom = [[YRHXCircleView alloc]initWithFrame:CGRectMake(screenBounds.size.width - 87.5, 32, 70, 70)];
 
        custom.progress = 1;
#warning 点击YRHXCircleView进去看看
        [projectcell addSubview:custom];

    return projectcell;
 
    
}

//选中某一行cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    YRHXStartBuyController * buyVC = [[YRHXStartBuyController alloc]init];

    [self.navigationController pushViewController:buyVC animated:YES];
}











@end
