//
//  YRHXInviteController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/15.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXInviteController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "YRHXInviteRewardsController.h"
#import <UShareUI/UShareUI.h>
#import "NSAttributedString+CZAdditon.h"
#import "UILabel+CZAddition.h"
#import "UIColor+ColorChange.h"
#import "UIColor+CZAddition.h"


typedef enum : NSUInteger {
    ZFBHomeTopViewBtnTypeScan = 100,
    ZFBHomeTopViewBtnTypePay,
    ZFBHomeTopViewBtnTypeCard,
    ZFBHomeTopViewBtnTypeXiu
} ZFBHomeTopViewBtnType;


@interface YRHXInviteController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIView * inviteView;
@property (nonatomic,strong) UIButton * inviteButton;

@property (nonatomic ,strong) UIView * BGView; //遮罩
@property (nonatomic ,strong) UIView * deliverView; //底部View
@property (nonatomic ,strong) UILabel * label1;
@property (nonatomic ,strong) UILabel * label2;
@property (nonatomic ,strong) UIButton * button1;
@property (nonatomic ,strong) UIButton * button2;
@property (nonatomic ,strong) UIView * midView;



@end

static NSString * inviteCellID = @"inviteCellID";
@implementation YRHXInviteController


//懒加载
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, tableViewHeight + 77)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}


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


- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"邀请好友";
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,80,30)];
    [rightButton setTitle:@"邀请奖励" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;

    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:inviteCellID];
    
//    [UMSocialUIManager setShareMenuViewDelegate:self];
//    
//    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchprogram
{    
    YRHXInviteRewardsController * VC = [YRHXInviteRewardsController new];
    [self.navigationController pushViewController:VC animated:YES];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:inviteCellID forIndexPath:indexPath];
    
    UIImageView * img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"邀请-1"]];
    [cell  addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(775*KscreenWidth/375);
    }];
    
    _inviteView = [[UIView alloc]init];
    _inviteView.backgroundColor = [UIColor colorWithHexString:@"ffb81a"];
    [cell addSubview:_inviteView];
    [_inviteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_bottom).offset(0);
        make.left.right.bottom.offset(0);
    }];
    
    _inviteButton = [[UIButton alloc]init];
    [_inviteButton setImage:[UIImage imageNamed:@"马上邀请"] forState:UIControlStateNormal];
    [_inviteView addSubview:_inviteButton];
    [_inviteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_inviteView);
        make.width.offset(236*KscreenHeight/667);
        make.height.offset(48*KscreenWidth/375);
    }];
    [_inviteButton addTarget:self action:@selector(inviteButtonClick) forControlEvents:UIControlEventTouchUpInside];
   
    return cell;
}

- (void)inviteButtonClick
{
    [self appearClick];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 875*KscreenWidth/375;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _inviteView.backgroundColor = [UIColor colorWithHexString:@"ffb81a"];
    [_inviteButton setImage:[UIImage imageNamed:@"马上邀请"] forState:UIControlStateNormal];
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _inviteView.backgroundColor = [UIColor colorWithHexString:@"ffb81a"];
    [_inviteButton setImage:[UIImage imageNamed:@"马上邀请"] forState:UIControlStateSelected];
}






