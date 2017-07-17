//
//  YRHXCarryOnCreditorController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/27.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXCarryOnCreditorController.h"
#import "ZYKeyboardUtil.h"
#import "WSAuthCode.h"
#import "UILabel+CZAddition.h"
#import "UIColor+ColorChange.h"
#import "Masonry.h"


@interface YRHXCarryOnCreditorController ()

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性
@property (weak, nonatomic) IBOutlet UITextField *payPwdTF;    //支付密码TF
@property (weak, nonatomic) IBOutlet UITextField *yanzhengTF;    //验证码TF
@property (strong, nonatomic)WSAuthCode * wsCode;

@property (nonatomic ,strong) UIView * deliverView; //底部View
@property (nonatomic ,strong) UIView * BGView; //遮罩

@end

@implementation YRHXCarryOnCreditorController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = @"承接债权";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    [self keyBoard];
    
    
    
    _wsCode = [[WSAuthCode alloc]initWithFrame:CGRectMake(screenBounds.size.width - 85, 390, 70, 30)];
    _wsCode.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_wsCode];

    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

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
    __weak YRHXCarryOnCreditorController *weakSelf = self;
    
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.payPwdTF,weakSelf.yanzhengTF,nil];
    }];
    
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
    }];
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
- (void)cueMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}


//确认承接按钮
- (IBAction)confirmCreditorBtnClick:(UIButton *)sender
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
    self.deliverView.frame = CGRectMake((KscreenWidth-230)/2, 250, 230, 70);
    self.deliverView.layer.cornerRadius = 5;
    self.deliverView.backgroundColor = [UIColor whiteColor];
    [appWindow addSubview:self.deliverView];
    
    //View出现动画
    self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, KscreenHeight);
    [UIView animateWithDuration:0.4 animations:^{
        self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
    }];
    
    ////底部View上的控件
    UILabel * titleLab = [UILabel cz_labelWithText:@"成功承接债权" fontSize:18 color:[UIColor darkGrayColor]];
    [self.deliverView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.deliverView).offset(10);
        make.centerY.equalTo(self.deliverView).offset(0);
    }];
    
    UIImageView * picImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"redTick"]];
    [self.deliverView addSubview:picImg];
    [picImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab);
        make.right.equalTo(titleLab.mas_left).offset(-5);
        make.width.height.offset(23.5);
    }];
    
//    UILabel * detailab = [UILabel cz_labelWithText:@"满标后开始计息" fontSize:16 color:[UIColor darkGrayColor]];
//    [self.deliverView addSubview:detailab];
//    [detailab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.deliverView);
//        make.bottom.offset(-20);
//    }];
}


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
    
    [self.navigationController popViewControllerAnimated:YES];
}






@end
