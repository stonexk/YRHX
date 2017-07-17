//
//  oneViewController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/24.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "oneViewController.h"

@interface oneViewController ()

@end

@implementation oneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = @"确认投资";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
}
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}






@end
