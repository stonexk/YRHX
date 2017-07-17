//
//  YRHXRegisterController.m
//  YRHXapp
//
//  Created by Apple on 2017/4/26.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXRegisterController.h"
#import "UIColor+ColorChange.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
#import "MQVerCodeImageView.h"
#import "AppDelegate.h"
#import <SMS_SDK/SMSSDK.h>
#import "ZYKeyboardUtil.h"
#import "YRHXRegisterModel.h"
#import "YRHXLoginController.h"
#import "YRHXSendMessageModel.h"
#import "YRHXNetWorkTool.h"
#import "UIImageView+WebCache.h"
#import "WSAuthCode.h"
#import "YRHXAccountController.h"

@interface YRHXRegisterController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITableViewCell *cell;
//图形验证码
@property (nonatomic, strong) MQVerCodeImageView * codeImage;

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性
@property (strong, nonatomic) UITextField * nickNameTF;    //昵称
@property (strong, nonatomic) UITextField * PWTF;   //密码
@property (strong, nonatomic) UITextField * numTF;   //手机号
@property (strong, nonatomic)UITextField * confirmPWTFl;   //确认密码
@property (strong, nonatomic)UITextField * othersTF;    //推荐人手机
@property (strong, nonatomic)UITextField * yanzhengTF;     //图形验证码TF
//图形验证码
@property (strong, nonatomic)WSAuthCode * wsCode;
@property (strong, nonatomic) UITextField * messageTF;     //短信验证码
@property (strong, nonatomic) UIButton * btn1;  //获取按钮

@property (strong, nonatomic) NSString * str; //图形码对应的

@property (assign, nonatomic) NSInteger timeCount;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIButton * codeBtn;
@property (strong, nonatomic) UIImageView * codeview;

@end

static NSString * cellID = @"cellID";


@implementation YRHXRegisterController

UITableViewCell *cell;  //全局变量


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
    
    self.navigationItem.title = @"注册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //添加手势 ---》键盘
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];


    [self keyBoard];
    
    [self setupUI];
    
}

- (void)keyBoard
{
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    

    [self configKeyBoardRespond];
}


- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] initWithKeyboardTopMargin:40];
    __weak YRHXRegisterController *weakSelf = self;
    
//全自动键盘弹出/收起处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
    
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.nickNameTF,weakSelf.PWTF,weakSelf.numTF,weakSelf.confirmPWTFl,weakSelf.othersTF,weakSelf.yanzhengTF,weakSelf.messageTF, nil];
    }];

//获取键盘信息
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
        NSLog(@"\n\n拿到键盘信息 和 ZYKeyboardUtil对象");
    }];
}








- (void)setupUI
{
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 17.5, [UIScreen mainScreen].bounds.size.width, 200)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    
    
    UILabel * nickNameLabel = [UILabel cz_labelWithText:@"昵称" fontSize:16 color:[UIColor blackColor]];
    [whiteView addSubview:nickNameLabel];
    [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView).offset(15);
        make.top.equalTo(whiteView).offset(15);
        make.width.offset(55);
    }];
    
    
    _nickNameTF = [[UITextField alloc]init];
    _nickNameTF.placeholder = @"昵称需为1-10个字，不能全为数字";
    [whiteView addSubview:_nickNameTF];
    [_nickNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nickNameLabel.mas_right).offset(5);
        make.centerY.equalTo(nickNameLabel);
        make.right.equalTo(whiteView).offset(0);
    }];
    
    UILabel * whiteLineLabel1 = [[UILabel alloc]init];
    whiteLineLabel1.backgroundColor = [UIColor lightGrayColor];
    [whiteView addSubview:whiteLineLabel1];
    [whiteLineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(nickNameLabel.mas_bottom).offset(15);
    }];
    
    
    
    UILabel * numLabel = [UILabel cz_labelWithText:@"手机号" fontSize:16 color:[UIColor blackColor]];
    [whiteView addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView).offset(17.5);
        make.top.equalTo(whiteLineLabel1.mas_bottom).offset(15);
