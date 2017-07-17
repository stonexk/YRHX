
//
//  YRHXSelectionProjectController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/18.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXSelectionProjectController.h"
#import "ProjectCell.h"
#import "YRHXCircleView.h"
#import "Masonry.h"
#import "YRHXWantBuyController.h"

@interface YRHXSelectionProjectController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;


@end

@implementation YRHXSelectionProjectController

//投标的精选项目界面


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
    
//    //导航栏文字 和 左边按钮
//    self.navigationItem.title = nil;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

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



- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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

    CGFloat imageW = 375;
    CGFloat imageH = 65;
    CGFloat pictureRealW = KscreenWidth;
    CGFloat pictureRealH = imageH * pictureRealW / imageW;
    
    ProjectCell * projectcell = [[NSBundle mainBundle]loadNibNamed:@"ProjectCell" owner:nil options:nil].lastObject;
    //添加进度条view
    YRHXCircleView *custom = [[YRHXCircleView alloc]initWithFrame:CGRectMake(screenBounds.size.width - 87.5, 65, pictureRealH, pictureRealH)];
    
    custom.progress = 0.88;
    
// 点击YRHXCircleView进去看看
    
    
    [projectcell addSubview:custom];
    
    
    return projectcell;
}

//选中某一行cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YRHXWantBuyController * buyVC = [[YRHXWantBuyController alloc]init];
    
    [self.navigationController pushViewController:buyVC animated:YES];
}






@end
