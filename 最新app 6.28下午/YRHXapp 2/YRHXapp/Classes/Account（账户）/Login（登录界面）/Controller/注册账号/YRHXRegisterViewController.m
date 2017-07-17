//
//  YRHXRegisterViewController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/19.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXRegisterViewController.h"
#import "ZYKeyboardUtil.h"
#import "YRHXSendMessageModel.h"
#import "YRHXRegisterModel.h"
#import "YRHXLoginViewController.h"
#import "RegisterPopWindowVC.h"
#import "STTextHudTool.h"

@interface YRHXRegisterViewController ()

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性

@property (weak, nonatomic) IBOutlet UIButton *getButton;//获取短信验证码
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;//昵称
@property (weak, nonatomic) IBOutlet UITextField *numTF;//手机号
@property (weak, nonatomic) IBOutlet UITextField *PWTF;//密码
@property (weak, nonatomic) IBOutlet UITextField *confirmPWTF;//确认密码
@property (weak, nonatomic) IBOutlet UITextField *othersTF;//推荐人手机
@property (weak, nonatomic) IBOutlet UITextField *messageTF; //短信验证码


@property (assign, nonatomic) NSInteger timeCount;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation YRHXRegisterViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = nil;
    self.navigationController.navigationBarHidden = YES;  //隐藏导航栏
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    [self keyBoard];
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
    __weak YRHXRegisterViewController *weakSelf = self;
  
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.nickNameTF,weakSelf.numTF,weakSelf.PWTF,weakSelf.confirmPWTF,weakSelf.othersTF,weakSelf.messageTF,nil];
    }];
    
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
    }];
}


- (IBAction)backBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//获取短信验证码按钮
- (IBAction)getBtnClick:(UIButton *)sender {
    if ([self.nickNameTF.text isEqualToString:@""] || (self.nickNameTF.text.length > 10)) {
        [STTextHudTool showText:@"请输入正确的昵称"];
    }
    else if ([self.numTF.text isEqualToString:@""] || !(self.numTF.text.length == 11)) {
        [STTextHudTool showText:@"请输入正确的手机号码"];
    }
   else if ([self.PWTF.text isEqualToString:@""]) {
       [STTextHudTool showText:@"请输入密码"];
    }
   else if ([self.confirmPWTF.text isEqualToString:@""] || ![self.confirmPWTF.text isEqualToString:self.PWTF.text]) {
       [STTextHudTool showText:@"您两次输入的密码有误，请重新输入"];
    }
   else if (![self.othersTF.text isEqualToString:@""] && !(self.othersTF.text.length == 11)) {
       [STTextHudTool showText:@"请输入正确的推荐人手机号"];
    }
    //  else  if ((self.yanzhengTF.text.length != 4) || [self.yanzhengTF.text isEqualToString:@""] || ![self.yanzhengTF.text isEqualToString:self.str]) {
    //        [self cueMessage:@"请输入正确的图形验证码"];
    //    }
    //根据发送的短信内容来判断  要短信的URL
    //  else  if (self.messageTF.text ) {
    //        <#statements#>
    //    }
    
    
    else{
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
        [self.getButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.getButton.userInteractionEnabled = YES;
        [self.timer invalidate];
        
    }else{
        NSString *str = [NSString stringWithFormat:@"%zd秒",self.timeCount];
        [self.getButton setTitle:str forState:UIControlStateNormal];
        self.getButton.userInteractionEnabled = NO;
    }
}




////判断手机号是否存在请求====================================
//- (void)judgeMobile{
//    [BXSendMessageModel loadJudgeMessageWithMobile:self.accountTF.text success:^(NSDictionary *JudgeMessageDict) {
//        _judgeDict = JudgeMessageDict;
//    } failed:^(NSError *error) {
//        DXLog(@"%@",error);
//    }];
//}




//注册按钮
- (IBAction)registerBtnClick:(UIButton *)sender {
//    if ([self.nickNameTF.text isEqualToString:@""] || (self.nickNameTF.text.length > 10)) {
//        [STTextHudTool showText:@"请输入正确的昵称"];
//    }
//   else if ([self.numTF.text isEqualToString:@""] || !(self.numTF.text.length == 11)) {
//       [STTextHudTool showText:@"请输入正确的手机号码"];
//    }
//   else if ([self.PWTF.text isEqualToString:@""]) {
//       [STTextHudTool showText:@"请输入密码"];
//    }
//   else if ([self.confirmPWTF.text isEqualToString:@""] || ![self.confirmPWTF.text isEqualToString:self.PWTF.text]) {
//       [STTextHudTool showText:@"您两次输入的密码有误，请重新输入"];
//    }
//   else if (![self.othersTF.text isEqualToString:@""] && !(self.othersTF.text.length == 11)) {
//       [STTextHudTool showText:@"请输入正确的推荐人手机号"];
//    }
//    
//    
////      else if ((self.yanzhengTF.text.length != 4) || [self.yanzhengTF.text isEqualToString:@""] || ![self.yanzhengTF.text isEqualToString:self.str]) {
////            [self cueMessage:@"请输入正确的图形验证码"];
////        }
////    根据发送的短信内容来判断  要短信的URL   在下面的请求方法里面传给后台就好
////       else if (self.messageTF.text ) {
////            <#statements#>
////        }
//    
//    
//    else{
//        
//        [YRHXRegisterModel loadRegisterWithUserMobile:self.numTF.text withLoginPasswd:self.PWTF.text withUserName:self.nickNameTF.text withUCheckCode:self.messageTF.text withFMobile:self.othersTF.text success:^(NSDictionary *registerDict) {
//            
//                    //把用户名存储下来

            
            //3注册成功后。弹框“注册成功”   返回上一个界面--》登录界面
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//                
//                
//                UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YRHXRegisterViewController" bundle:nil];
//                RegisterPopWindowVC * vc = [sb instantiateViewControllerWithIdentifier:@"RegisterPopWindowVC"];
//                vc.providesPresentationContextTransitionStyle = YES;
//                vc.definesPresentationContext = YES;
//                vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//                [self presentViewController:vc animated:NO completion:nil];
//                
//
//                
//                [self.navigationController popViewControllerAnimated:YES];
//            }]];
//            [self presentViewController:alert animated:YES completion:nil];
//    
//    
//            //返回到登录界面
//            YRHXLoginViewController * loginVC = [YRHXLoginViewController new];
//            [self.navigationController popToViewController:loginVC animated:YES];
//    
//    
//    
    
    
    
    //3注册成功后。弹框“注册成功”   返回上一个界面--》登录界面
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
        
       //优惠券 多了一个红包
        
        
        
        
        
        
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
    //返回到登录界面
    YRHXLoginViewController * loginVC = [YRHXLoginViewController new];
    [self.navigationController popToViewController:loginVC animated:YES];
    
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YRHXRegisterViewController" bundle:nil];
    RegisterPopWindowVC * vc = [sb instantiateViewControllerWithIdentifier:@"RegisterPopWindowVC"];
    vc.providesPresentationContextTransitionStyle = YES;
    vc.definesPresentationContext = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:NO completion:nil];
    
    
    

    
//            NSLog(@"~~~%@",registerDict);
//        } failed:^(NSError *error) {
//
//            NSLog(@"失败%@",error);
//        }];
//    }
}



@end
