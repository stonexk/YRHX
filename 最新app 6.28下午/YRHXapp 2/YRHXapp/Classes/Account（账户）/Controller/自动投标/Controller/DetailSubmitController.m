//
//  DetailSubmitController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/5.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "DetailSubmitController.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
#import "DetailSubmitCell.h"

@interface DetailSubmitController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation DetailSubmitController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 57, screenBounds.size.width, tableViewHeight + 20)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor darkGrayColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];    
    self.navigationItem.title = @"自动投标详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    [self setupHeadView];   //上面的分栏view
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setupHeadView
{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, KscreenWidth, 57)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UILabel * label1 = [UILabel cz_labelWithText:@"借款期限范围" fontSize:16 color:[UIColor blackColor]];
    label1.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.height.offset(57);
        make.width.offset(KscreenWidth / 3);
    }];
    
    UILabel * label2 = [UILabel cz_labelWithText:@"排队资金" fontSize:16 color:[UIColor blackColor]];
    label2.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.equalTo(label1.mas_right).offset(0);
        make.height.offset(57);
        make.width.offset(KscreenWidth / 3);
    }];

    UILabel * label3 = [UILabel cz_labelWithText:@"排队人数" fontSize:16 color:[UIColor blackColor]];
    label3.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.equalTo(label2.mas_right).offset(0);
        make.height.offset(57);
        make.width.offset(KscreenWidth / 3);
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 17;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailSubmitCell * detailCell = [[[NSBundle mainBundle] loadNibNamed:@"DetailSubmitCell" owner:nil options:nil] lastObject];
    
    return detailCell;
}




@end
