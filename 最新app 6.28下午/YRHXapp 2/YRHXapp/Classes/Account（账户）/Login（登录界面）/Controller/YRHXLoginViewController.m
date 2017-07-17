//
//  YRHXLoginViewController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/18.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXLoginViewController.h"
#import "YRHXRegisterViewController.h"
#import "ZYKeyboardUtil.h"
#import "YRHXForgetViewController.h"
#import "YRHXLoginModel.h"
#import "STTextHudTool.h"
#import "YRHXMemberCenterController.h"
#import "YRHXTabbarController.h"

@interface YRHXLoginViewController ()

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@end

@implementation YRHXLoginViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    self.passWordTF.secureTextEntry = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏导航栏
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = nil;
    self.navigationController.navigationBarHidden = YES;

    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    [self keyBoard];

   
}

//键盘
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
    __weak YRHXLoginViewController *weakSelf = self;
    
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.phoneNumberTF,weakSelf.passWordTF,nil];
    }];
    
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
    }];
}


- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


//眼睛隐藏按钮
- (IBAction)eyesHideBtnClick:(UIButton *)sender {
    
    if (sender.tag == 0) {
        sender.tag = 1;
        //可见
        [sender setImage:[UIImage imageNamed:@"睁开"] forState:UIControlStateNormal];
        self.passWordTF.secureTextEntry = NO;
    }else{
        //隐藏密码
        sender.tag = 0;
        [sender setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        self.passWordTF.secureTextEntry = YES;
    }
}

//忘记密码按钮
- (IBAction)forgetPwdBtnClick:(UIButton *)sender {
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YRHXForgetViewController" bundle:nil];
    YRHXForgetViewController * forgetVc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:forgetVc animated:YES];
}

//注册按钮
- (IBAction)registerBtnClick:(UIButton *)sender {
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YRHXRegisterViewController" bundle:nil];
    YRHXRegisterViewController * registerVc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:registerVc animated:YES];

}



////判断手机号是否存在请求====================================
//- (void)judgeMobile{
//    [BXSendMessageModel loadJudgeMessageWithMobile:self.accountTF.text success:^(NSDictionary *JudgeMessageDict) {
//        _judgeDict = JudgeMessageDict;
//    } failed:^(NSError *error) {
//        DXLog(@"%@",error);
//    }];
//}
//




//登录按钮
- (IBAction)signInBtnClick:(UIButton *)sender {
    
    if ([self.phoneNumberTF.text isEqualToString:@""]) {
        [STTextHudTool showText:@"请输入手机号"];
    }
   else if ([self.passWordTF.text isEqualToString:@""]) {
       [STTextHudTool showText:@"请输入密码"];
    }
   else {
       
//        [YRHXLoginModel loadLogInWithMobile:self.phoneNumberTF.text withPwd:self.passWordTF.text success:^(NSDictionary *dict) {

//            //创建通知
//            NSNotification *notification =[NSNotification notificationWithName:@"denglu" object:nil userInfo:nil];
//            //通过通知中心发送通知
//            [[NSNotificationCenter defaultCenter] postNotification:notification];
//            NSLog(@"%@",dict);
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {

//                YRHXMemberCenterController * memberVC = [YRHXMemberCenterController new];
//                [self.navigationController pushViewController:memberVC animated:YES];
                YRHXTabbarController * accountVC = [YRHXTabbarController new];
                [self presentViewController:accountVC animated:NO completion:nil];
                
                /*要刷新一下数据，返回的界面要有东西*/
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
            //首次登录成功，进去YRHXPersonInfoController 界面让用户补充资料
            //非首次。返回账户主界面
            
//            [self.navigationController popViewControllerAnimated:YES];
//            
//        } failed:^(NSError *error) {
//            
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"登录失败" preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//
//            }]];
//            [self presentViewController:alert animated:YES completion:nil];
//            
//        }]; 
    }
}


@end
