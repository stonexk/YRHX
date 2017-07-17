//
//  YRHXAccountController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/25.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXAccountController.h"
#import "YRHXAccountFlowLayout.h"
#import "AccountOptionCell.h"
#import "NSArray+CZAddition.h"
#import "AccountOptionModel.h"
#import "Masonry.h"
#import "YRHXLoginViewController.h"
#import "UILabel+CZAddition.h"
#import "YRHXTopUpController.h"
#import "YRHXWithDrawCashController.h"
#import "YRHXMyInvestController.h"
#import "YRHXCreditorTransferController.h"
#import "YRHXMoneyContentController.h"
#import "YRHXMoneyMinXiController.h"
#import "YRHXMyVoucherController.h"
#import "YRHXMemberCenterController.h"
#import "YRHXSignatureController.h"
#import "YRHXScoresMallController.h"
#import "YRHXPlatformDataController.h"
#import "AutoSubmitController.h"
#import "NoUseController.h"

@interface YRHXAccountController ()

@property (nonatomic, strong) NSArray * optionsArrayData;
@property (nonatomic, strong) UICollectionViewCell *cell;

@end

static NSString * reuseID = @"reuseID";
static NSString * cellID = @"CellID";
@implementation YRHXAccountController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (instancetype)init {
    // 创建自定义布局
    YRHXAccountFlowLayout * flowLayout = [[YRHXAccountFlowLayout alloc] init];
    return [super initWithCollectionViewLayout:flowLayout];
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    //KAccountHeight
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.collectionView.frame = CGRectMake(0, -20, KscreenWidth, KscreenHeight + 20);
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = nil;
    
    //注册机制
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseID];
    UINib *optionCellNib = [UINib nibWithNibName:@"AccountOptionCell" bundle:nil];
    [self.collectionView registerNib:optionCellNib forCellWithReuseIdentifier:cellID];
    
    //加载数据
    self.optionsArrayData = [self loadOptionsData];
}

//数据源方法======================
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //每个collectionView的size
    if (indexPath.section == 0) {
        return CGSizeMake(KscreenWidth, KOptionHeight);
    }
    
    CGFloat collectionViewW = collectionView.bounds.size.width;
    //(KscreenHeight + 20 - KOptionHeight-15)/3
    return CGSizeMake((collectionViewW - 2 / [UIScreen mainScreen].scale)/3,(KscreenHeight - 49 - 12 - KOptionHeight) / 3);
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0)
    {
        _cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
  
        [self setBackImageView];
        
        return _cell;
    }

    AccountOptionCell * optionCell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    optionCell.backgroundColor = [UIColor whiteColor];
    optionCell.optionModel = self.optionsArrayData[indexPath.item];
    
    return optionCell;
}


