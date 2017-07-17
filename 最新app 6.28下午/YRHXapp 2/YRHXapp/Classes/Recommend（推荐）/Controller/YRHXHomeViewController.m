//
//  YRHXHomeViewController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/17.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXHomeViewController.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
#import "UIColor+ColorChange.h"
#import "UIColor+CZAddition.h"
#import "YRHXCycleView.h"
#import "LPImageContentView.h"
//#import "LPAutoScrollView.h"
#import "LPView.h"
#import "NSAttributedString+CZAdditon.h"
#import "YRHXStartBuyController.h"
#import "YRHXWantBuyController.h"
#import "YRHXPlatformDataController.h"
#import "YRHXSignatureController.h"
#import "ScrollImage.h"
#import "JumpController.h"
#import "SGAdvertScrollView.h"
#import "YRHXInviteController.h"
#import "YRHXNewWelfareController.h"

@interface YRHXHomeViewController ()<UITableViewDataSource,UITableViewDelegate,ScrollImageDelegate,SGAdvertScrollViewDelegate>
//LPAutoScrollViewDatasource, LPAutoScrollViewDelegate

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, weak) LPAutoScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *titlesArray;

@property(nonatomic,weak)UIView *pictureView;
@property(nonatomic,weak)YRHXCycleView *cycleView;
@property (nonatomic,assign) CGFloat pictureRealH;
@property (nonatomic, strong)UILabel * priceLabel;
@property (nonatomic, strong)UITableViewCell * noticeCell;
@property (nonatomic, strong)UITableViewCell * collectionCell;
@property (nonatomic, strong)UITableViewCell * bottomCell;
@property (nonatomic, strong)UIButton * submitSoonBtn;
@end
static NSString * topCellID = @"topCellID";
static NSString * noticeCellID = @"noticeCellID";
static NSString * collectionCellID = @"collectionCellID";
static NSString * bottomCellID = @"bottomCellID";

@implementation YRHXHomeViewController

-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, KscreenWidth, KscreenHeight)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

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
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.translucent = YES;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = nil;
    self.tableView.tableFooterView = [UIView new];
//    self.tableView.tableFooterView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:topCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:noticeCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:collectionCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:bottomCellID];

}



//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    self.scrollView.frame = _priceLabel.frame;
//}
//
//- (NSUInteger)lp_numberOfNewsDataInScrollView:(LPAutoScrollView *)scrollView {
//    return self.titlesArray.count;
//}
//
//- (void)lp_scrollView:(LPAutoScrollView *)scrollView newsDataAtIndex:(NSUInteger)index forContentView:(LPView *)contentView {
//    contentView.title = self.titlesArray[index];
//}
//
//- (void)lp_scrollView:(LPAutoScrollView *)scrollView didTappedContentViewAtIndex:(NSUInteger)index {
//    NSLog(@"%@", self.titlesArray[index]);
//}




//数据源方法=======================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        UITableViewCell * topCell = [tableView dequeueReusableCellWithIdentifier:topCellID forIndexPath:indexPath];
        
        
//        YRHXCycleView * cycleView = [[YRHXCycleView alloc] init];
//        
//        // 2.传递数据
//        cycleView.imageArray = [self loadCycleData];
//        // 3.添加到父控件上
//        [topCell addSubview:cycleView];
//        
//        [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.right.left.offset(0);
//        }];
        
        
        
        
        NSArray *array1 = @[
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498194625358&di=4e0940e2a9e4b5585c239b4e2e370901&imgtype=0&src=http%3A%2F%2Fimg15.3lian.com%2F2015%2Ff2%2F101%2Fd%2F104.jpg",
                            
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498789469&di=948818da5cb3f42d2accedeb24089c7c&imgtype=jpg&er=1&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Ff703738da97739120371fe46f2198618367ae246.jpg",
                            
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498194965113&di=08788c25c8f38065ed034ac73aa9adb7&imgtype=0&src=http%3A%2F%2Fdimg02.c-ctrip.com%2Fimages%2Ftg%2F556%2F255%2F459%2F42058039ccac4d1d86425eaf620dd2cc_R_1024_10000.jpg",
                            
                            @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498194810634&di=27631f537ec0b1ce92aa095bdad7563c&imgtype=0&src=http%3A%2F%2Fww1.sinaimg.cn%2Flarge%2F8f7947degw1eh2zzz1smzj20zk0nw45p.jpg",
                            
                            @"http://pic17.huitu.com/res/20140303/86378_20140303213126066200_1.jpg"
                            ];
        
        ScrollImage *scrl = [[ScrollImage alloc] initWithCurrentController:self
                                                                 urlString:array1
                                                                 viewFrame:CGRectMake(0, 0,KscreenWidth, 180 *KscreenWidth / 375)
                                                          placeholderImage:[UIImage imageNamed:@"占位图"]];
        
        scrl.delegate = self;
        scrl.timeInterval = 2.0;
        [topCell addSubview:scrl.view];
        
        
        
        
        
        return topCell;
    }
    
 //公告label
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        _noticeCell = [tableView dequeueReusableCellWithIdentifier:noticeCellID forIndexPath:indexPath];
        
        [self setupNoticeViews];
        
        return _noticeCell;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        //四个控件
        _collectionCell = [tableView dequeueReusableCellWithIdentifier:collectionCellID forIndexPath:indexPath];
        
        [self setupCollectionViews];
        
        return _collectionCell;
    }
    
    _bottomCell = [tableView dequeueReusableCellWithIdentifier:bottomCellID forIndexPath:indexPath];
    
