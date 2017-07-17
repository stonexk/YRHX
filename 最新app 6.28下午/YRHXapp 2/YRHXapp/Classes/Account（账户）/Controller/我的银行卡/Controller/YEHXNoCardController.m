//
//  YEHXNoCardController.m
//  YRHXapp
//
//  Created by 詹稳 on 17/5/7.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YEHXNoCardController.h"
#import "AddBankCardController.h"

@interface YEHXNoCardController ()

@end

@implementation YEHXNoCardController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //显示导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 清空阴影图片
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    // 取消半透明效果
    self.navigationController.navigationBar.translucent = NO;
    
    
    self.navigationItem.title = @"我的银行卡";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,30)];
    [rightButton setTitle:@"添加" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(addBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem= rightItem;


}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addBtnClick
{
    AddBankCardController * addVC = [AddBankCardController new];
    [self.navigationController pushViewController:addVC animated:YES];

}





@end
