//
//  YRHXMyInvestController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/2.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXMyInvestController.h"
#import "LatestInvestController.h"
#import "InInvestController.h"
#import "InRecoverController.h"
#import "AlreadyRecoverController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"

@interface YRHXMyInvestController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIView * categaryView;
@property(nonatomic,strong)UIButton * selectedBtn;
@property(nonatomic,weak)UIScrollView * contentView;
@property (nonatomic,weak) UIButton * firstBtn;
@property(nonatomic,weak)UIView * lineView;

@end

@implementation YRHXMyInvestController

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
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    self.navigationItem.title = @"我的投资";
    
    [self creatSmallCategaryView];
    
    [self creatContentView];
   
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)creatSmallCategaryView
{
    //创建中间小的分类view
    UIView * categaryView = [[UIView alloc]init];
    categaryView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:categaryView];   //添加到HomeDetail控制器
    
    [categaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.view).offset(1);
        make.height.offset(45);
    }];
    
    self.categaryView = categaryView;    //赋值
    
    NSArray * array = @[@"最近投资",@"投标中",@"回收中",@"已回收"];
    NSMutableArray * btnArrM = [NSMutableArray array];
    
    for (int i =0; i < array.count; i++) {
        
        UIButton * btn = [[UIButton alloc]init];
        
        [btn setTitle:array[i] forState:UIControlStateNormal];  //字体
        
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"eb413d"] forState:UIControlStateSelected];   //字体颜色
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];  //字体大小
        
        btn.tag = i;
        //监听事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            [self btnClick:btn];
        }
        
        [categaryView addSubview:btn];
        [btnArrM addObject:btn];   //添加到可变数组中
    }
    
    //布局按钮
    [btnArrM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(categaryView);
    }];
    //布局按钮  1水平放置/垂直放置  2间隔大小  3左间距  4右间距
    [btnArrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    
    //创建黄色的线
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    [self.categaryView addSubview:lineView];
    
    //约束 (参考第一个按钮)
    UIButton * firstBtn = btnArrM[0];
    
    CGFloat pictureRealW = screenBounds.size.width / 4;
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
    
    //设置内容视图
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
    //获取偏移量
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //获取按钮
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
    
    contentView.pagingEnabled = YES;   //设置分页效果
    
    contentView.showsVerticalScrollIndicator = NO;   //取消滚动条
    contentView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:contentView];    //添加到控制器
    //添加约束
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.categaryView.mas_bottom);
        
    }];
    
    
    LatestInvestController * latestVc = [[LatestInvestController alloc]init];
    InInvestController * inverstVc = [[InInvestController alloc]init];
    InRecoverController * inrecoverVc = [[InRecoverController alloc]init];
    AlreadyRecoverController * alreadyVc = [[AlreadyRecoverController alloc]init];
    
    
    //把控制器对应的view添加到contentView上
    [contentView addSubview:latestVc.view];
    [contentView addSubview:inverstVc.view];
    [contentView addSubview:inrecoverVc.view];
    [contentView addSubview:alreadyVc.view];
    
    //建立父子关系
    [self addChildViewController:latestVc];
    [self addChildViewController:inverstVc];
    [self addChildViewController:inrecoverVc];
    [self addChildViewController:alreadyVc];
    
    
    //告诉系统已建立父子关系
    [latestVc didMoveToParentViewController:self];
    [inverstVc didMoveToParentViewController:self];
    [inrecoverVc didMoveToParentViewController:self];
    [alreadyVc didMoveToParentViewController:self];
    
    [contentView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];  //布局
    
    [contentView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView);
        make.size.equalTo(contentView);
    }];
    
    
    self.contentView = contentView;
    contentView.delegate = self;
    
    
    
    
    
}



@end
