//
//  InviteFriendsControllerViewController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/15.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "InviteFriendsControllerViewController.h"

@interface InviteFriendsControllerViewController ()

@property(nonatomic,strong)UIWebView * webView;
@end

@implementation InviteFriendsControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://topic.yrhx.com/zt/2016/20160902/"]];
    [self.view addSubview: _webView];
    [_webView loadRequest:request];
    _webView.opaque = NO;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scalesPageToFit = YES;


    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    backButton.frame = CGRectMake(KscreenWidth - 40, 20, 30, 30);
    backButton.backgroundColor = [UIColor whiteColor];
    [self.webView addSubview:backButton];
    [backButton addTarget:self action:@selector(turnBackController) forControlEvents:UIControlEventTouchUpInside];

}

- (void)turnBackController
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
