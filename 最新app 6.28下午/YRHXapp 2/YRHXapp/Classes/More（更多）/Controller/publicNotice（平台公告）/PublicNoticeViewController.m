//
//  PublicNoticeViewController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/24.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "PublicNoticeViewController.h"
@interface PublicNoticeViewController()

@property(nonatomic,strong)UIWebView * webView;

@end

@implementation PublicNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.yrhx.com/X01"]];
    [self.view addSubview: _webView];
    [_webView loadRequest:request];
    _webView.opaque = NO;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scalesPageToFit = YES;
    
    
}


@end
