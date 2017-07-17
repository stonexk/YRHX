//
//  YRHXForgetPWController.m
//  YRHXapp
//
//  Created by Apple on 2017/4/27.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXForgetPWController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "UILabel+CZAddition.h"
#import "MQVerCodeImageView.h"
#import "YRHXRegisterController.h"
#import "ZYKeyboardUtil.h"
#import <SMS_SDK/SMSSDK.h>
#import "YRHXForgetModel.h"
#import "YRHXLoginController.h"
#import "YRHXSendMessageModel.h"
#import "WSAuthCode.h"

@interface YRHXForgetPWController ()<UITextFieldDelegate>

//图形验证码
@property (nonatomic, strong) MQVerCodeImageView * picImageView;
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性
@property (nonatomic, strong) UITextField * phoneTF;
@property (nonatomic, strong) UITextField * phoneNewTF;
@property (nonatomic, strong) UITextField * confirmPWTF;
@property (nonatomic, strong) UITextField * yanzhengTF;
@property (nonatomic, strong) UITextField * messageTF;
//图形验证码
@property (strong, nonatomic)WSAuthCode * codeView;
@property (nonatomic, strong)  UIButton * getBtn;

@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;
@property(strong, nonatomic) NSString * codeStr;


@end


@implementation YRHXForgetPWController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = @"重置密码";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    //添加手势 -->键盘
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];

    [self keyBoard];
    
    [self setupUI];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


//点击空白处  键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.view endEditing:YES];
}


- (void)keyBoard
{
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
 
    [self configKeyBoardRespond];
}


- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] initWithKeyboardTopMargin:40];
    __weak YRHXForgetPWController *weakSelf = self;

    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.phoneTF,weakSelf.phoneNewTF,weakSelf.confirmPWTF,weakSelf.yanzhengTF,weakSelf.messageTF,
         nil];
    }];

    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {

    }];
}


- (void)setupUI
{
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 17.5, [UIScreen mainScreen].bounds.size.width, 150)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    
    
    UILabel * phoneLabel = [UILabel cz_labelWithText:@"手机号" fontSize:16 color:[UIColor blackColor]];
    [backView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.top.equalTo(backView).offset(15);
        make.width.offset(55);
    }];
    
    _phoneTF = [[UITextField alloc]init];
    _phoneTF.placeholder = @"请输入手机号";
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [backView addSubview:_phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel.mas_right).offset(5);
        make.centerY.equalTo(phoneLabel);
        make.right.equalTo(backView).offset(0);
    }];
    
    UILabel * whiteLineLabel1 = [[UILabel alloc]init];
    whiteLineLabel1.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:whiteLineLabel1];
    [whiteLineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(phoneLabel.mas_bottom).offset(15);
    }];

    
    
    UILabel * newPWLabel = [UILabel cz_labelWithText:@"新密码" fontSize:16 color:[UIColor blackColor]];
    [backView addSubview:newPWLabel];
    [newPWLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.top.equalTo(whiteLineLabel1.mas_bottom).offset(15);
        make.width.offset(55);
    }];
    
    _phoneNewTF = [[UITextField alloc]init];
    _phoneNewTF.placeholder = @"请输入新密码";
    _phoneNewTF.secureTextEntry = YES;
    [backView addSubview:_phoneNewTF];
    [_phoneNewTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newPWLabel.mas_right).offset(5);
        make.centerY.equalTo(newPWLabel);
        make.right.equalTo(backView).offset(0);
    }];
    
    UILabel * whiteLineLabel2 = [[UILabel alloc]init];
    whiteLineLabel2.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:whiteLineLabel2];
    [whiteLineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(newPWLabel.mas_bottom).offset(15);
    }];

  
    
    UILabel * confirmPWLabel = [UILabel cz_labelWithText:@"确认密码" fontSize:16 color:[UIColor blackColor]];
    [backView addSubview:confirmPWLabel];
    [confirmPWLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.top.equalTo(whiteLineLabel2.mas_bottom).offset(15);
//        make.width.offset(65);
    }];
    
    _confirmPWTF = [[UITextField alloc]init];
    _confirmPWTF.placeholder = @"请确认新密码";
    _confirmPWTF.secureTextEntry = YES;
    [backView addSubview:_confirmPWTF];
    [_confirmPWTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(confirmPWLabel.mas_right).offset(5);
        make.centerY.equalTo(confirmPWLabel);
        make.right.equalTo(backView).offset(0);
    }];
    

    
    
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(backView.mas_bottom).offset(17.5);
        make.height.offset(100);
    }];
    
    UILabel * yanzhengLabel = [UILabel cz_labelWithText:@"图形验证码" fontSize:16 color:[UIColor blackColor]];
    [bottomView addSubview:yanzhengLabel];
    [yanzhengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(17.5);
        make.top.equalTo(bottomView).offset(15);
        make.width.offset(85);
    }];
    
    
    _yanzhengTF = [[UITextField alloc]init];
    _yanzhengTF.placeholder = @"请输入图形码";
    [bottomView addSubview:_yanzhengTF];
    [_yanzhengTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yanzhengLabel.mas_right).offset(5);
        make.centerY.equalTo(yanzhengLabel);
        make.width.offset(screenBounds.size.width - 175);
    }];

    
