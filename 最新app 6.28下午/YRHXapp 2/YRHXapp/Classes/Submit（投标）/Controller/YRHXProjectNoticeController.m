//
//  YRHXProjectNoticeController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/25.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXProjectNoticeController.h"
#import "ProjectNoticeCell.h"

@interface YRHXProjectNoticeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UILabel * testLabel;

@end

@implementation YRHXProjectNoticeController

-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, KscreenHeight - 64)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(turnback)];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"新标预告";
   
}


- (void)turnback
{
    [self.navigationController popViewControllerAnimated:YES];
}



//数据源方法==========================
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}

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
    ProjectNoticeCell * pnCell = [[NSBundle mainBundle]loadNibNamed:@"ProjectNoticeCell" owner:nil options:nil].lastObject;

    
    return pnCell;
    
}

//选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}



@end
