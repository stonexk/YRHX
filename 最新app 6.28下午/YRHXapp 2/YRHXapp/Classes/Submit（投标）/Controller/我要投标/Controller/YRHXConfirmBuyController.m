//
//  YRHXConfirmBuyController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/24.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXConfirmBuyController.h"
#import "UIColor+ColorChange.h"
#import "Masonry.h"
#import "HaveChoiceVoucherController.h"
#import "NoChoiceVoucherController.h"
#import "RegisterPopWindowVC.h"
#import "UILabel+CZAddition.h"

@interface YRHXConfirmBuyController ()

@property (weak, nonatomic) IBOutlet UIButton * touchButton;    //优惠券下面的整体按钮
@property (weak, nonatomic) IBOutlet UILabel *voucherInfoLabel;  //优惠券详情label

@property (nonatomic ,strong) UIView * deliverView; //底部View
@property (nonatomic ,strong) UIView * BGView; //遮罩

@end

@implementation YRHXConfirmBuyController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(turn)];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];    
    self.navigationItem.title = @"确认投资";

    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];

    
    
    UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:@"确认投资" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view).offset(0);
        make.height.offset(45);
    }];
    [btn addTarget:self action:@selector(confirmBuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //跳转优惠券
    [self.touchButton addTarget:self action:@selector(jumpToNoUseController) forControlEvents:UIControlEventTouchUpInside];
    
}


//键盘
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.view endEditing:YES];
}

//监听方法
- (void)turn
{
     [self.navigationController popViewControllerAnimated:YES];
}


//优惠券跳转
- (void)jumpToNoUseController
{
//    if ([self.voucherInfoLabel.text isEqualToString:@"暂无哦"]) {
//        
//        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"NoChoiceVoucherController" bundle:nil];
//        NoChoiceVoucherController * noChoiceVoucherVC = [sb instantiateInitialViewController];
//        [self.navigationController pushViewController:noChoiceVoucherVC animated:YES];       
//    }
//    else
//    {
    
//    }
        HaveChoiceVoucherController * haveChoiceVoucherVC = [[HaveChoiceVoucherController alloc]init];
        
        //    void(^block)() = ^(NSString * content){
        //        self.voucherInfoLabel.text = content;
        //    };
        //    haveChoiceVoucherVC.zwBlock = block;
        
        [self.navigationController pushViewController:haveChoiceVoucherVC animated:YES];
    
}


//确认投资按钮
- (void)confirmBuyBtnClick
{
   //数据处理   用户投资成功
    
    
    [self appearClick];
}


//确认投资底部弹出的投标方式View==================================================================
- (void)appearClick {
    // ------全屏遮罩
    self.BGView                 = [[UIView alloc] init];
    self.BGView.frame           = [[UIScreen mainScreen] bounds];
    self.BGView.tag             = 100;
    self.BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.BGView.opaque = NO;
    
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:self.BGView];
    
    //给全屏遮罩添加的点击事件
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitClick)];
    gesture.numberOfTapsRequired = 1;
    gesture.cancelsTouchesInView = NO;
    [self.BGView addGestureRecognizer:gesture];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
    
    
    //底部弹出的View
    self.deliverView = [[UIView alloc] init];
    self.deliverView.frame = CGRectMake((KscreenWidth-230)/2, 200, 230, 100);
    self.deliverView.layer.cornerRadius = 5;
    self.deliverView.backgroundColor = [UIColor whiteColor];
    [appWindow addSubview:self.deliverView];
    
    //View出现动画
    self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, KscreenHeight);
    [UIView animateWithDuration:0.4 animations:^{
        self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
    }];
    
    ////底部View上的控件
    UILabel * titleLab = [UILabel cz_labelWithText:@"已投资" fontSize:18 color:[UIColor blackColor]];
    [self.deliverView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.deliverView).offset(10);
        make.centerY.equalTo(self.deliverView).offset(-15);
    }];
    
    UIImageView * picImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"redTick"]];
    [self.deliverView addSubview:picImg];
    [picImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab);
        make.right.equalTo(titleLab.mas_left).offset(-5);
        make.width.height.offset(23.5);
    }];
    
    UILabel * detailab = [UILabel cz_labelWithText:@"满标后开始计息" fontSize:15 color:[UIColor darkGrayColor]];
    [self.deliverView addSubview:detailab];
    [detailab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.deliverView);
        make.bottom.offset(-20);
    }];
}

////点击屏幕
//- (void)buttonTapped:(UIButton *)sender
//{
//
//    [self exitClick];
//}



//view跳出返回上个界面
- (void)exitClick {
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, KscreenHeight);
        self.deliverView.alpha = 0.2;
        self.BGView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.BGView removeFromSuperview];
        [self.deliverView removeFromSuperview];
    }];
    
    //返回两级界面
    NSInteger index=[[self.navigationController viewControllers]indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-2]animated:YES];
}




@end
