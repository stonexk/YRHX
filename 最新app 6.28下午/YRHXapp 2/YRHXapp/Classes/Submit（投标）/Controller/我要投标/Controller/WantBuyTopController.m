//
//  WantBuyTopController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/22.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "WantBuyTopController.h"
#import "UIColor+ColorChange.h"
#import "UILabel+CZAddition.h"
#import "Masonry.h"
#import "YRHXConfirmBuyController.h"

@interface WantBuyTopController ()

@property (nonatomic,strong) UIView * middleView;
@property (nonatomic,strong) UIButton * moveBtn;
@end

@implementation WantBuyTopController

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

    self.navigationController.navigationBarHidden = YES;  //隐藏导航栏
    self.navigationController.navigationBar.translucent = YES;
    self.view.frame = CGRectMake(0, -20, KscreenWidth, KscreenHeight - 49);
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setupTopUI];
    [self setupMiddleUI];
    [self setupBottomUI];


    
}


//- (void)goThere
//{
//    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"YRHXConfirmBuyController" bundle:nil];
//    YRHXConfirmBuyController * confirmVC = [storyBoard instantiateInitialViewController ];
//    [self.navigationController pushViewController:confirmVC animated:YES];
//}


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


- (void)turnBackm
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //设置状态栏字体颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupTopUI
{
    UIView * picView = [[UIView alloc]initWithFrame:CGRectMake(0,0, KscreenWidth, 280*KscreenWidth/375)];
    picView.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    [self.view addSubview:picView];
    
    UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(17.5, 30, 24, 24)];
    [backBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    [picView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(turnBackm) forControlEvents:UIControlEventTouchUpInside];
    
    

    UIView * oneView = [[UIView alloc]init];
    [picView addSubview:oneView];
    CGFloat pictureRealH3 = 30 * KscreenWidth / 375;
    [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backBtn.mas_bottom).offset(50);
        make.left.right.offset(0);
        make.height.offset(pictureRealH3);
    }];
    
    UILabel * projectNameLabel = [UILabel cz_labelWithText:@"车文英392040" fontSize:20 color:[UIColor whiteColor]];
    [projectNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    projectNameLabel.textAlignment = NSTextAlignmentCenter;
    [picView addSubview:projectNameLabel];
    [projectNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backBtn);
        make.centerX.equalTo(oneView);
    }];
    

    
    UILabel * submitNumLabel = [UILabel cz_labelWithText:@"15.0" fontSize:33 color:[UIColor whiteColor]];
    [oneView addSubview:submitNumLabel];
    submitNumLabel.textAlignment = NSTextAlignmentCenter;
    [submitNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(oneView);
        make.bottom.equalTo(oneView.mas_bottom).offset(-4);
    }];
    
    UILabel * percentLabel = [UILabel cz_labelWithText:@"%" fontSize:15 color:[UIColor whiteColor]];
    [oneView addSubview:percentLabel];
    [percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(submitNumLabel.mas_right).offset(0);
        make.bottom.equalTo(submitNumLabel.mas_bottom).offset(-5);
    }];
    
    UILabel * predictLabel = [UILabel cz_labelWithText:@"预计年化率" fontSize:15 color:[UIColor whiteColor]];
    predictLabel.textAlignment = NSTextAlignmentCenter;
    [picView addSubview:predictLabel];
    [predictLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(submitNumLabel);
        make.bottom.equalTo(submitNumLabel.mas_top).offset(-5);
    }];
    
    UIView * twoView = [[UIView alloc]init];
    [picView addSubview:twoView];
    CGFloat pictureRealH4 = 40 * KscreenWidth / 375;
    [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneView.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.height.offset(pictureRealH4);
    }];
    
    
    UIImageView * midSmallImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"加奖励边框"]];
    [twoView addSubview:midSmallImg];
    [midSmallImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(picView);
        make.top.equalTo(twoView.mas_top).offset(0);
        make.height.offset(22);
        make.width.offset(95);
    }];
    
    UILabel * awardLabel = [UILabel cz_labelWithText:@"加奖励1.5%" fontSize:12 color:[UIColor whiteColor]];
    awardLabel.textAlignment = NSTextAlignmentCenter;
    [midSmallImg addSubview:awardLabel];
    [awardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
    
    
    
    UIView * thirdView = [[UIView alloc]init];
    [picView addSubview:thirdView];
    CGFloat pictureRealH5 = 25 * KscreenWidth / 375;
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(twoView.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.height.offset(pictureRealH5);
    }];
    
    
    //三个文字view
    UIView * threeView = [[UIView alloc]init];
    [thirdView addSubview:threeView];
    [threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(thirdView);
        make.edges.offset(0);
    }];
    
    UILabel * midLabel = [UILabel cz_labelWithText:@"期限" fontSize:14 color:[UIColor colorWithWhite:1 alpha:0.7]];
    midLabel.textAlignment = NSTextAlignmentCenter;
    [threeView addSubview:midLabel];
    [midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(threeView).offset(0);
        make.width.offset(100);
        make.centerX.equalTo(threeView);
    }];
    
    UILabel * monthLabel = [UILabel cz_labelWithText:@"6个月" fontSize:16 color:[UIColor whiteColor]];
    monthLabel.textAlignment = NSTextAlignmentCenter;
    [picView addSubview:monthLabel];
    [monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midLabel.mas_bottom).offset(5);
        make.centerX.equalTo(midLabel);
    }];
    
    
    UILabel * leftLabel = [UILabel cz_labelWithText:@"剩余金额" fontSize:14 color:[UIColor colorWithWhite:1 alpha:0.7]];
    [threeView addSubview:leftLabel];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(threeView).offset(0);
        make.left.offset(50);
    }];
    
    UILabel * moneyLabel = [UILabel cz_labelWithText:@"--元" fontSize:16 color:[UIColor whiteColor]];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [picView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLabel.mas_bottom).offset(5);
        make.centerX.equalTo(leftLabel);
    }];
    
    
    UILabel * rightLabel = [UILabel cz_labelWithText:@"还款方式" fontSize:14 color:[UIColor colorWithWhite:1 alpha:0.7]];
    [threeView addSubview:rightLabel];
    rightLabel.textAlignment = NSTextAlignmentRight;
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(threeView).offset(0);
        make.right.offset(-50);
    }];
    
    UILabel * typeLabel = [UILabel cz_labelWithText:@"先本后息" fontSize:16 color:[UIColor whiteColor]];
    [picView addSubview:typeLabel];
    typeLabel.textAlignment = NSTextAlignmentRight;
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightLabel.mas_bottom).offset(5);
        make.centerX.equalTo(rightLabel);
    }];
    
    UIProgressView * progressView = [[UIProgressView alloc]init];
    progressView.progressTintColor = [UIColor colorWithRed:202/255.0 green:45/255.0 blue:45/255.0 alpha:1];
    progressView.trackTintColor = [UIColor clearColor];
    [progressView setProgressViewStyle:UIProgressViewStyleDefault];
    progressView.progress = 1;
    [picView addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(picView).offset(0);
        make.bottom.equalTo(picView.mas_bottom).offset(0);
        make.height.offset(3);
    }];
    float num = 0.66;
    [progressView setProgress:num animated:YES];
    CGFloat progressWidth = KscreenWidth * num;
    
    //滚动的按钮（放图片和文字）
    self.moveBtn = [[UIButton alloc]initWithFrame:CGRectMake(progressWidth - 40, 250*KscreenWidth/375, 76, 21)];
    if (progressWidth- 40 +80 > KscreenWidth) {
        self.moveBtn.frame = CGRectMake(KscreenWidth-76, 250*KscreenWidth/375, 76, 22);
    }
    self.moveBtn.userInteractionEnabled = NO;
    [picView addSubview:_moveBtn];
    [_moveBtn setBackgroundImage:[UIImage imageNamed:@"进度标签"] forState:UIControlStateNormal];