//        make.width.offset(55);
    }];
    
    _numTF = [[UITextField alloc]init];
    _numTF.placeholder = @"请输入手机号";
    _numTF.keyboardType = UIKeyboardTypeNumberPad;
    [whiteView addSubview:_numTF];
    [_numTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numLabel.mas_right).offset(5);
        make.centerY.equalTo(numLabel);
        make.right.equalTo(whiteView).offset(0);
    }];
    
    UILabel * whiteLineLabel2 = [[UILabel alloc]init];
    whiteLineLabel2.backgroundColor = [UIColor lightGrayColor];
    [whiteView addSubview:whiteLineLabel2];
    [whiteLineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(numLabel.mas_bottom).offset(15);
    }];
    
    
    
    UILabel * PWLabel = [UILabel cz_labelWithText:@"密码" fontSize:16 color:[UIColor blackColor]];
    [whiteView addSubview:PWLabel];
    [PWLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView).offset(17.5);
        make.top.equalTo(whiteLineLabel2.mas_bottom).offset(15);
        //        make.width.offset(65);
    }];
    
    _PWTF = [[UITextField alloc]init];
    _PWTF.placeholder = @"请输入密码";
    _PWTF.secureTextEntry = YES;
    [whiteView addSubview:_PWTF];
    [_PWTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PWLabel.mas_right).offset(5);
        make.centerY.equalTo(PWLabel);
        make.right.equalTo(whiteView).offset(0);
    }];
    
    
    UILabel * whiteLineLabel3 = [[UILabel alloc]init];
    whiteLineLabel3.backgroundColor = [UIColor lightGrayColor];
    [whiteView addSubview:whiteLineLabel3];
    [whiteLineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(PWLabel.mas_bottom).offset(15);
    }];

    
    UILabel * confirmLabel = [UILabel cz_labelWithText:@"确认密码" fontSize:16 color:[UIColor blackColor]];
    [whiteView addSubview:confirmLabel];
    [confirmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView).offset(17.5);
        make.top.equalTo(whiteLineLabel3.mas_bottom).offset(13);
//        make.width.offset(55);
    }];
    
    _confirmPWTFl = [[UITextField alloc]init];
    _confirmPWTFl.placeholder = @"请再输一遍密码";
    _confirmPWTFl.secureTextEntry = YES;
    [whiteView addSubview:_confirmPWTFl];
    [_confirmPWTFl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(confirmLabel.mas_right).offset(5);
        make.centerY.equalTo(confirmLabel);
        make.right.equalTo(whiteView).offset(0);
    }];
    

    
    
    
    UIView * footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(whiteView.mas_bottom).offset(17.5);
        make.height.offset(155);
    }];
    
    
    UILabel * othersLabel = [UILabel cz_labelWithText:@"推荐人手机" fontSize:16 color:[UIColor blackColor]];
    [footView addSubview:othersLabel];
    [othersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(17.5);
        make.top.equalTo(footView).offset(15);
        make.width.offset(100);
    }];
    
    _othersTF = [[UITextField alloc]init];
    _othersTF.placeholder = @"请输入推荐人手机号(选填)";
    _othersTF.keyboardType = UIKeyboardTypeNumberPad;
    [footView addSubview:_othersTF];
    [_othersTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(othersLabel.mas_right).offset(5);
        make.centerY.equalTo(othersLabel);
        make.right.equalTo(footView).offset(0);
    }];
    

    UILabel * whiteLineLabel4 = [[UILabel alloc]init];
    whiteLineLabel4.backgroundColor = [UIColor lightGrayColor];
    [footView addSubview:whiteLineLabel4];
    [whiteLineLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(othersLabel.mas_bottom).offset(15);
    }];
    
    
    UILabel * yanzhengLabel = [UILabel cz_labelWithText:@"图形验证码" fontSize:16 color:[UIColor blackColor]];
    [footView addSubview:yanzhengLabel];
    [yanzhengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(17.5);
        make.top.equalTo(whiteLineLabel4.mas_bottom).offset(15);
        make.width.offset(85);
    }];
    
    
    _yanzhengTF = [[UITextField alloc]init];
    _yanzhengTF.placeholder = @"请输入图形码";
    [footView addSubview:_yanzhengTF];
    [_yanzhengTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yanzhengLabel.mas_right).offset(5);
        make.centerY.equalTo(yanzhengLabel);
//        make.width.offset(145);
        make.width.offset(screenBounds.size.width - 175);
    }];
    
    
//    _codeImage = [[MQVerCodeImageView alloc] initWithFrame:CGRectMake(screenBounds.size.width - 85, 290, 80, 40)];
//    [self.view addSubview:_codeImage];
//    
//    _codeImage.bolck = ^(NSString *imageCodeStr){//看情况是否需要
//        _str = imageCodeStr;
////        NSLog(@" %@  %@ ",imageCodeStr,_str);
//    };
//    _codeImage.isRotation = NO;
//    [_codeImage freshVerCode];
//    
//    //点击刷新
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
//    [_codeImage addGestureRecognizer:tap];
//    [self.view addSubview: _codeImage];
    
    _wsCode = [[WSAuthCode alloc]initWithFrame:CGRectMake(screenBounds.size.width - 85, 290, 80, 40)];
    _wsCode.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_wsCode];
    
    
    
    
