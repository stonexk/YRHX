//
//  oViewController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/28.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "oViewController.h"
#import "YRHXTabbarController.h"

@interface oViewController ()

@end

@implementation oViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    YRHXTabbarController * vc = [YRHXTabbarController new];
    [self presentViewController:vc animated:NO completion:nil];
}

@end