//    [self setupBottomViews];
    [self setupBottom];
    
    return _bottomCell;
}


//组高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CGFloat pictureRealH1 = 180 * KscreenWidth / 375;
    CGFloat pictureRealH2 = 40 * KscreenWidth / 375;
    CGFloat pictureRealH3 = 90 * KscreenWidth / 375;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return pictureRealH1;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        return pictureRealH2;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        return pictureRealH3;
    }
    return KscreenHeight - 10 - pictureRealH3 - pictureRealH2 - pictureRealH1-59;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}



- (void)setupNoticeViews
{
//    UIImageView * noticeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"消息"]];
//    [_noticeCell addSubview:noticeImage];
//    [noticeImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_noticeCell);
//        make.left.offset(15);
//        make.height.width.offset(25);
//    }];
//    
//
//    self.titlesArray = [NSMutableArray array];
//    NSArray *array = [NSArray arrayWithObjects:@"累计成交金额hello",@"总共赚取world",@"待回收金额23423",@"风险备用金554", nil];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        for (int i = 0; i < array.count; i ++) {
//            //            [self.titlesArray addObject:[NSString stringWithFormat:@"%d + 累计3万4832元", i]];
//            [self.titlesArray addObject:array[i]];
//        }
//        // 数据源变化后调用 reload
//        [self.scrollView lp_reloadData];
//        
//    });
//    
//    LPAutoScrollView *scrollView = [[LPAutoScrollView alloc] initWithStyle:LPAutoScrollViewStyleVertical];
//    
//    scrollView.lp_scrollDataSource = self;
//    scrollView.lp_scrollDelegate = self;
//    
//    scrollView.lp_stopForSingleDataSourceCount = YES;
//    
//    scrollView.lp_autoScrollInterval = 2;
//    
//    [scrollView lp_registerClass:[LPView class]];
//    
//    _scrollView = scrollView;
//    [_noticeCell addSubview:scrollView];
//    scrollView.frame = _priceLabel.frame;
//    
//    
//    
//    _priceLabel = [UILabel cz_labelWithText:@"." fontSize:13 color:nil];
//    _priceLabel.textColor = [UIColor whiteColor];
//    [_noticeCell addSubview:_priceLabel];
//    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(noticeImage.mas_right).offset(10);
//        make.centerY.equalTo(_noticeCell);
//        make.width.offset(KscreenWidth - 75);
//    }];
    
    
    
    SGAdvertScrollView *advertScrollView = [[SGAdvertScrollView alloc] init];
    advertScrollView.frame = CGRectMake(0, 0, KscreenWidth, 40 * KscreenWidth / 375);
    advertScrollView.titleColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    advertScrollView.scrollTimeInterval = 2;
    advertScrollView.leftImageName = @"消息";
    advertScrollView.titles = @[@"常见电商类 app 滚动播放广告信息", @"采用代理模式封装, 可进行事件点击处理", @"建议去 github 上下载"];
    advertScrollView.titleFont = [UIFont systemFontOfSize:13];
    advertScrollView.delegateAdvertScrollView = self;
    advertScrollView.isShowSeparator = NO;
    [_noticeCell addSubview:advertScrollView];


    
    //箭头imageView
    UIImageView * indicatorImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"箭头2"]];
    [_noticeCell addSubview:indicatorImg];
    [indicatorImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.equalTo(_noticeCell);
        make.width.height.offset(15);
    }];

}

