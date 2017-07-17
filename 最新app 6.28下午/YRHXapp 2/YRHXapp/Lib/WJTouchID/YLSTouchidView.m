//
//  YLSTouchidView.m
//  popViewForTouchID
//
//  Created by yulingsong on 16/8/5.
//  Copyright © 2016年 yulingsong. All rights reserved.
//

#import "YLSTouchidView.h"
#import "YRHXLoginViewController.h"
#import "oViewController.h"

@interface YLSTouchidView()<WJTouchIDDelegate>

@property (nonatomic, strong) WJTouchID *touchID;

@property (nonatomic, strong) UIAlertController *alert;

@property (nonatomic, strong) UIButton * pwdBtn;  //密码登录按钮

@end

@implementation YLSTouchidView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:YLSScreenBounds];
    
    if (self)
    {
        self.backgroundColor = [UIColor lightGrayColor];
        
    }
    //调用指纹解锁
    WJTouchID *touchid = [[WJTouchID alloc]init];
    [touchid startWJTouchIDWithMessage:WJNotice(@"请验证指纹，进入应用", @"The Custom Message") fallbackTitle:WJNotice(@"", @"Fallback Title") delegate:self];
    self.touchID = touchid;
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

/**
 *  快速创建
 */
+ (instancetype)touchIDView
{
    return [[self alloc]init];
}

/** 弹出 */
- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)showInView:(UIView *)view
{
    // 浮现
    [view addSubview:self];
}


-(void)clickToCheckTouchID
{
    NSLog(@"点击了指纹解锁");
    [self.touchID startWJTouchIDWithMessage:WJNotice(@"请验证指纹，进入应用", @"The Custom Message") fallbackTitle:WJNotice(@"", @"Fallback Title") delegate:self];
}


/**
 *  TouchID验证成功
 */
- (void) WJTouchIDAuthorizeSuccess {
    [STTextHudTool showText:@"解锁成功"];
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self removeFromSuperview];
}

/**
 *  TouchID验证失败
 */
- (void) WJTouchIDAuthorizeFailure {
     [STTextHudTool showText:@"解锁失败"];
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  取消TouchID验证 (用户点击了取消)
 */


- (void) WJTouchIDAuthorizeErrorUserCancel {
    NSLog(@"点击了取消");
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    
//    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YRHXLoginViewController" bundle:nil];
//    YRHXLoginViewController * topUpVC = [sb instantiateInitialViewController];
    
    oViewController * topUpVC = [oViewController new];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:topUpVC animated:YES completion:^{
        [self removeFromSuperview];
}];
   

    
    
//    [self.touchID startWJTouchIDWithMessage:WJNotice(@"这里可以自定义", @"The Custom Message") fallbackTitle:WJNotice(@"按钮标题", @"Fallback Title") delegate:self];
}





//- (void)alertEvaluatePolicyWithTouchID
//{
//    [_alert dismissViewControllerAnimated:NO completion:nil];
//    self.rootViewController = [ViewController new];
//    _context = [LAContext new];
//    NSError *error;
//    //Whether the device support touch ID? ---if it's yes,support!Otherwise,the system version is lower than iOS8.
//    if([_context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
//    {
//        
//        NSLog(@"Yeah,Support touch ID");
//        
//        //if return yes,whether your fingerprint correct.
//        [_context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请验证指纹，进入应用" reply:^(BOOL success, NSError * _Nullable error) {
//            if (success)
//            {
//                [self imageViewShowAnimation];
//            }
//            else
//            {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self alertViewWithEnterPassword:YES];
//                });
//                
//                NSLog(@"fail");
//            }
//        }];
//    }
//    else
//    {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self alertViewWithEnterPassword:YES];
//        });
//        
//        NSLog(@"Sorry,The device doesn't support touch ID");
//    }
//    
//}


/**
 *  在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏...
 */
- (void) WJTouchIDAuthorizeErrorSystemCancel {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  无法启用TouchID,设备没有设置密码
 */
- (void) WJTouchIDAuthorizeErrorPasscodeNotSet {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  设备没有录入TouchID,无法启用TouchID
 */
- (void) WJTouchIDAuthorizeErrorTouchIDNotEnrolled {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  该设备的TouchID无效
 */
- (void) WJTouchIDAuthorizeErrorTouchIDNotAvailable {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
 */
- (void) WJTouchIDAuthorizeLAErrorTouchIDLockout {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
 */
- (void) WJTouchIDAuthorizeLAErrorAppCancel {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}

/**
 *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
 */
- (void) WJTouchIDAuthorizeLAErrorInvalidContext {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}
/**
 *  当前设备不支持指纹识别
 */
-(void)WJTouchIDIsNotSupport {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
}







@end
