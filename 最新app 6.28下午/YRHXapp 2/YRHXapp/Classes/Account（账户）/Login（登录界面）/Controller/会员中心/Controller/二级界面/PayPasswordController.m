//
//  PayPasswordController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/21.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "PayPasswordController.h"
#import "ZYKeyboardUtil.h"
#import "STTextHudTool.h"
#import "YRHXSendMessageModel.h"

@interface PayPasswordController ()

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;
@property (weak, nonatomic) IBOutlet UIButton *getMessageBtn;

@property (weak, nonatomic) IBOutlet UITextField *payPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTF;
@property (weak, nonatomic) IBOutlet UITextField *messageTF;

@property(assign, nonatomic) NSInteger timeCount;
@property(strong, nonatomic) NSTimer *timer;

@end

@implementation PayPasswordController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = nil;
    self.navigationController.navigationBarHidden = YES;
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    [self keyBoard];

    
    
}


- (IBAction)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    __weak PayPasswordController *weakSelf = self;
    
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.payPwdTF,weakSelf.confirmPwdTF,weakSelf.messageTF,nil];
    }];
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
    }];
}

//获取短信验证码
- (IBAction)getMessageButtonClick:(UIButton *)sender
{
    if ([self.payPwdTF.text isEqualToString:@""]) {   //不知道有没有位数限制
        [STTextHudTool showText:@"请输入正确的支付密码"];
    }
    else if ([self.confirmPwdTF.text isEqualToString:@""] || ![self.confirmPwdTF.text isEqualToString:self.payPwdTF.text]) {
        [STTextHudTool showText:@"您两次输入的密码有误，请重新输入"];
    }
    else
    {
        [self getMessage]; //发送短信请求
        
        sender.userInteractionEnabled = NO;
        self.timeCount = 60;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduce:) userInfo:sender repeats:YES];
    }
}


- (void)getMessage{
    
    //看type是不是1
//    [YRHXSendMessageModel loadSendMessageWithNeedMobile:self.numberTF.text withType:1 success:^(NSString *sendMessageStr) {
//        
//        NSLog(@"%@____",sendMessageStr);
//        
//    } failed:^(NSError *error) {
//        
//        NSLog(@"%@====",error);
//    }];
}

- (void)reduce:(NSTimer *)codeTimer{
    self.timeCount--;
    if (self.timeCount == 0) {
        [self.getMessageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        self.getMessageBtn.userInteractionEnabled = YES;
        [self.timer invalidate];
        
    }else{
        NSString *str = [NSString stringWithFormat:@"%zd秒",self.timeCount];
        [self.getMessageBtn setTitle:str forState:UIControlStateNormal];
        self.getMessageBtn.userInteractionEnabled = NO;
        
    }
}





- (IBAction)sureButtonClick:(UIButton *)sender
{
    if ([self.payPwdTF.text isEqualToString:@""]) {   //不知道有没有位数限制
        [STTextHudTool showText:@"请输入正确的支付密码"];
    }
    else if ([self.confirmPwdTF.text isEqualToString:@""] || ![self.confirmPwdTF.text isEqualToString:self.payPwdTF.text]) {
        [STTextHudTool showText:@"您两次输入的密码有误，请重新输入"];
    }
    else
    {
        // 短信验证码  在下面的请求方法里面传给后台就好
        
    }

}





@end