- (void)setupCollectionViews
{
    UIButton * welfareBtn = [self makeTopButtonWithTitle:@"新手福利" andButtonImageName:@"新手福利" buttonType:ZFBHomeTopViewBtnTypeScan];
    UIButton * giftBtn = [self makeTopButtonWithTitle:@"邀请有礼" andButtonImageName:@"邀请有礼" buttonType:ZFBHomeTopViewBtnTypePay];
    UIButton * dataBtn = [self makeTopButtonWithTitle:@"平台数据" andButtonImageName:@"平台数据" buttonType:ZFBHomeTopViewBtnTypeCard];
    UIButton * signInBtn = [self makeTopButtonWithTitle:@"每日签到" andButtonImageName:@"每日签到" buttonType:ZFBHomeTopViewBtnTypeXiu];
    
    [welfareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.offset(KscreenWidth/4);
    }];
    [welfareBtn addTarget:self action:@selector(welfareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(welfareBtn.mas_right).offset(0);
        make.bottom.top.offset(0);
        make.width.offset(KscreenWidth/4);
    }];
    [giftBtn addTarget:self action:@selector(giftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [dataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(giftBtn.mas_right).offset(0);
        make.bottom.top.offset(0);
        make.width.offset(KscreenWidth/4);
    }];
    [dataBtn addTarget:self action:@selector(dataBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataBtn.mas_right).offset(0);
        make.bottom.right.top.offset(0);
    }];
    [signInBtn addTarget:self action:@selector(signInBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_collectionCell addSubview:welfareBtn];
    [_collectionCell addSubview:giftBtn];
    [_collectionCell addSubview:dataBtn];
    [_collectionCell addSubview:signInBtn];
    
}

- (void)welfareBtnClick
{
    YRHXNewWelfareController * newWelfareVC = [[YRHXNewWelfareController alloc]init];
    [self.navigationController pushViewController:newWelfareVC animated:YES];
}
- (void)giftBtnClick
{
    YRHXInviteController * inviteVC = [[YRHXInviteController alloc]init];
    [self.navigationController pushViewController:inviteVC animated:YES];
}
- (void)dataBtnClick
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YRHXPlatformDataController" bundle:nil];
    YRHXPlatformDataController * DataVC = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:DataVC animated:YES];
}
- (void)signInBtnClick
{
    //签到
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"签到成功" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        YRHXSignatureController * signatureVC = [[YRHXSignatureController alloc]init];
        [self.navigationController pushViewController:signatureVC animated:YES];
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];

}