//邀请按钮底部弹出的投标方式View==================================================================
- (void)appearClick {
    // ------全屏遮罩
    self.BGView                 = [[UIView alloc] init];
    self.BGView.frame           = [[UIScreen mainScreen] bounds];
    self.BGView.tag             = 100;
    self.BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.BGView.opaque = NO;

    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:self.BGView];
    
    // ------给全屏遮罩添加的点击事件
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitClick)];
    gesture.numberOfTapsRequired = 1;
    gesture.cancelsTouchesInView = NO;
    [self.BGView addGestureRecognizer:gesture];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
    }];
    
    
    // ------底部弹出的View
    self.deliverView = [[UIView alloc] init];
    self.deliverView.frame = CGRectMake(0, KscreenHeight - 200, KscreenWidth, 200);
    self.deliverView.backgroundColor = [UIColor colorWithRed:232/255.0 green:239/255.0  blue:242/255.0  alpha:1.0];
    [appWindow addSubview:self.deliverView];
    
    // ------View出现动画
    self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, KscreenHeight);
    [UIView animateWithDuration:0.4 animations:^{
        self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
    }];
    
    
    //添加白色view
    UIButton * deSelectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 160, KscreenWidth, 40)];
    deSelectBtn.backgroundColor = [UIColor colorWithRed:246/255.0 green:250/255.0 blue:252/255.0 alpha:1.0];
    [deSelectBtn setTitle:@"取消分享" forState:UIControlStateNormal];
    [deSelectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    deSelectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.deliverView addSubview:deSelectBtn];
    [deSelectBtn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(0, 20,KscreenWidth,140)];
    self.midView = midView;
    [self.deliverView addSubview:midView];
    
    UILabel * chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 50)];
    [self.deliverView addSubview:chooseLabel];
    chooseLabel.text = @"请选择分享平台";
    chooseLabel.textColor = [UIColor darkGrayColor];
    chooseLabel.font = [UIFont systemFontOfSize:16];
    chooseLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton * chatBtn = [self makeTopButtonWithTitle:@"微信好友" andButtonImageName:@"新手福利" buttonType:ZFBHomeTopViewBtnTypeScan];
    UIButton * quanBtn = [self makeTopButtonWithTitle:@"微信朋友圈" andButtonImageName:@"邀请有礼" buttonType:ZFBHomeTopViewBtnTypePay];
    UIButton * qqBtn = [self makeTopButtonWithTitle:@"QQ" andButtonImageName:@"平台数据" buttonType:ZFBHomeTopViewBtnTypeCard];
    UIButton * qzoneBtn = [self makeTopButtonWithTitle:@"QQ空间" andButtonImageName:@"每日签到" buttonType:ZFBHomeTopViewBtnTypeXiu];
    
    [chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.offset(KscreenWidth/4);
    }];
    [chatBtn addTarget:self action:@selector(chatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [quanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chatBtn.mas_right).offset(0);
        make.bottom.top.offset(0);
        make.width.offset(KscreenWidth/4);
    }];
    [quanBtn addTarget:self action:@selector(quanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(quanBtn.mas_right).offset(0);
        make.bottom.top.offset(0);
        make.width.offset(KscreenWidth/4);
    }];
    [qqBtn addTarget:self action:@selector(qqBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [qzoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(qqBtn.mas_right).offset(0);
        make.bottom.right.top.offset(0);
    }];
    [qzoneBtn addTarget:self action:@selector(qzoneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [midView addSubview:chatBtn];
    [midView addSubview:quanBtn];
    [midView addSubview:qqBtn];
    [midView addSubview:qzoneBtn];
}

//功能： View退出
- (void)exitClick {
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, KscreenHeight);
        self.deliverView.alpha = 0.2;
        self.BGView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.BGView removeFromSuperview];
        [self.deliverView removeFromSuperview];
    }];
}


- (void)buttonTapped:(UIButton *)sender {
    [self exitClick];
}

- (void)chatBtnClick
{
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
}
- (void)quanBtnClick
{
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
}
- (void)qqBtnClick
{
    [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
}
- (void)qzoneBtnClick
{
    [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
}






- (UIButton *)makeTopButtonWithTitle:(NSString *)title andButtonImageName:(NSString *)imageName buttonType:(ZFBHomeTopViewBtnType)type {
    
    UIButton *btn = [[UIButton alloc] init];
    NSAttributedString *attStr = [NSAttributedString cz_imageTextWithImage:[UIImage imageNamed:imageName] imageWH:35 title:title fontSize:12 titleColor:[UIColor darkGrayColor] spacing:3];
    
    [btn setAttributedTitle:attStr forState:UIControlStateNormal];
    btn.titleLabel.numberOfLines = 0;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.midView addSubview:btn];
    
    btn.tag = type;
    
    return btn;
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    NSString* thumbURL = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498035690375&di=15d863c219d00bc4b1537b6ab92fa20e&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F17%2F93%2F20x58PICpbf_1024.jpg";
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"【易融恒信】邀请有礼-投资理财活动" descr:@"邀请好友送50元现金券" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://www.yrhx.com/share?u=22efccbc3896498ea1fc55dd6c141172";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    

    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
}








@end