//设置上方背景图片
- (void)setBackImageView
{
    //背景图
    UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景"]];
    headerView.userInteractionEnabled = YES;
    CGFloat viewRealH = 285 * KscreenWidth / 375;
    headerView.frame = CGRectMake(0, 0, KscreenWidth, viewRealH);
    [_cell addSubview:headerView];
    
    
    UIButton * personBtn = [[UIButton alloc]init];
    [personBtn setImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
    [headerView addSubview:personBtn];
    [personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.top.offset(30);
        make.height.width.offset(55);
    }];
    [personBtn addTarget:self action:@selector(personButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * memberBtn = [[UIButton alloc]init];
    [memberBtn setBackgroundColor:[UIColor whiteColor]];
    [headerView addSubview:memberBtn];
    [memberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personBtn.mas_right).offset(10);
        make.top.offset(30);
        make.height.width.offset(34);
    }];
    [memberBtn addTarget:self action:@selector(memberButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UILabel * titleLabel = [UILabel cz_labelWithText:@"账户" fontSize:18 color:[UIColor whiteColor]];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(personBtn);
        make.centerX.equalTo(headerView);
    }];
    
    //平台公告按钮
    UIButton * noticeButton = [[UIButton alloc]init];
    [noticeButton setImage:[UIImage imageNamed:@"资讯"] forState:UIControlStateNormal];
    [headerView addSubview:noticeButton];
    [noticeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-17.5);
        make.centerY.equalTo(personBtn);
        make.height.width.offset(34);
    }];
    [noticeButton addTarget:self action:@selector(noticeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //总资产进去后 是资金统计界面
    UIButton * backgroundButton = [[UIButton alloc]init];
    [headerView addSubview:backgroundButton];
    [backgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.left.right.offset(0);
         make.bottom.offset(0);
    }];
    [backgroundButton addTarget:self action:@selector(backgroundButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * totalAssetLabel = [UILabel cz_labelWithText:@"总资产" fontSize:14 color:[UIColor colorWithWhite:1 alpha:0.7]];
    CGFloat totalAssetLabelH = 30 * KscreenWidth / 375;
    [backgroundButton addSubview:totalAssetLabel];
    [totalAssetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backgroundButton);
        make.top.equalTo(backgroundButton.mas_top).offset(totalAssetLabelH);
    }];
    
    UIImageView * arrowsImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"形状1"]];
    [backgroundButton addSubview:arrowsImg];
    [arrowsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totalAssetLabel.mas_right).offset(3);
        make.centerY.equalTo(totalAssetLabel);
        make.width.offset(7);
        make.height.offset(11);
    }];
    
    UILabel * totalMoneyLabel = [UILabel cz_labelWithText:@"2600.00" fontSize:34 color:[UIColor whiteColor]];
    [backgroundButton addSubview:totalMoneyLabel];
    CGFloat totalMoneyLabelH = 10 * KscreenWidth / 375;
    [totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backgroundButton);
        make.top.equalTo(totalAssetLabel.mas_bottom).offset(totalMoneyLabelH);
    }];

    UILabel * yuanLabel = [UILabel cz_labelWithText:@"元" fontSize:16 color:[UIColor whiteColor]];
    [backgroundButton addSubview:yuanLabel];
    [yuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totalMoneyLabel.mas_right).offset(2);
        make.bottom.equalTo(totalMoneyLabel.mas_bottom).offset(-5);
    }];
    
    
    
    
    UIView * thirdView = [[UIView alloc]init];
    [backgroundButton addSubview:thirdView];
    CGFloat pictureRealH5 = 25 * KscreenWidth / 375;
    CGFloat thirdViewH = 30 * KscreenWidth / 375;
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalMoneyLabel.mas_bottom).offset(thirdViewH);
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
    
    UILabel * midLabel = [UILabel cz_labelWithText:@"待收本金" fontSize:14 color:[UIColor colorWithWhite:1 alpha:0.7]];
    midLabel.textAlignment = NSTextAlignmentCenter;
    [threeView addSubview:midLabel];
    [midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(threeView).offset(0);
        make.width.offset(100);
        make.centerX.equalTo(threeView);
    }];
    
    UILabel * monthLabel = [UILabel cz_labelWithText:@"800.00元" fontSize:16 color:[UIColor whiteColor]];
    monthLabel.textAlignment = NSTextAlignmentCenter;
    [backgroundButton addSubview:monthLabel];
    [monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(midLabel.mas_bottom).offset(5);
        make.centerX.equalTo(midLabel);
    }];
    
    
    UILabel * leftLabel = [UILabel cz_labelWithText:@"可用余额" fontSize:14 color:[UIColor colorWithWhite:1 alpha:0.7]];
    [threeView addSubview:leftLabel];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(threeView).offset(0);
        make.left.offset(50);
    }];
    
    UILabel * moneyLabel = [UILabel cz_labelWithText:@"2600.00元" fontSize:16 color:[UIColor whiteColor]];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [backgroundButton addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLabel.mas_bottom).offset(5);
        make.centerX.equalTo(leftLabel);
    }];
    
    
    UILabel * rightLabel = [UILabel cz_labelWithText:@"待收利息" fontSize:14 color:[UIColor colorWithWhite:1 alpha:0.7]];
    [threeView addSubview:rightLabel];
    rightLabel.textAlignment = NSTextAlignmentRight;
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(threeView).offset(0);
        make.right.offset(-50);
    }];
    
    UILabel * typeLabel = [UILabel cz_labelWithText:@"120.00元" fontSize:16 color:[UIColor whiteColor]];
    [backgroundButton addSubview:typeLabel];
    typeLabel.textAlignment = NSTextAlignmentRight;
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightLabel.mas_bottom).offset(5);
        make.centerX.equalTo(rightLabel);
    }];
}



