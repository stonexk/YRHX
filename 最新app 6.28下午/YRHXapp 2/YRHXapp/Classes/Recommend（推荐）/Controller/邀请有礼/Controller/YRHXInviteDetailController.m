//
//  YRHXInviteDetailController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/14.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXInviteDetailController.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
#import "InviteDetailCell.h"


@interface YRHXInviteDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UITableViewCell * titleCell;
@end

@implementation YRHXInviteDetailController

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
    self.navigationItem.title = nil;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"titleCellID"];
    
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //标题栏
    if (indexPath.row == 0) {
        _titleCell = [tableView dequeueReusableCellWithIdentifier:@"titleCellID" forIndexPath:indexPath];
        
        [self setupTitleCellUI];
        
        return _titleCell;
    }
    
    InviteDetailCell * cell = [[NSBundle mainBundle]loadNibNamed:@"InviteDetailCell" owner:nil options:nil].lastObject;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 45;
    }
    return 45;
}




- (void)setupTitleCellUI
{
    UILabel * friendsLabel = [UILabel cz_labelWithText:@"好友" fontSize:13 color:[UIColor blackColor]];
    [_titleCell addSubview:friendsLabel];
    [friendsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17);
        make.centerY.equalTo(_titleCell);
    }];
    
    UILabel * rewardsDateLabel = [UILabel cz_labelWithText:@"奖励日期" fontSize:13 color:[UIColor blackColor]];
    [_titleCell addSubview:rewardsDateLabel];
    [rewardsDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleCell);
        make.centerX.equalTo(_titleCell).offset(-20);
    }]; 
    
    UILabel * remarkLabel = [UILabel cz_labelWithText:@"备注" fontSize:13 color:[UIColor blackColor]];
    [_titleCell addSubview:remarkLabel];
    [remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleCell);
        make.right.offset(-35);
    }];
  
}











@end