//    [_moveBtn setImage:[UIImage imageNamed:@"进度标签"] forState:UIControlStateNormal];
//    [_moveBtn setTitle:@"已投资12%" forState:UIControlStateNormal];
//    [_moveBtn setTintColor:[UIColor redColor]];
//    _moveBtn.titleLabel.text = @"已投资12%";
//    _moveBtn.titleLabel.textColor = [UIColor redColor];
//    _moveBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    UILabel * moveLabel = [UILabel cz_labelWithText:@"已投资12%" fontSize:12 color:[UIColor redColor]];
    moveLabel.textAlignment = NSTextAlignmentCenter;
    [_moveBtn addSubview:moveLabel];
    [moveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_moveBtn).offset(0);
    }];
    
}



- (void)setupMiddleUI
{
    _middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 280*KscreenWidth/375 , KscreenWidth, 120*KscreenWidth/375)];
    [self.view addSubview:_middleView];
    _middleView.backgroundColor = [UIColor whiteColor];
    
    //剩余时间
    UILabel * shengyuLabel = [UILabel cz_labelWithText:@"剩余时间" fontSize:15 color:[UIColor darkGrayColor]];
    [_middleView addSubview:shengyuLabel];
    [shengyuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.equalTo(_middleView);
        make.height.offset(25*KscreenWidth/375);
    }];
    UILabel * timeLabel = [UILabel cz_labelWithText:@"0天0小时0分0秒" fontSize:15 color:[UIColor blackColor]];
    [_middleView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shengyuLabel);
        make.left.equalTo(shengyuLabel.mas_right).offset(10);
        make.height.offset(25*KscreenWidth/375);
    }];
    
    
    //借款金额
    UILabel * borrowLabel = [UILabel cz_labelWithText:@"借款金额" fontSize:15 color:[UIColor darkGrayColor]];
    [_middleView addSubview:borrowLabel];
    [borrowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.bottom.equalTo(shengyuLabel.mas_top);
        make.height.offset(40*KscreenWidth/375);
    }];
    UILabel * moneyLabel = [UILabel cz_labelWithText:@"0000.00元" fontSize:15 color:[UIColor blackColor]];
    [_middleView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(borrowLabel);
        make.left.equalTo(borrowLabel.mas_right).offset(10);
        make.height.offset(40*KscreenWidth/375);
    }];

    
    //借款编号
    UILabel * oweLabel = [UILabel cz_labelWithText:@"借款编号" fontSize:15 color:[UIColor darkGrayColor]];
    [_middleView addSubview:oweLabel];
    [oweLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(shengyuLabel.mas_bottom);
        make.height.offset(40*KscreenWidth/375);
    }];
    UILabel * numberLabel = [UILabel cz_labelWithText:@"3627418" fontSize:15 color:[UIColor blackColor]];
    [_middleView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(oweLabel);
        make.left.equalTo(oweLabel.mas_right).offset(10);
        make.height.offset(40*KscreenWidth/375);
    }];
    
}


