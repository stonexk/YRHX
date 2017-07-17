//
//  YRHXPayPwController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/2.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXPayPwController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "ZYKeyboardUtil.h"
#import <SMS_SDK/SMSSDK.h>

@interface YRHXPayPwController ()

@property(nonatomic,strong)UITextField * pwTF;
@property(nonatomic,strong)UITextField * pwTF2;
@property(nonatomic,strong)UITextField * messageTF;
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性


@end

@implementation YRHXPayPwController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = @"支付密码";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    //添加手势 ---》键盘
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finger:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    [self keyBoard];
    
    [self setupUI];
    

}
//点击空白处  键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}
-(void)finger:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.view endEditing:YES];
}
- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)keyBoard
{
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    
    [self configKeyBoardRespond];
}


- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] initWithKeyboardTopMargin:40];
    __weak YRHXPayPwController *weakSelf = self;
 
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.pwTF,weakSelf.pwTF2,weakSelf.messageTF, nil];
    }];
    
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
    }];
}






- (void)setupUI
{
    //第一行
    UIView * topView = [UIView new];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(17.5);
        make.height.offset(58.5);
    }];
    
    UIImageView * newPwPic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码"]];
    [topView addSubview:newPwPic];
    [newPwPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.width.height.offset(28.5);
        make.centerY.equalTo(topView);
    }];
    
    _pwTF = [[UITextField alloc]init];
    _pwTF.placeholder = @"请输入新密码";
    [topView addSubview:_pwTF];
    [_pwTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newPwPic.mas_right).offset(5);
        make.centerY.equalTo(newPwPic);
        make.right.offset(0);
    }];
    
    //线
    UILabel * lineLab = [[UILabel alloc]init];
    lineLab.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:lineLab];
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(0);
        make.bottom.equalTo(topView.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    

    
    //第二行
    UIView * midView = [UIView new];
    midView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(topView.mas_bottom).offset(0);
        make.height.offset(57.5);
    }];
    
    UIImageView *newPwPic2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码"]];
    [midView addSubview:newPwPic2];
    [newPwPic2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.width.height.offset(28.5);
        make.centerY.equalTo(midView);
    }];
    
    _pwTF2 = [[UITextField alloc]init];
    _pwTF2.placeholder = @"再输一遍新密码";
    [midView addSubview:_pwTF2];
    [_pwTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newPwPic2.mas_right).offset(5);
        make.centerY.equalTo(newPwPic2);
        make.right.offset(0);
    }];
    
    
       //第三行
    UIView * footView = [UIView new];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(midView.mas_bottom).offset(17.5);
        make.height.offset(57.5);
    }];
    
    UIImageView * messagePic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"短信验证码"]];
    [footView addSubview:messagePic];
    [messagePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.width.height.offset(28.5);
        make.centerY.equalTo(footView);
    }];
    
    _messageTF = [[UITextField alloc]init];
    _messageTF.placeholder = @"请输入短信验证码";
    [footView addSubview:_messageTF];
    [_messageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(messagePic.mas_right).offset(5);
        make.centerY.equalTo(messagePic);
        make.width.offset(KscreenWidth - 165);
    }];
    
    
    UIButton * getButton = [[UIButton alloc]init];
    [getButton setTitle:@"获取" forState:UIControlStateNormal];
    getButton.layer.cornerRadius=3;
    getButton.backgroundColor = [UIColor colorWithHexString:@"#1294f6"];
    [getButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [footView addSubview:getButton];
    
    [getButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(messagePic);
        make.right.equalTo(footView.mas_right).offset(-15);
        make.width.offset(60);
        make.height.offset(25);
    }];
    
    [getButton addTarget:self action:@selector(getButtonClick) forControlEvents:UIControlEventTouchUpInside];
    

    
    //底部按钮
    UIButton * remakePWBtn = [[UIButton alloc]init];
    remakePWBtn.layer.cornerRadius = 10;
    [remakePWBtn setBackgroundColor:[UIColor colorWithHexString:@"#1294f6"]];
    [remakePWBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [self.view addSubview:remakePWBtn];
    [remakePWBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(footView.mas_bottom).offset(30);
        make.height.offset(47.5);
    }];

}





//获取短信验证码
- (void)getButtonClick
{

    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"18672536007"
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         NSLog(@"获取验证码成功");
                                     } else {
                                         NSLog(@"错误信息：%@",error);
                                     }
                                 }];
    
}

- (void)remakeButtonClick
{
    
    [SMSSDK commitVerificationCode:_messageTF.text phoneNumber:@"18672536007" zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        
        {
            if (!error)
            {
                
                UIViewController * registerVc = [[UIViewController alloc]init];
                [self.navigationController pushViewController:registerVc animated:YES];
                
                
                NSLog(@"验证成功");
            }
            else
            {
                NSLog(@"错误信息:%@",error);
            }
        }
    }];
    
    
    
    
}



@end
