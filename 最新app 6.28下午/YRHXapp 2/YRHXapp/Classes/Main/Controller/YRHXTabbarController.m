//
//  YRHXTabbarController.m
//  YRHX
//
//  Created by 詹稳 on 17/4/18.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXTabbarController.h"
#import "YRHXNavigationController.h"
#import "UIColor+ColorChange.h"

@interface YRHXTabbarController ()

@end

@implementation YRHXTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIViewController *vc1 =  [self makeChildViewController:@"YRHXHomeViewController" andTabBarTitle:@"首页" andTabBarImage:@"首页"];
    
    UIViewController *vc2 =   [self makeChildViewController:@"YRHXSubmitViewController" andTabBarTitle:@"投标" andTabBarImage:@"投标"];
    
    UIViewController *vc3 =  [self makeChildViewController:@"YRHXAccountController" andTabBarTitle:@"账户" andTabBarImage:@"账户"];
    
    UIViewController *vc4 =  [self makeChildViewController:@"YRHXMoreViewController" andTabBarTitle:@"更多" andTabBarImage:@"更多"];

    self.viewControllers = @[vc1, vc2, vc3, vc4];

    self.tabBar.tintColor = [UIColor colorWithHexString:@"#ff5858"];
    
    // 关闭标签栏的半透明效果
#pragma 控制器的view就不会到底屏幕最底部了,而是到了标签栏的上面
    self.tabBar.translucent = NO;
    
    // 默认让它显示第2个界面
    //    self.selectedIndex = 2;

}


// 返回一个设置好标签栏内容的导航控制器
- (UIViewController *)makeChildViewController:(NSString *)className andTabBarTitle:(NSString *)title andTabBarImage:(NSString *)imageName {

    
    Class class = NSClassFromString(className);

    UITableViewController *vc = [[class alloc] init];
    
    vc.title = title;

    vc.tabBarItem.image = [UIImage imageNamed:imageName];

    NSString *selImageName = [imageName stringByAppendingString:@"2"];
    
    //设置标签栏上选中状态的图片,设置它不渲染
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //    vc.view.backgroundColor =  [UIColor whiteColor];
    

    YRHXNavigationController * nav = [[YRHXNavigationController alloc]initWithRootViewController:vc];
    
    return nav;
}







@end