//    _codeBtn = [[UIButton alloc]init];
////                          WithFrame:CGRectMake(screenBounds.size.width - 85, 290, 80, 40)];
//    [footView addSubview:_codeBtn];
//    _codeBtn.backgroundColor = [UIColor redColor];
//    [_codeBtn setImage:[UIImage imageNamed:@"银行卡"] forState:UIControlStateNormal];
//    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset(-5);
//        make.centerY.equalTo(yanzhengLabel);
//        make.width.offset(80);
//        make.height.offset(40);
//    }];
//    
//    [_codeBtn addTarget:self action:@selector(getCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel * whiteLineLabel5 = [[UILabel alloc]init];
    whiteLineLabel5.backgroundColor = [UIColor lightGrayColor];
    [footView addSubview:whiteLineLabel5];
    [whiteLineLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(yanzhengLabel.mas_bottom).offset(15);
    }];
    
    
    
    
    UILabel * messageLabel = [UILabel cz_labelWithText:@"短信验证码" fontSize:16 color:[UIColor blackColor]];
    [footView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(17.5);
        make.top.equalTo(whiteLineLabel5.mas_bottom).offset(15);
        make.width.offset(85);
    }];
    
    _messageTF = [[UITextField alloc]init];
    _messageTF.placeholder = @"请输入短信验证码";
    _messageTF.keyboardType = UIKeyboardTypeNumberPad;
    [footView addSubview:_messageTF];
    [_messageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(messageLabel.mas_right).offset(5);
        make.centerY.equalTo(messageLabel);
        make.width.offset(screenBounds.size.width - 165);
    }];
    
    
    _btn1 = [[UIButton alloc]init];
    [_btn1 setTitle:@"获取" forState:UIControlStateNormal];
    _btn1.layer.cornerRadius=3;
    _btn1.backgroundColor = [UIColor colorWithHexString:@"#1294f6"];
    [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [footView addSubview:_btn1];
    
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(messageLabel);
        make.right.equalTo(footView.mas_right).offset(-15);
        make.width.offset(60);
        make.height.offset(25);
    }];
    
    [_btn1 addTarget:self action:@selector(getBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
 
    UIButton * remakeBtn = [[UIButton alloc]init];
    [self.view addSubview:remakeBtn];
    remakeBtn.clipsToBounds = YES;
    remakeBtn.layer.cornerRadius=10;
    [remakeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [remakeBtn setTitle:@"注册" forState:UIControlStateNormal];
    remakeBtn.backgroundColor = [UIColor colorWithHexString:@"#1294f6"];
    
    [remakeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(footView.mas_bottom).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.offset(47.5);
    }];
    
    //    监听方法
    [remakeBtn addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];

    
}

//验证码
- (void)reloadAction {
    [_wsCode reloadAuthCodeView];
}


- (void)yanzhengAction {
    
    BOOL isOk = [_wsCode startAuthWithString:_yanzhengTF.text];
    
    
    
    if (isOk) {
        [self cueMessage:@"匹配正确"];
        
    }else{
        [self cueMessage:@"验证码错误"];
 
        //这里面写验证失败之后的动作.
        [_wsCode reloadAuthCodeView];
    }

}

////获取图形验证码
//- (void)getCodeBtnClick:(UIButton *)btn
//{
//    [[YRHXNetWorkTool shared] requestMethod:GET urlString:@"http://192.168.2.188:8080/captcha4sys?" parameters:@{@"v":@0.555} success:^(id responseObject) {
//  
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            
//            NSLog(@"回到主线程");
//     
//        }];
//     
//        NSLog(@"chegngong====%@",responseObject);
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"shibai");
//    }];
//
  //不用这个。直接自己判断
//
//    
//    NSString *urlStr = @"http://192.168.2.188:8080/captcha4sys?";
//    
//    NSURL *url = [NSURL URLWithString:urlStr];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    
//    request.HTTPMethod = @"GET";
//
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//
//    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        if (error) {
//
//            NSLog(@"%@==",error);
//        }else
//            
//        {
//            [_codeBtn setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
//
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                        // 更UI
//                        UIButton * b = [[UIButton alloc]initWithFrame:CGRectMake(screenBounds.size.width - 85, 290, 80, 40)];
//                        b.imageView.image = _codeBtn.imageView.image;
//                        [self.view addSubview:b];
//                        
//                        NSData * imageData = [[NSData alloc]initWithData:data];
//                        [b setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
//                        
//                        
//                        NSLog(@"啦啦%@ \n %@ \n %@ ",data,response,imageData);
//                
//                [self.view layoutIfNeeded];
//                    }];
//        }
//        
//    }];
//    
//    [task resume];
//    
//}