//头像按钮
- (void)personButtonClick
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YRHXLoginViewController" bundle:nil];
    YRHXLoginViewController * loginVc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:loginVc animated:YES];
}

//会员中心按钮
- (void)memberButtonClick
{
    YRHXMemberCenterController * memberVC = [YRHXMemberCenterController new];
    [self.navigationController pushViewController:memberVC animated:YES];
}

- (void)noticeButtonClick
{
    NSLog(@"平台公告");
}

//总资产下方按钮
- (void)backgroundButtonClick
{
    YRHXMoneyContentController * vc = [[YRHXMoneyContentController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}










//选中item的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0)
    {
        //充值
        //充值
//        YRHXTopUpController * topUpVC = [[YRHXTopUpController alloc]initWithNibName:@"YRHXTopUpController" bundle:[NSBundle mainBundle]];
//        [self.navigationController pushViewController:topUpVC animated:YES];
//        
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YRHXTopUpController" bundle:nil];
        YRHXTopUpController * topUpVC = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:topUpVC animated:YES];
    }
    
    if (indexPath.section == 1 && indexPath.row == 1)
    {
        //提现
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YRHXWithDrawCash" bundle:nil];
        YRHXWithDrawCashController * withDrawVC = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:withDrawVC animated:YES];
    }

    if (indexPath.section == 1 && indexPath.row == 2)
    {
        //签到
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"签到成功" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            YRHXSignatureController * signatureVC = [[YRHXSignatureController alloc]init];
            [self.navigationController pushViewController:signatureVC animated:YES];
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
   
    }

    if (indexPath.section == 1 && indexPath.row == 3)
    {
        //我的投资
        YRHXMyInvestController * myInvestVC = [[YRHXMyInvestController alloc]init];
        [self.navigationController pushViewController:myInvestVC animated:YES];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 4)
    {
        //自动投标
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"auto" bundle:nil];
        AutoSubmitController * submitVC = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:submitVC animated:YES];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 5)
    {
        //债权转让
        YRHXCreditorTransferController * transferVC = [[YRHXCreditorTransferController alloc]init];
        [self.navigationController pushViewController:transferVC animated:YES];

    }

    if (indexPath.section == 1 && indexPath.row == 6)
    {
        //资金明细
        YRHXMoneyMinXiController * transferVC = [[YRHXMoneyMinXiController alloc]init];
        [self.navigationController pushViewController:transferVC animated:YES];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 7)
    {
        //积分商城
        YRHXScoresMallController * mallVC = [[YRHXScoresMallController alloc]init];
        [self.navigationController pushViewController:mallVC animated:YES];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 8)
    {
        //优惠券
//        YRHXMyVoucherController * voucherVC = [[YRHXMyVoucherController alloc]init];
//        [self.navigationController pushViewController:voucherVC animated:YES];
       
        NoUseController * voucherVC = [[NoUseController alloc]init];
        [self.navigationController pushViewController:voucherVC animated:YES];
    }

    
}





//加载数据
- (NSArray *)loadOptionsData {
    
    return [NSArray cz_objectListWithPlistName:@"YRHXOption.plist" clsName:@"AccountOptionModel"];
}


@end
