//
//  YRHXNavigationController.m
//  YRHX
//
//  Created by 詹稳 on 17/4/18.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXNavigationController.h"
#import "UIColor+ColorChange.h"

@interface YRHXNavigationController ()

@end

@implementation YRHXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //显示导航条的黑线
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];

    [self.navigationBar setShadowImage:[UIImage new]];

//    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"eb413d"];
    self.navigationBar.barTintColor = [UIColor whiteColor];

    self.navigationBar.translucent = NO;

    // 设置导航条内容主题色
    self.navigationBar.tintColor = [UIColor blackColor];
    
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    
//如果要设置内容全找itme
//如果要改的是颜色及文字属性相关的找bar
//        self.navigationItem.titleView = [[UILabel alloc] init];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    //白底黑字
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

//设置状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


//重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.accessibilityElementsHidden = YES;  //点击进去后隐藏标签控制器
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
    
}
@end
