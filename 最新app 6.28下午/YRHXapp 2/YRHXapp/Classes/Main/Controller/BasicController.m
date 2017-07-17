//
//  BasicController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/24.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "BasicController.h"
#import "UIColor+ColorChange.h"
#import "Masonry.h"

@interface BasicController ()

@end

@implementation BasicController


- (void)viewWillAppear:(BOOL)animated
{
    //显示导航条的黑线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];

    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;

    // 设置导航条内容主题色
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    
// [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

   //保证返回之前de界面导航条颜色不变
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"eb413d"];
    //设置状态栏字体颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor whiteColor]};
}

//
//- (void)viewDidAppear:(BOOL)animated
//{
//    //白底黑字
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
//}



@end
