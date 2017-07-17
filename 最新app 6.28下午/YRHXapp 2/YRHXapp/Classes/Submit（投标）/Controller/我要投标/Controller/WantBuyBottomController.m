//
//  WantBuyBottomController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/22.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "WantBuyBottomController.h"
#import "UIColor+ColorChange.h"
#import "Masonry.h"
#import "ProjectDescribeController.h"
#import "BorrowerInfomationController.h"
#import "SubmitInformationController.h"
#import "UILabel+CZAddition.h"

@interface WantBuyBottomController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIView * categaryView;
@property(nonatomic,strong)UIButton * selectedBtn;
@property(nonatomic,weak)UIScrollView * contentView;
@property (nonatomic,weak) UIButton * firstBtn;
@property(nonatomic,weak)UIView * lineView;
@property(nonatomic,strong)UIView * headView;


@end

@implementation WantBuyBottomController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;  //隐藏导航栏
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, -20, KscreenWidth, KscreenHeight - 49);
    
    [self creatHeadView];
    [self creatSmallCategaryView];
    [self creatContentView];
    
}


- (void)creatHeadView
{
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    [self.view addSubview:_headView];
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.view).offset(0);
        make.height.offset(64);
    }];
    
    
    UIButton * leftBtn = [[UIButton alloc]init];
    [_headView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.bottom.offset(-10);
        make.height.with.offset(24);
    }];
    [leftBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnTurnBack) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [UILabel cz_labelWithText:@"车文英2039" fontSize:18 color:[UIColor whiteColor]];
    [_headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headView);
        make.centerY.equalTo(leftBtn);
    }];
}

- (void)leftBtnTurnBack
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)creatSmallCategaryView
{
    //创建中间小的分类view
    UIView * categaryView = [[UIView alloc]init];
    categaryView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:categaryView];
    
    [categaryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.headView.mas_bottom).offset(0);
        make.height.offset(45);
    }];
    
    self.categaryView = categaryView;
    
    NSArray * array = @[@"项目描述",@"借款人资料",@"投标记录"];
    NSMutableArray * btnArrM = [NSMutableArray array];
    
    for (int i =0; i < array.count; i++) {
        UIButton * btn = [[UIButton alloc]init];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"eb413d"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
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
    //布局按钮  1水平放置/垂直放置  2间隔大小  3左间距  4右间距
    [btnArrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];

    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    [self.categaryView addSubview:lineView];

    UIButton * firstBtn = btnArrM[0];
    
    CGFloat pictureRealW = screenBounds.size.width / 3;
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
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;

    UIButton * button = self.categaryView.subviews[page];
    button.selected = YES;
    self.selectedBtn.selected = NO;
    self.selectedBtn = button;
}



//3   添加内容视图view
- (void)creatContentView
{
    UIScrollView * contentView = [[UIScrollView alloc]init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.pagingEnabled = YES;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.categaryView.mas_bottom);
        
    }];
    
    
    ProjectDescribeController * projectVc = [[ProjectDescribeController alloc]init];
    BorrowerInfomationController * borrowVc = [[BorrowerInfomationController alloc]init];
    SubmitInformationController * submitVc = [[SubmitInformationController alloc]init];
    
    [contentView addSubview:projectVc.view];
    [contentView addSubview:borrowVc.view];
    [contentView addSubview:submitVc.view];
    
    [self addChildViewController:projectVc];
    [self addChildViewController:borrowVc];
    [self addChildViewController:submitVc];

    [projectVc didMoveToParentViewController:self];
    [borrowVc didMoveToParentViewController:self];
    [submitVc didMoveToParentViewController:self];
    
    [contentView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [contentView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView);
        make.size.equalTo(contentView);
    }];
    
    
    self.contentView = contentView;
    contentView.delegate = self;
    
}




@end
