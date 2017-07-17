//
//  YRHXForgetViewController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/19.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXForgetViewController.h"
#import "ZYKeyboardUtil.h"
#import "YRHXSendMessageModel.h"
#import "YRHXForgetModel.h"
#import "YRHXLoginViewController.h"
#import "STTextHudTool.h"

@interface YRHXForgetViewController ()

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性
@property (weak, nonatomic) IBOutlet UIButton *getBtn;

@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UITextField *newpwdTF;
@property (weak, nonatomic) IBOutlet UITextField *surePwdTF;
@property (weak, nonatomic) IBOutlet UITextField *messageTF;

@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;

@end

@implementation YRHXForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    __weak YRHXForgetViewController *weakSelf = self;
    
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.numberTF,weakSelf.newpwdTF,weakSelf.surePwdTF,weakSelf.messageTF,nil];
    }];
    
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
    }];
}


- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



//获取短信验证码
- (IBAction)getMessageBtnClick:(UIButton *)sender {
    
    if ([self.numberTF.text isEqualToString:@""] || !(self.numberTF.text.length == 11)) {
        [STTextHudTool showText:@"请输入正确的手机号"];
    }
   else if ([self.newpwdTF.text isEqualToString:@""]) {
       [STTextHudTool showText:@"请输入密码"];
    }
   else if ([self.surePwdTF.text isEqualToString:@""] || ![self.surePwdTF.text isEqualToString:self.newpwdTF.text]) {
       [STTextHudTool showText:@"密码有误，请重新输入确认密码"];
    }
    
    //    || ![self.yanzhengTF.text isEqualToString:self.codeStr]   yanzhengTF是图形码
    //根据发送的短信内容来判断  要短信的URL
    //   else if ((self.messageTF.text.length != 4) || [self.messageTF.text isEqualToString:@""] ) {
    //        [self cueMessage:@"请输入正确的图形验证码"];
    //    }

    
    
    else{
        [self getMessage]; //发送短信请求
    
        sender.userInteractionEnabled = NO;
        self.timeCount = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduce:) userInfo:sender repeats:YES];
    }
}

- (void)getMessage{
    
    //看type是不是1
    [YRHXSendMessageModel loadSendMessageWithNeedMobile:self.numberTF.text withType:1 success:^(NSString *sendMessageStr) {
        
        NSLog(@"%@____",sendMessageStr);
        
    } failed:^(NSError *error) {
        
        NSLog(@"%@====",error);
    }];
}

- (void)reduce:(NSTimer *)codeTimer{
    self.timeCount--;
    if (self.timeCount == 0) {
        [self.getBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.getBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
        
    }else{
        NSString *str = [NSString stringWithFormat:@"%zd秒",self.timeCount];
        [self.getBtn setTitle:str forState:UIControlStateNormal];
        self.getBtn.userInteractionEnabled = NO;
        
    }
}




//确定按钮
- (IBAction)makeSureBtnClick:(UIButton *)sender {
    
    if ([self.numberTF.text isEqualToString:@""] || !(self.numberTF.text.length == 11)) {
        [STTextHudTool showText:@"请输入正确的手机号"];
    }
   else if ([self.newpwdTF.text isEqualToString:@""]) {
       [STTextHudTool showText:@"请输入密码"];
    }
  else  if ([self.surePwdTF.text isEqualToString:@""] || ![self.surePwdTF.text isEqualToString:self.newpwdTF.text]) {
      [STTextHudTool showText:@"您两次输入的密码有误，请重新输入"];
    }
    
//    || ![self.yanzhengTF.text isEqualToString:self.codeStr]   yanzhengTF是图形码
//根据发送的短信内容来判断  要短信的URL     在下面的请求方法里面传给后台就好
//   else if ((self.messageTF.text.length != 4) || [self.messageTF.text isEqualToString:@""] ) {
//        [self cueMessage:@"请输入正确的图形验证码"];
//    }

    
    else
    {
        [YRHXForgetModel loadFrgetPWDWithUserMobile:self.numberTF.text withNewPwd:self.newpwdTF.text withSmsmsg:self.messageTF.text success:^(NSDictionary *registerDict) {
    
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"重置登录密码成功" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
            
            //返回到登录界面
            YRHXForgetViewController * loginVC = [YRHXForgetViewController new];
            [self.navigationController popToViewController:loginVC animated:YES];
            
            NSLog(@"chenggong==%@",registerDict);
        } failed:^(NSError *error) {
            
            NSLog(@"失败%@",error);
        }];
    }

}


@end