- (void)setupBottom
{
//    278
    UIImageView * xinshouImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"新手专享标"]];
    [_bottomCell addSubview:xinshouImage];
    CGFloat pictureRealH2 = 40 * KscreenWidth / 375;
    [xinshouImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomCell);
        make.top.equalTo(_bottomCell.mas_top).offset(0);
        make.height.offset(pictureRealH2);
        make.width.offset(100);
    }];
    
    
    UIView * oneView = [[UIView alloc]init];
    [_bottomCell addSubview:oneView];
     CGFloat pictureRealH3 = 78 * KscreenWidth / 375;
    [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(xinshouImage.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.height.offset(pictureRealH3);
    }];
    
    
    
    UILabel * submitNumLab = [UILabel cz_labelWithText:@"13.3" fontSize:40 color:[UIColor colorWithHexString:@"eb413d"]];
    [oneView addSubview:submitNumLab];
    
    [submitNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(oneView);
        make.bottom.equalTo(oneView.mas_bottom).offset(-4);
    }];
    
    UILabel * percentLab = [UILabel cz_labelWithText:@"%" fontSize:15 color:[UIColor colorWithHexString:@"eb413d"]];
    [oneView addSubview:percentLab];
    [percentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(submitNumLab.mas_right).offset(0);
        make.bottom.equalTo(submitNumLab.mas_bottom).offset(-5);
    }];
    

    UIView * twoView = [[UIView alloc]init];
    [_bottomCell addSubview:twoView];
    CGFloat pictureRealH4 = 40 * KscreenWidth / 375;
    [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneView.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.height.offset(pictureRealH4);
    }];
    
    
    UIImageView * midSmallImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"边框红色"]];
    [twoView addSubview:midSmallImg];
    [midSmallImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(submitNumLab);
        make.top.equalTo(twoView.mas_top).offset(0);
        make.height.offset(30);
        make.width.offset(100);
    }];
    
    UILabel * awardLabel = [UILabel cz_labelWithText:@"加奖励0.0%" fontSize:15 color:[UIColor colorWithHexString:@"eb413d"]];
    awardLabel.textAlignment = NSTextAlignmentCenter;
    [midSmallImg addSubview:awardLabel];
    [awardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
    
    
    
    UIView * thirdView = [[UIView alloc]init];
    [_bottomCell addSubview:thirdView];
    CGFloat pictureRealH5 = 45 * KscreenWidth / 375;
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
    
    UILabel * midLabel = [[UILabel alloc]init];
    midLabel.text = @"剩余0.00万";
    midLabel.backgroundColor = [UIColor whiteColor];
    midLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    midLabel.font = [UIFont systemFontOfSize: 14];
    [threeView addSubview:midLabel];
    midLabel.textAlignment = NSTextAlignmentCenter;
    [midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(threeView).offset(0);
        make.width.offset(100);
        make.centerX.equalTo(threeView);
    }];
    
    UIView * lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#b1b1b1"];
    [threeView addSubview:lineView1];
    CGFloat RealH5 = 20 * KscreenWidth / 375;
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(midLabel.mas_left).offset(-6);
        make.centerY.equalTo(threeView);
        make.height.offset(RealH5);
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
        make.centerY.equalTo(threeView);
        make.height.offset(RealH5);
        make.width.offset(1);
    }];
    
    UILabel * rightLabel = [[UILabel alloc]init];
    rightLabel.text = @"100元起投";
    rightLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    rightLabel.font = [UIFont systemFontOfSize: 14];
    [threeView addSubview:rightLabel];
    rightLabel.textAlignment = NSTextAlignmentRight;
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(threeView).offset(0);
        make.width.offset(80);
        make.left.equalTo(lineView2.mas_right).offset(6);
    }];
    
    
    UIView * fourView = [[UIView alloc]init];
    [_bottomCell addSubview:fourView];
    CGFloat pictureRealH6 = 70 * KscreenWidth / 375;
    [fourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdView.mas_bottom).offset(0);
        make.left.right.offset(0);
        make.height.offset(pictureRealH6);
    }];
    
    UIButton * submitSoonBtn = [[UIButton alloc]init];
    self.submitSoonBtn = submitSoonBtn;
    submitSoonBtn.clipsToBounds = YES;
    submitSoonBtn.layer.cornerRadius=20;
    [submitSoonBtn setTitle:@"立即投标" forState:UIControlStateNormal];
    [fourView addSubview:submitSoonBtn];
    [submitSoonBtn setBackgroundColor:[UIColor colorWithHexString:@"#eb413d"]];
    CGFloat RealH6 = 44 * KscreenWidth / 375;
    
    [submitSoonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fourView.mas_left).offset(15);
        make.right.equalTo(fourView.mas_right).offset(-15);
        make.height.offset(RealH6);
        make.top.equalTo(fourView.mas_top).offset(10);
    }];
    
    //监听事件
    [submitSoonBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)buttonClick:(UIButton *)button
{
    YRHXWantBuyController * startBuyVC = [[YRHXWantBuyController alloc]init];
//    YRHXStartBuyController * startBuyVC = [[YRHXStartBuyController alloc]init];
    
    [self.navigationController pushViewController:startBuyVC animated:YES];
}


- (UIButton *)makeTopButtonWithTitle:(NSString *)title andButtonImageName:(NSString *)imageName buttonType:(ZFBHomeTopViewBtnType)type {

    UIButton *btn = [[UIButton alloc] init];
    NSAttributedString *attStr = [NSAttributedString cz_imageTextWithImage:[UIImage imageNamed:imageName] imageWH:35 title:title fontSize:15 titleColor:[UIColor darkGrayColor] spacing:3];
 
    [btn setAttributedTitle:attStr forState:UIControlStateNormal];
    btn.titleLabel.numberOfLines = 0;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_collectionCell addSubview:btn];

    btn.tag = type;
    
    return btn;
}


//轮播器
- (NSArray *)loadCycleData {

    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:5];
    // for循环加载图片并添加到数组中
    for (NSInteger i = 0; i < 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%zd",i];
        // 加载图片
        UIImage *image = [UIImage imageNamed:imageName];
        // 保存到可变数组
        [arrM addObject:image];
    }
    return arrM;
}


//选中cell时候按钮颜色不消失
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_submitSoonBtn setBackgroundColor:[UIColor colorWithHexString:@"#eb413d"]];
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_submitSoonBtn setBackgroundColor:[UIColor colorWithHexString:@"#eb413d"]];
}



//轮播图   代理 跳转界面 ==================================================
- (void)scrollImage:(ScrollImage *)scrollImage clickedAtIndex:(NSInteger)index
{
    NSLog(@"click:%ld",(long)index);
    JumpController * jump = [[JumpController alloc]init];
    [self.navigationController pushViewController:jump animated:YES];
}





//滚动label的代理方法
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"滚动label代理方法哦ooo");
}

@end
