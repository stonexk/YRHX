//
//  YRHXRecommendController.m
//  YRHX
//
//  Created by 詹稳 on 17/4/18.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXRecommendController.h"
#import "YRHXChartViewCell.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
#import "UIColor+ColorChange.h"
#import "LPImageContentView.h"
#import "LPView.h"
#import "LBCircleView.h"
#import "YRHXStartBuyController.h"
#import "LJInstrumentView.h"
#import "YRHXCircleView.h"
#import "InviteFriendsControllerViewController.h"

@interface YRHXRecommendController ()

@property (nonatomic,strong)LBCircleView * circleView;

@property (nonatomic,strong)YRHXCircleView *custom ;

@property (nonatomic, strong) NSMutableArray *titlesArray;


@end

@implementation YRHXRecommendController
//全局变量
UITableViewCell * picViewCell;
YRHXChartViewCell * chartViewCell;
CGFloat pictureRealH;
UIView * midView;
UIView * chartView;
UILabel * priceLabel;



//设置状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏透明度
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = nil;

   
    [self setup];

 }

#pragma 点击屏幕。加载进度图
//进度图
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.circleView setProgress:(arc4random()%100/100.0) animated:YES];
//}


- (void)setup
{
    // 2.imageView"配图"
    UIImageView *pictureView = [[UIImageView alloc] init];
    pictureView.image = [UIImage imageNamed:@"背景"];
    [self.view addSubview:pictureView];
    
    // 计算宽高比   320   215
    // 获取图片实际的宽高
    //        CGFloat imageW = pictureView.image.size.width;
    //    CGFloat imageW = 320;
    //    CGFloat imageH = 255;
    
    CGFloat imageW = 375;
    CGFloat imageH = 252.5;
    
    // 图片显示出来时的真实宽
    CGFloat pictureRealW = screenBounds.size.width;
    //     计算按钮比率缩放后的高 == 图片真实的高 * 图片显示的宽 / 图片真实的宽
    pictureRealH = imageH * pictureRealW / imageW;
    
    [pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).offset(0);
        make.height.offset(pictureRealH);
        
    }];
    
    
    
    midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(pictureView.mas_bottom).offset(0);
        make.height.offset(60);
    }];
    
    
    priceLabel = [UILabel cz_labelWithText:@"累计元" fontSize:14 color:nil];
    priceLabel.textColor = [UIColor grayColor];
    [midView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(midView).offset(0);
        make.left.equalTo(midView).offset(17.5);
        make.width.offset(180);
    }];
    
    
    UIButton * btn = [[UIButton alloc] init];
    [btn sizeToFit];
    [btn setImage:[UIImage imageNamed:@"邀請"] forState:UIControlStateNormal];
    [midView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(midView).offset(-15);
        make.top.equalTo(midView).offset(15);
        make.right.equalTo(midView).offset(-20);
        make.width.offset(83);
    }];
    
    
    [btn addTarget:self action:@selector(inviteFriendsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#b1b1b1"];
    [midView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.mas_left).offset(-15);
        make.centerY.equalTo(btn);
        make.height.offset(25);
        make.width.offset(1);
    }];
    
    
    
    
    [self setupChartView];
    
}

-(void)inviteFriendsBtnClick
{
    InviteFriendsControllerViewController * view = [[InviteFriendsControllerViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)setupChartView
{
    
    chartView = [[UIView alloc]init];
    chartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(midView.mas_bottom).offset(15);
        make.bottom.equalTo(self.view).offset(-15);
    }];
    
    
    UIButton * purchaseBtn = [[UIButton alloc]init];
    purchaseBtn.clipsToBounds = YES;
    purchaseBtn.layer.cornerRadius=10;
    [purchaseBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    [chartView addSubview:purchaseBtn];
    purchaseBtn.backgroundColor = [UIColor colorWithHexString:@"1294f6"];
    
    [purchaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chartView).offset(15);
        make.bottom.right.equalTo(chartView).offset(-15);
        make.height.offset(47.5);
    }];
    
    
    
    //监听事件
    [purchaseBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //三个文字view
    UIView * threeView = [[UIView alloc]init];
    [chartView addSubview:threeView];
    [threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.equalTo(purchaseBtn.mas_top).offset(0);
        //        make.height.offset(60);    //显示约束太多
    }];
    
    UILabel * midLabel = [[UILabel alloc]init];
    midLabel.text = @"100起投";
    midLabel.backgroundColor = [UIColor whiteColor];
    midLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    midLabel.font = [UIFont systemFontOfSize: 14];
    [threeView addSubview:midLabel];
    midLabel.textAlignment = NSTextAlignmentLeft;
    [midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(threeView).offset(0);
        make.width.offset(65);
        make.centerX.equalTo(threeView);
    }];
    
    UIView * lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#b1b1b1"];
    [threeView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(midLabel.mas_left).offset(-6);
        make.top.equalTo(threeView).offset(20);
        make.bottom.equalTo(threeView).offset(-20);
        make.width.offset(1);
    }];
    
    UILabel * leftLabel = [[UILabel alloc]init];
    leftLabel.text = @"1个月";
    leftLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    leftLabel.font = [UIFont systemFontOfSize: 14];
    [threeView addSubview:leftLabel];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(threeView).offset(0);
        make.width.offset(50);
        make.right.equalTo(lineView1.mas_left).offset(-6);
    }];
    
    UIView * lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#b1b1b1"];
    [threeView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(midLabel.mas_right).offset(6);
        make.top.equalTo(threeView).offset(20);
        make.bottom.equalTo(threeView).offset(-20);
        make.width.offset(1);
    }];
    
    UILabel * rightLabel = [[UILabel alloc]init];
    rightLabel.text = @"限额10000";
    rightLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    rightLabel.font = [UIFont systemFontOfSize: 14];
    [threeView addSubview:rightLabel];
    rightLabel.textAlignment = NSTextAlignmentLeft;
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(threeView).offset(0);
        make.width.offset(80);
        make.left.equalTo(lineView2.mas_right).offset(6);
    }];
    


    
