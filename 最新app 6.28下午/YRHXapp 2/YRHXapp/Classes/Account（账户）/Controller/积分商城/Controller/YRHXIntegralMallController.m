//
//  YRHXIntegralMallController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/1.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXIntegralMallController.h"
#import "YRHXHomeScroollView.h"
#import "UIColor+ColorChange.h"
#import "Masonry.h"
#import "YRHXCircleView.h"

//#import "UILabel+CZAddition.h"
//#import "YRHXIntegralCollectionController.h"

@interface YRHXIntegralMallController ()<UIScrollViewDelegate>

@property(nonatomic,weak)YRHXHomeScroollView * homeScrollView;

@property(nonatomic,strong)YRHXCircleView * cycleView;
@property(nonatomic,weak)UIView * headView;
@property(nonatomic,weak)UIView * topView;
@end

@implementation YRHXIntegralMallController

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
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"积分商城";

    
    YRHXHomeScroollView * homeScrollView = [[YRHXHomeScroollView alloc]initWithFrame:self.view.bounds];
    homeScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    homeScrollView.delegate = self;
    
    self.homeScrollView = homeScrollView;
    homeScrollView.homeViewController = self;
    [self.view addSubview:homeScrollView];
    
 
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
