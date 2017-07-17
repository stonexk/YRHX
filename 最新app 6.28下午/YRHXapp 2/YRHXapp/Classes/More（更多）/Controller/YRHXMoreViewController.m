//
//  YRHXMoreViewController.m
//  YRHX
//
//  Created by 詹稳 on 17/4/18.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXMoreViewController.h"
#import "MoreModel.h"
#import "MoreViewCell.h"
#import "UIColor+ColorChange.h"
#import "STTextHudTool.h"
#import "PublicNoticeViewController.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
#import "NSAttributedString+CZAdditon.h"
#import "NSArray+CZAddition.h"
#import "YRHXHotActivitiesController.h"


@interface YRHXMoreViewController ()

@property (nonatomic, strong)UITableViewCell * topCell;
@property(nonatomic,strong)NSArray * moreArrayData;

@end


static NSString * topCellID = @"topCellID";


@implementation YRHXMoreViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.moreArrayData = [self loadData];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"eb413d"];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:topCellID];
    
    [self setUpHeaderView];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 50*KscreenWidth/375;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.moreArrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreModel * Model = self.moreArrayData[indexPath.row];
    
    _topCell= [tableView dequeueReusableCellWithIdentifier:topCellID forIndexPath:indexPath];
    _topCell.imageView.image = [UIImage imageNamed:Model.pic];
    _topCell.textLabel.text = Model.title;
    _topCell.textLabel.font = [UIFont systemFontOfSize:16];
    _topCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return _topCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}














- (void)setUpHeaderView
{
    UIButton * headerView =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 190)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.titleLabel.font = [UIFont systemFontOfSize:10];
    self.tableView.tableHeaderView = headerView;
    
    UIView * grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 10)];
    [headerView addSubview:grayView];
    grayView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, KscreenWidth / 2, 90)];
    [headerView addSubview:btn1];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"活动"]];
    [btn1 addSubview:image1];
    [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn1);
        make.left.offset(15);
        make.width.height.offset(50);
    }];
    
    UILabel * title1 = [UILabel cz_labelWithText:@"热门活动" fontSize:14 color:[UIColor blackColor]];
    [btn1 addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(-12);
        make.left.equalTo(image1.mas_right).offset(8);
    }];
    
    UILabel * subTitle1 = [UILabel cz_labelWithText:@"关注平台热门活动" fontSize:12 color:[UIColor darkGrayColor]];
    [btn1 addSubview:subTitle1];
    [subTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(13);
        make.left.equalTo(image1.mas_right).offset(8);
    }];
    
    UILabel * lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(KscreenWidth/2, 15, 1, 60)];
    [btn1 addSubview:lineLabel1];
    lineLabel1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(KscreenWidth/2, 10, KscreenWidth / 2, 90)];
    [headerView addSubview:btn2];
    
    UIImageView * image2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"动态"]];
    [btn2 addSubview:image2];
    [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn2);
        make.left.offset(15);
        make.width.height.offset(50);
    }];
    
    UILabel * title2 = [UILabel cz_labelWithText:@"最新动态" fontSize:14 color:[UIColor blackColor]];
    [btn2 addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(-12);
        make.left.equalTo(image2.mas_right).offset(8);
    }];
    
    UILabel * subTitle2 = [UILabel cz_labelWithText:@"了解平台动态" fontSize:12 color:[UIColor darkGrayColor]];
    [btn2 addSubview:subTitle2];
    [subTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(13);
        make.left.equalTo(image2.mas_right).offset(8);
    }];
    
    
    UILabel * lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 100*KscreenWidth/375, KscreenWidth, 1)];
    [headerView addSubview:lineLabel2];
    lineLabel2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton * btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, KscreenWidth / 2, 90)];
    [headerView addSubview:btn3];
    
    UIImageView * image3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"安全保障-1"]];
    [btn3 addSubview:image3];
    [image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn3);
        make.left.offset(15);
        make.width.height.offset(50);
    }];
    
    UILabel * title3 = [UILabel cz_labelWithText:@"安全保障" fontSize:14 color:[UIColor blackColor]];
    [btn3 addSubview:title3];
    [title3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(-12);
        make.left.equalTo(image3.mas_right).offset(8);
    }];
    
    UILabel * subTitle3 = [UILabel cz_labelWithText:@"保障您的资金安全" fontSize:12 color:[UIColor darkGrayColor]];
    [btn3 addSubview:subTitle3];
    [subTitle3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(13);
        make.left.equalTo(image3.mas_right).offset(8);
    }];

    UILabel * lineLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(KscreenWidth/2, 115, 1, 60)];
    [headerView addSubview:lineLabel3];
    lineLabel3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    
    UIButton * btn4 = [[UIButton alloc]initWithFrame:CGRectMake(KscreenWidth/2, 100, KscreenWidth / 2, 90)];
    [headerView addSubview:btn4];
    
    UIImageView * image4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"公司简介"]];
    [btn4 addSubview:image4];
    [image4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn4);
        make.left.offset(15);
        make.width.height.offset(50);
    }];
    
    UILabel * title4 = [UILabel cz_labelWithText:@"关于我们" fontSize:14 color:[UIColor blackColor]];
    [btn4 addSubview:title4];
    [title4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(-12);
        make.left.equalTo(image4.mas_right).offset(8);
    }];
    
    UILabel * subTitle4 = [UILabel cz_labelWithText:@"了解易融恒信" fontSize:12 color:[UIColor darkGrayColor]];
    [btn4 addSubview:subTitle4];
    [subTitle4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(13);
        make.left.equalTo(image4.mas_right).offset(8);
    }];
}

- (void)btn1Click
{
    YRHXHotActivitiesController * hotVC = [YRHXHotActivitiesController new];
    [self.navigationController pushViewController:hotVC animated:YES];
}

















- (NSArray *)loadData {
    
    return [NSArray cz_objectListWithPlistName:@"More.plist" clsName:@"MoreModel"];
}



@end
