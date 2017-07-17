//
//  YRHXWantBuyController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/22.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXWantBuyController.h"
#import "Masonry.h"
#import "WantBuyTopController.h"
#import "WantBuyBottomController.h"
#import "UIColor+ColorChange.h"
#import "YRHXConfirmBuyController.h"

@interface YRHXWantBuyController ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIScrollView * contentView;
@property (nonatomic,weak) UIView * categaryView;
@property (nonatomic,weak) UIView *bottomView;

@end

@implementation YRHXWantBuyController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
  
    UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:@"立即投资" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view).offset(0);
        make.height.offset(45);
    }];
    [btn addTarget:self action:@selector(goThere) forControlEvents:UIControlEventTouchUpInside];

}


- (void)viewDidLoad {
    [super viewDidLoad];
     
    self.navigationController.navigationBarHidden = YES;  //隐藏导航栏
    self.navigationController.navigationBar.translucent = YES;
    [self.view addSubview:_contentView];


    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.offset(45);
    }];

    
    [self creatContentView];
}


- (void)goThere
{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"YRHXConfirmBuyController" bundle:nil];
    YRHXConfirmBuyController * confirmVC = [storyBoard instantiateInitialViewController ];
    [self.navigationController pushViewController:confirmVC animated:YES];
}



- (void)creatContentView
{
    //创建滚动器view
    UIScrollView * contentView = [[UIScrollView alloc]init];
    contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    contentView.pagingEnabled = YES;   //设置分页效果
    
    contentView.showsVerticalScrollIndicator = YES;   //取消滚动条
    
    [self.view addSubview:contentView];    //添加到控制器
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.bottom.offset(-45);
    }];

    WantBuyTopController * projectVc = [[WantBuyTopController alloc]init];
    WantBuyBottomController * creditorVc = [[WantBuyBottomController alloc]init];

    [contentView addSubview:projectVc.view];
    [contentView addSubview:creditorVc.view];
    //建立父子关系
    [self addChildViewController:projectVc];
    [self addChildViewController:creditorVc];
   
    //告诉系统已建立父子关系
    [projectVc didMoveToParentViewController:self];
    [creditorVc didMoveToParentViewController:self];
  
    [contentView.subviews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0 leadSpacing:0 tailSpacing:0];  //布局
    [contentView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.size.equalTo(contentView);
    }];
   
    self.contentView = contentView;
    contentView.delegate = self;
}

@end
