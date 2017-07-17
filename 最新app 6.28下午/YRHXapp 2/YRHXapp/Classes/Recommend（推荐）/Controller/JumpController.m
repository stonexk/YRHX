//
//  JumpController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "JumpController.h"

@interface JumpController ()<UIWebViewDelegate>

@end

@implementation JumpController

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
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;


    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];

    [self.view addSubview:webView];
    
    webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"http://m.dianping.com/tuan/deal/5501525"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

// 这个代理方法里面去实现JS注入
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    // 用于拼接多个JS代码
    NSMutableString *JSStringM = [NSMutableString string];
    
    // 拼接移除导航的JS代码
    [JSStringM appendString:@"var headerTag = document.getElementsByTagName('header')[0];headerTag.parentNode.removeChild(headerTag);"];
    
    // 拼接移除橙色按钮的JS代码
    [JSStringM appendString:@"var footerBtnTag = document.getElementsByClassName('footer-btn-fix')[0];footerBtnTag.parentNode.removeChild(footerBtnTag);"];
    
    // 拼接移除网页底部的JS代码
    [JSStringM appendString:@"var footerTag = document.getElementsByClassName('footer')[0];footerTag.parentNode.removeChild(footerTag);"];
    
    // 拼接标签添加点击事件的JS代码
    [JSStringM appendString:@"var imgTag = document.getElementsByTagName('figure')[0].children[0];imgTag.onclick = function imgTagClick() {window.location.href = 'hm://www.yaowoya.com'};"];
    
    // webView 提供了JI注入的方法的
    // 参数 : 就是要注入的JS字符串(JS代码)
    [webView stringByEvaluatingJavaScriptFromString:JSStringM];
}

/*
 再JS跳转到OC
 这个方法中,可以拦截到网页中所有的网络请求对应的URL
 返回值 : 如果返回YES,表示可以加载数据;反之,不可以加载数据
 参数 : request (通过请求对象,可以拿到请求的URL)
 */
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//
//    // 拦截到的请求的地址
//    NSString *urlStr = request.URL.absoluteString;
//    NSLog(@"%@",urlStr);
//
//    // 判断当前点击的标签是不是图片标签
//    if ([urlStr isEqualToString:@"hm://www.yaowoya.com"]) {
//        NSLog(@"点击了imgTag");
//
//        // 跳转控制器
//        TestTableViewController *testVC = [[TestTableViewController alloc] init];
//        [self.navigationController pushViewController:testVC animated:YES];
//
//        return NO;
//    }
//
//    return YES;
//}

@end