- (void)setupBottomUI
{
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(_middleView.mas_bottom).offset(10);
        make.height.offset(120*KscreenWidth/375);
    }];
   
    UILabel * introduceLabel = [UILabel cz_labelWithText:@"项目介绍" fontSize:16 color:[UIColor blackColor]];
    [introduceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [bottomView addSubview:introduceLabel];
    [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(17.5);
        make.left.offset(30);
    }];
    
    UILabel * redLine = [[UILabel alloc]init];
    redLine.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    [bottomView addSubview:redLine];
    [redLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20);
        make.width.offset(5);
        make.left.top.offset(15);
        make.centerY.equalTo(introduceLabel);
    }];
    
    UILabel * inforLabel = [UILabel cz_labelWithText:@"借款人已婚，现年27岁，户籍所在地为保山市隆阳区，现居住于楚雄市.借款人现为某建材店员工开发大赛哦啊如果你懂激发。" fontSize:15 color:[UIColor darkGrayColor]];
    [bottomView addSubview:inforLabel];
    [inforLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(introduceLabel.mas_bottom).offset(8);
        make.left.offset(15);
        make.right.offset(-17.5);
        make.bottom.offset(-30);
    }];

    //底部箭头图片
    UIImageView * jiantouImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"更多"]];
    [bottomView addSubview:jiantouImg];
    [jiantouImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView);
        make.width.height.offset(24);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-3);
    }];
    
    
    UILabel * huadongLabel = [UILabel cz_labelWithText:@"向上滑动，查看更多详情" fontSize:13 color:[UIColor darkGrayColor]];
    [self.view addSubview:huadongLabel];
    [huadongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
    }];
    
    UILabel * line1 = [[UILabel alloc]init];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(huadongLabel);
        make.left.offset(0);
        make.right.equalTo(huadongLabel.mas_left).offset(-5);
        make.height.offset(1);
    }];
    
    UILabel * line2 = [[UILabel alloc]init];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(huadongLabel);
        make.right.offset(0);
        make.left.equalTo(huadongLabel.mas_right).offset(5);
        make.height.offset(1);
    }];
  
}




@end