//    CGRectMake(30,pictureRealH + 72.5, 330, KscreenHeight - pictureRealH - 60 - 12.5 - 60)
    LBCircleView * circleView = [[LBCircleView alloc] initWithFrame:CGRectMake((KscreenWidth-280)/2,pictureRealH + 120, 280,160)];
    _circleView = circleView;
    [chartView addSubview:circleView];
    
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chartView.mas_left).offset((KscreenWidth-280)/2);
        make.right.equalTo(chartView.mas_right).offset(-(KscreenWidth-280)/2);
        make.width.offset(280);
        make.height.offset(160);
        make.top.equalTo(chartView.mas_top).offset(20);
    }];

    circleView.percentColor = [UIColor colorWithRed:76.0/255 green:15.0/255 blue:77.0/255 alpha:1.0];
    
    [circleView setProgress:0.12 animated:YES];
    
    
    
//
//    ProgressView * progressView = [[ProgressView alloc]initWithFrame:CGRectMake((KscreenWidth-260)/2,pictureRealH + 100, 260,200)];
//    progressView.backgroundColor = [UIColor lightGrayColor];
////    _progressView = progressView;
//    [self.view addSubview:progressView];
//    
//    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.right.top.equalTo(chartView).offset(0);
////        make.bottom.equalTo(threeView.mas_top).offset(0);
//            make.left.equalTo(chartView.mas_left).offset((KscreenWidth-260)/2);
//            make.right.equalTo(chartView.mas_right).offset(-(KscreenWidth-260)/2);
//            make.width.offset(260);
//            make.height.offset(140);
//            make.top.equalTo(chartView);
//    }];
//    
//    progressView.arcFinishColor = [UIColor blueColor];
//    progressView.arcUnfinishColor = [UIColor yellowColor];
//    progressView.arcBackColor = [UIColor redColor];
//    
//    progressView.percent = 0.88;
//    
//    
    
 
    UILabel * progressLabel = [UILabel cz_labelWithText:@"12.0" fontSize:36 color:[UIColor colorWithHexString:@"#fe5d32"]];
    [chartView addSubview:progressLabel];
    [progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(chartView);
        make.centerY.equalTo(chartView);
    }];

    UILabel * haoLabel = [UILabel cz_labelWithText:@"%" fontSize:16 color:[UIColor colorWithHexString:@"#fe5d32"]];
    [chartView addSubview:haoLabel];
    [haoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(progressLabel.mas_right).offset(15);
        make.centerY.equalTo(progressLabel);
    }];
    
    UILabel * jiaPercentLabel = [UILabel cz_labelWithText:@"+00" fontSize:17 color:[UIColor colorWithHexString:@"#fe5d32"]];
    [chartView addSubview:jiaPercentLabel];
    [jiaPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(haoLabel);
        make.bottom.equalTo(haoLabel.mas_top).offset(-7);
    }];
    
    UILabel * nianPercentLabel = [UILabel cz_labelWithText:@"年化率" fontSize:14 color:[UIColor colorWithHexString:@"#666666"]];
    [chartView addSubview:nianPercentLabel];
    [nianPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(chartView);
        make.bottom.equalTo(progressLabel.mas_top).offset(-23);
    }];
    
    
    
    UIImageView * picImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xinshou"]];
    [chartView addSubview:picImg];
    [picImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chartView).offset(20);
        make.right.equalTo(chartView).offset(-20);
        make.width.height.offset(61);
    }];
    
}


- (void)buttonClick:(UIButton *)button
{
    YRHXStartBuyController * buyVC = [[YRHXStartBuyController alloc]init];
    
    [self.navigationController pushViewController:buyVC animated:YES];
}






@end
