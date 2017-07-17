//
//  YRHXInviteRewardsController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/14.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXInviteRewardsController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "UILabel+CZAddition.h"
#import "YRHXInviteDetailController.h"
#import "YRHXRewardsDetailController.h"
#import "InviteRulesController.h"

@interface YRHXInviteRewardsController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIView * headerView;
@property (nonatomic,weak) UIView * categaryView;
@property(nonatomic,strong)UIButton * selectedBtn;
@property(nonatomic,weak)UIScrollView * contentView;
@property (nonatomic,weak) UIButton * firstBtn;
@property(nonatomic,weak)UIView * lineView;

@end

@implementation YRHXInviteRewardsController

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
   
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"邀请奖励";
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,80,30)];
    [rightButton setTitle:@"邀请规则" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightButton addTarget:self action:@selector(ruleBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    

    
    
    
    [self setupHeadViewUI];
    [self creatSmallCategaryView];
    [self creatContentView];
    
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)ruleBtnClick
{
    InviteRulesController * rulesVC = [[InviteRulesController alloc]initWithNibName:@"InviteRulesController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:rulesVC animated:YES];
}



- (void)setupHeadViewUI
{
    UIView * headerView = [[UIView alloc]init];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.view).offset(0);
        make.height.offset(177);
    }];
    self.headerView = headerView;
    
    UIImageView * headerImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"邀请背景"]];
    [headerView addSubview:headerImg];
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
  
    UILabel * totalMoney = [UILabel cz_labelWithText:@"000.00" fontSize:24 color:[UIColor whiteColor]];
    [headerView addSubview:totalMoney];
    [totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(27);
        make.right.offset(-60);
    }];
    
    UILabel * moneyLabel = [UILabel cz_labelWithText:@"我的推荐奖励（元）" fontSize:14 color:[UIColor colorWithWhite:1 alpha:0.7]];
    [headerView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalMoney.mas_bottom).offset(3);
        make.centerX.equalTo(totalMoney).offset(5);
    }];

    UILabel * totalPerson = [UILabel cz_labelWithText:@"0" fontSize:24 color:[UIColor whiteColor]];
    [headerView addSubview:totalPerson];
    [totalPerson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyLabel.mas_bottom).offset(20);
         make.centerX.equalTo(totalMoney);
    }];
    
    UILabel * personLabel = [UILabel cz_labelWithText:@"推荐好友人数（人）" fontSize:14 color:[UIColor colorWithWhite:1 alpha:0.7]];
    [headerView addSubview:personLabel];
    [personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalPerson.mas_bottom).offset(3);
        make.centerX.equalTo(totalMoney).offset(5);
    }];
    
    
    
}




- (void)creatSmallCategaryView
{
    
    UIView * categaryView = [[UIView alloc]init];
    categaryView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:categaryView];
    [categaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.headerView.mas_bottom).offset(0);
        make.height.offset(45);
    }];
    
    self.categaryView = categaryView;
    
    NSArray * array = @[@"邀请明细",@"奖励明细"];
    NSMutableArray * btnArrM = [NSMutableArray array];
    
    for (int i =0; i < array.count; i++) {
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"eb413d"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            [self btnClick:btn];
        }
        [categaryView addSubview:btn];
        [btnArrM addObject:btn];
    }
    
    [btnArrM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(categaryView);
    }];
    [btnArrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    //创建黄色的线
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    [self.categaryView addSubview:lineView];
    
    UIButton * firstBtn = btnArrM[0];
    
    CGFloat pictureRealW = screenBounds.size.width / 2;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(firstBtn);
        make.width.offset(pictureRealW);
        make.height.offset(2);
    }];
    
    self.firstBtn = firstBtn;
    self.lineView = lineView;
}


//点击按钮后。黄线移动到新的按钮上
- (void)btnClick:(UIButton *)btn
{
    btn.selected = YES;
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    
    [self.contentView setContentOffset:CGPointMake(btn.tag * self.contentView.bounds.size.width, 0) animated:YES];
    
    
}


//代理方法  contentView设置代理才能进方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //更新黄色横线的中心点X
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.firstBtn).offset(page * self.firstBtn.bounds.size.width);
    }];
    
}

//减速结束的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    UIButton * button = self.categaryView.subviews[page];
    button.selected = YES;
    self.selectedBtn.selected = NO;
    self.selectedBtn = button;
}



//3   添加内容视图view
- (void)creatContentView
{
    //创建滚动器view
    UIScrollView * contentView = [[UIScrollView alloc]init];
    contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    contentView.pagingEnabled = YES;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.categaryView.mas_bottom);
    }];
    
    //分别创建三个控制器
    YRHXInviteDetailController * alredyholdVc = [[YRHXInviteDetailController alloc]init];
    YRHXRewardsDetailController * couldTransferVc = [[YRHXRewardsDetailController alloc]init];
    
    //把控制器对应的view添加到contentView上
    [contentView addSubview:alredyholdVc.view];
    [contentView addSubview:couldTransferVc.view];
    
    //建立父子关系
    [self addChildViewController:alredyholdVc];
    [self addChildViewController:couldTransferVc];
    
    [alredyholdVc didMoveToParentViewController:self];
    [couldTransferVc didMoveToParentViewController:self];
    
    [contentView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [contentView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView);
        make.size.equalTo(contentView);
    }];
    
    self.contentView = contentView;
    contentView.delegate = self;
}








@end