- (void)getBtnClick:(UIButton *)sender
{

    if ([self.numTF.text isEqualToString:@""] || !(self.numTF.text.length == 11)) {
        [self cueMessage:@"请输入正确的手机号"];
        
    }else{
        [self getMessage]; //发送短信请求

        sender.userInteractionEnabled = NO;
        self.timeCount = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:sender repeats:YES];
        
    }

}
- (void)getMessage{

    [YRHXSendMessageModel loadSendMessageWithNeedMobile:self.numTF.text withType:0 success:^(NSString *sendMessageStr) {
        
        NSLog(@"%@____",sendMessageStr);
        
    } failed:^(NSError *error) {
        
        NSLog(@"%@====",error);
    }];
}



- (void)reduceTime:(NSTimer *)codeTimer{
    self.timeCount--;
    if (self.timeCount == 0) {
        [self.btn1 setTitle:@"获取" forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.btn1.userInteractionEnabled = YES;
        [self.timer invalidate];
        
    }else{
        NSString *str = [NSString stringWithFormat:@"(%lu)秒",self.timeCount];
        [self.btn1 setTitle:str forState:UIControlStateNormal];
        self.btn1.userInteractionEnabled = NO;
        
    }
}





- (void)registerButtonClick
{
    //验证图形验证码
     [self yanzhengAction];
    
    
    if ([self.nickNameTF.text isEqualToString:@""] || (self.nickNameTF.text.length > 10)) {
        [self cueMessage:@"请输入正确的昵称"];
    }
    if ([self.numTF.text isEqualToString:@""] || !(self.numTF.text.length == 11)) {
        [self cueMessage:@"请输入正确的手机号码"];
    }
    if ([self.PWTF.text isEqualToString:@""]) {
        [self cueMessage:@"请输入密码"];
    }
    if ([self.confirmPWTFl.text isEqualToString:@""] || ![self.confirmPWTFl.text isEqualToString:self.PWTF.text]) {
//        [self cueMessage:@"请输入确认密码"];
        [self cueMessage:@"您两次输入的密码有误，请重新输入"];
    }
    if (![self.othersTF.text isEqualToString:@""] && !(self.othersTF.text.length == 11)) {
        [self cueMessage:@"请输入正确的推荐人手机号"];
    }
//    if ((self.yanzhengTF.text.length != 4) || [self.yanzhengTF.text isEqualToString:@""] || ![self.yanzhengTF.text isEqualToString:self.str]) {
//        [self cueMessage:@"请输入正确的图形验证码"];
//    }
    //根据发送的短信内容来判断  要短信的URL
//    if (self.messageTF.text ) {
//        <#statements#>
//    }



    [YRHXRegisterModel loadRegisterWithUserMobile:self.numTF.text withLoginPasswd:self.PWTF.text withUserName:self.nickNameTF.text withUCheckCode:self.messageTF.text withFMobile:self.othersTF.text success:^(NSDictionary *registerDict) {
        
//        //把用户名存储下来
//        NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
//        [userDefault setObject:uid forKey:@"uid"];
//        //        [userDefault setObject:[NSString stringWithFormat:@"%lu",self.textContentId] forKey:@"role"];
//        //        [userDefault setObject:@"0" forKey:@"ly"];
//        [userDefault setObject:self.accountTF.text forKey:@"mobile"];
        
//3注册成功后。弹框“注册成功”   返回上一个界面--》登录界面
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
        //返回到登录界面
        YRHXLoginController * loginVC = [YRHXLoginController new];
        [self.navigationController popToViewController:loginVC animated:YES];
        
        NSLog(@"~~~%@",registerDict);
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



- (void)RClick:(UIButton *)button
{

    //    //2短信发送成功后，如果昵称只有数字。提示“不能全为数字”
    //    //3注册成功后。弹框“注册成功”   返回上一个界面--》登录界面

    YRHXAccountController * view = [[YRHXAccountController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
    NSLog(@"点击了获注册");
}


//监听方法
- (void)back {
    
    //在需要接收的界面再
//    if (self.ZWBlock0) {
//        self.ZWBlock0(self.numLabel.text);
//    }
    
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



////图形验证码的点击方法
//- (void)tapClick:(UITapGestureRecognizer*)tap
//{
//    [_codeImage freshVerCode];
//}

















@end
