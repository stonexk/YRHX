//
//  NoChoiceVoucherController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/24.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "NoChoiceVoucherController.h"

@interface NoChoiceVoucherController ()

@end

@implementation NoChoiceVoucherController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"选择优惠券";
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,90,30)];
    [rightButton addTarget:self action:@selector(newSelectionProjects)forControlEvents:UIControlEventTouchUpInside];
    
    [rightButton setTitle:@"使用帮助" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;

    
    
}


- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)newSelectionProjects
{
    UIViewController * VC = [[UIViewController alloc]init];
    VC.view.backgroundColor = [UIColor cyanColor];
    
    [self.navigationController pushViewController:VC animated:YES];
}



@end
