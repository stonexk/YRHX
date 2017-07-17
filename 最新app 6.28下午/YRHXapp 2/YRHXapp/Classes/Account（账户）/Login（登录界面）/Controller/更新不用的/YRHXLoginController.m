//
//  YRHXLoginController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/18.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXLoginController.h"
#import "UIColor+ColorChange.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
//#import "YRHXRegisterController.h"
#import "YRHXForgetPWController.h"
//#import "AFNetworking.h"
#import "YRHXLoginModel.h"
#import "YRHXRegisterViewController.h"

@interface YRHXLoginController ()

@property(nonatomic,strong) UITextField * messageTF;
@property(nonatomic,strong) UITextField * passwordTF;


@end

@implementation YRHXLoginController

//显示导航栏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //显示导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 清空阴影图片
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    // 取消半透明效果
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    
    //添加手势 ---》键盘
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    //搭建UI
    [self setupUI];
}

//点击空白处  键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.view endEditing:YES];
}


//监听方法
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (void)setupUI
{
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 17.5, [UIScreen mainScreen].bounds.size.width, 105)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UIImageView * phoneImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"手机图标"]];
    [backView addSubview:phoneImg];
    [phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(10);
        make.left.offset(17.5);
        make.width.height.offset(33.5);
    }];
    
    _messageTF = [[UITextField alloc]init];
    _messageTF.placeholder = @"请输入手机号";
    _messageTF.keyboardType = UIKeyboardTypeNumberPad;
    [backView addSubview:_messageTF];
    [_messageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneImg.mas_right).offset(5);
        make.centerY.equalTo(phoneImg);
        make.right.equalTo(backView).offset(0);
    }];
    
    UILabel * whiteLineLabel = [[UILabel alloc]init];
    whiteLineLabel.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:whiteLineLabel];
    [whiteLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(phoneImg.mas_bottom).offset(10);
    }];
    
    UIImageView * passwordImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码"]];
    [backView addSubview:passwordImg];
    [passwordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteLineLabel).offset(10);
        make.left.equalTo(backView).offset(17.5);
        make.width.height.offset(33.5);
    }];
    
    _passwordTF = [[UITextField alloc]init];
    _passwordTF.placeholder = @"请输入密码";
    //隐藏输入的密码
    _passwordTF.secureTextEntry = YES;
    [backView addSubview:_passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordImg.mas_right).offset(5);
        make.centerY.equalTo(passwordImg);
        make.right.equalTo(backView).offset(0);
    }];
    
    //忘记密码？
    UIButton * forgetBtn = [[UIButton alloc]init];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor colorWithHexString:@"#1294f6"] forState:UIControlStateNormal];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(backView.mas_bottom).offset(10);
        make.width.offset(75);
        make.height.offset(25);
    }];
    //监听事件
    [forgetBtn addTarget:self action:@selector(forgetButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(forgetBtn.mas_left).offset(-10);
        make.height.offset(15);
        make.centerY.equalTo(forgetBtn);
        make.width.offset(1);
    }];
    
    
    //注册账号
    UIButton * registerBtn = [[UIButton alloc]init];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"#1294f6"] forState:UIControlStateNormal];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(forgetBtn.mas_left).offset(-10);
        make.centerY.equalTo(forgetBtn);
        make.width.offset(70);
        make.height.offset(25);
    }];
    //监听事件
    [registerBtn addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton * loginBtn = [[UIButton alloc]init];
    [self.view addSubview:loginBtn];
    loginBtn.clipsToBounds = YES;
    loginBtn.layer.cornerRadius=10;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"#1294f6"];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(registerBtn.mas_bottom).offset(17.5);
        make.right.equalTo(self.view).offset(-15);
        make.height.offset(47.5);
    }];
    
    [loginBtn addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)registerButtonClick
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YRHXRegisterViewController" bundle:nil];
    YRHXRegisterViewController * registerVc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:registerVc animated:YES];
}

- (void)forgetButtonClick
{
    YRHXForgetPWController * forgetVc = [[YRHXForgetPWController alloc]init];
    [self.navigationController pushViewController:forgetVc animated:YES];
}

//登录
- (void)loginButtonClick
{
    if ([self.messageTF.text isEqualToString:@""]) {
        [self cueMessage:@"请输入账号"];
        
    }
    if ([self.passwordTF.text isEqualToString:@""]) {
        [self cueMessage:@"请输入密码"];
    }
    
    
    [YRHXLoginModel loadLogInWithMobile:self.messageTF.text withPwd:self.passwordTF.text success:^(NSDictionary *dict) {
        
        
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"denglu" object:nil userInfo:nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        NSLog(@"%@",dict);
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
        //首次登录成功，进去YRHXPersonInfoController 界面让用户补充资料
        //非首次。返回账户主界面
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failed:^(NSError *error) {
        
        NSLog(@"失败%@",error);
    }];
    
    
}
- (void)cueMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end
