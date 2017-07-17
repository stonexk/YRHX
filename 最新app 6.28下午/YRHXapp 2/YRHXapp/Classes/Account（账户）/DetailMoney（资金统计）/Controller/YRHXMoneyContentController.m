//
//  YRHXMoneyContentController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/11.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXMoneyContentController.h"
#import "YRHXMoneyMinXiController.h"

@interface YRHXMoneyContentController ()

@end

@implementation YRHXMoneyContentController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(turn)];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor darkGrayColor];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"资金统计";
    

    
    
}

- (void)turn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)jump2MoneyMingxi:(UIButton *)sender
{
    YRHXMoneyMinXiController * mingxiVC = [YRHXMoneyMinXiController new];
    [self.navigationController pushViewController:mingxiVC animated:YES];
}


@end