//    //图形验证码View
//    _picImageView = [[MQVerCodeImageView alloc] initWithFrame:CGRectMake(screenBounds.size.width - 85, 190, 80, 40)];
//    [self.view addSubview:_picImageView];
//    
//    _picImageView.bolck = ^(NSString *imageCodeStr){//看情况是否需要
//        _codeStr = imageCodeStr;
////        NSLog(@"imageCodeStr = %@",imageCodeStr);
//    };
//    _picImageView.isRotation = NO;
//    [_picImageView freshVerCode];
//    
//    //点击刷新
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
//    [_picImageView addGestureRecognizer:tap];
//    [self.view addSubview: _picImageView];
//    
    
    _codeView = [[WSAuthCode alloc]initWithFrame:CGRectMake(KscreenWidth - 85, 190, 80, 40)];
    _codeView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_codeView];
    
    
    
    
    UILabel * whiteLineLabel3 = [[UILabel alloc]init];
    whiteLineLabel3.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:whiteLineLabel3];
    [whiteLineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(yanzhengLabel.mas_bottom).offset(15);
    }];
    


    
    UILabel * messageLabel = [UILabel cz_labelWithText:@"短信验证码" fontSize:16 color:[UIColor blackColor]];
    [bottomView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(17.5);
        make.top.equalTo(whiteLineLabel3.mas_bottom).offset(15);
        make.width.offset(85);
    }];
    
    _messageTF = [[UITextField alloc]init];
    _messageTF.placeholder = @"请输入短信验证码";
    _messageTF.keyboardType = UIKeyboardTypeNumberPad;
    [bottomView addSubview:_messageTF];
    [_messageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(messageLabel.mas_right).offset(5);
        make.centerY.equalTo(messageLabel);
//        make.width.offset(145);
        make.width.offset(screenBounds.size.width - 165);
    }];
    
    
    _getBtn = [[UIButton alloc]init];
    [_getBtn setTitle:@"获取" forState:UIControlStateNormal];
    _getBtn.layer.cornerRadius=3;
    _getBtn.backgroundColor = [UIColor colorWithHexString:@"#1294f6"];
    _getBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_getBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomView addSubview:_getBtn];
    
    [_getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(messageLabel);
        make.right.equalTo(bottomView.mas_right).offset(-15);
        make.width.offset(60);
        make.height.offset(25);
    }];
    
    [_getBtn addTarget:self action:@selector(getButton:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    
    
    UIButton * remakeBtn = [[UIButton alloc]init];
    [self.view addSubview:remakeBtn];
    remakeBtn.clipsToBounds = YES;
    remakeBtn.layer.cornerRadius=10;
    [remakeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [remakeBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    remakeBtn.backgroundColor = [UIColor colorWithHexString:@"#1294f6"];
    
    [remakeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(bottomView.mas_bottom).offset(15 );
        make.right.equalTo(self.view).offset(-15);
        make.height.offset(47.5);
    }];
    [remakeBtn addTarget:self action:@selector(remakeButtonClick) forControlEvents:UIControlEventTouchUpInside];

}

//验证码
- (void)reloadAction {
    [_codeView reloadAuthCodeView];
}


- (void)yanzhengAction {
    
    BOOL isOk = [_codeView startAuthWithString:_yanzhengTF.text];

    if (isOk) {
        [self cueMessage:@"匹配正确"];
        
    }else{
        [self cueMessage:@"验证码错误"];
        
        //这里面写验证失败之后的动作.
        [_codeView reloadAuthCodeView];
    }
}

- (void)getButton:(UIButton*)btn
{
    if ([self.phoneTF.text isEqualToString:@""] || !(self.phoneTF.text.length == 11)) {
        [self cueMessage:@"请输入正确的手机号"];
        
    }else{
                [self getMessage]; //发送短信请求
//        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTF.text
//                                       zone:@"86"
//                           customIdentifier:nil
//                                     result:^(NSError *error){
//                                         if (!error) {
//                                             NSLog(@"获取验证码成功");
//                                         } else {
//                                             NSLog(@"错误信息：%@",error);
//                                         }
//                                     }];
        
        
        
        btn.userInteractionEnabled = NO;
        self.timeCount = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:btn repeats:YES];
        
    }

}

//发送短信
- (void)getMessage{

    //看type是不是1
    [YRHXSendMessageModel loadSendMessageWithNeedMobile:self.phoneTF.text withType:1 success:^(NSString *sendMessageStr) {
        
        NSLog(@"%@____",sendMessageStr);
        
    } failed:^(NSError *error) {
        
        NSLog(@"%@====",error);
    }];
}




- (void)reduceTime:(NSTimer *)codeTimer{
    self.timeCount--;
    if (self.timeCount == 0) {
        [self.getBtn setTitle:@"获取" forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.getBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
        
    }else{
        NSString *str = [NSString stringWithFormat:@"(%zd)秒",self.timeCount];
        [self.getBtn setTitle:str forState:UIControlStateNormal];
        self.getBtn.userInteractionEnabled = NO;
        
    }
}


- (void)remakeButtonClick
{

    if ([self.phoneTF.text isEqualToString:@""] || !(self.phoneTF.text.length == 11)) {
        [self cueMessage:@"请输入正确的手机号"];
    }
    if ([self.phoneNewTF.text isEqualToString:@""]) {
        [self cueMessage:@"请输入密码"];
    }
    if ([self.confirmPWTF.text isEqualToString:@""] || ![self.confirmPWTF.text isEqualToString:self.phoneNewTF.text]) {
        [self cueMessage:@"您两次输入的密码有误，请重新输入"];
    }

    if ((self.yanzhengTF.text.length != 4) || [self.yanzhengTF.text isEqualToString:@""] || ![self.yanzhengTF.text isEqualToString:self.codeStr]) {
        [self cueMessage:@"请输入正确的图形验证码"];
    }
    //根据发送的短信内容来判断  要短信的URL
    //    if (self.messageTF.text ) {
    //        <#statements#>
    //    }
    

    
    [YRHXForgetModel loadFrgetPWDWithUserMobile:self.phoneTF.text withNewPwd:self.phoneNewTF.text withSmsmsg:self.messageTF.text success:^(NSDictionary *registerDict) {
       
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"密码修改成功" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
        //返回到登录界面
        YRHXLoginController * loginVC = [YRHXLoginController new];
        [self.navigationController popToViewController:loginVC animated:YES];
        
        NSLog(@"chenggong==%@",registerDict);
        
    } failed:^(NSError *error) {
     
        NSLog(@"失败%@",error);
    }];
    
    
//    //短信
//    [SMSSDK commitVerificationCode:_messageTF.text phoneNumber:self.phoneTF.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
//        
//        {
//            if (!error)
//            {
//                
//                UIViewController * registerVc = [[UIViewController alloc]init];
//                [self.navigationController pushViewController:registerVc animated:YES];
//                
//                
//                NSLog(@"验证成功");
//            }
//            else
//            {
//                NSLog(@"错误信息:%@",error);
//            }
//        }
//    }];
    
    

}


- (void)cueMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}


////图形验证码的点击方法
//- (void)tapClick:(UITapGestureRecognizer*)tap
//{
//    [_picImageView freshVerCode];
//}

@end
