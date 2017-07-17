//
//  YRHXNoProjectNoticeController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/25.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXNoProjectNoticeController.h"

@interface YRHXNoProjectNoticeController ()

@end

@implementation YRHXNoProjectNoticeController

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
    self.navigationItem.title = @"新标预告";
}


- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
