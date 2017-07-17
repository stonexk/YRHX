//
//  AppDelegate.m
//  YRHX
//
//  Created by 詹稳 on 17/4/18.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "AppDelegate.h"
#import "YRHXTabbarController.h"
#import<SMS_SDK/SMSSDK.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "TouchWindow.h"
#import "YRHXTabbarController.h"
#import "YRHXNavigationController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "Masonry.h"
#import "YLSTouchidView.h"


@interface AppDelegate ()

@property (nonatomic, strong) TouchWindow *touchWindow;
@property (nonatomic, strong) YRHXTabbarController * barVC;

@end

static NSString * const MobAPPSrt = @"7afc85aacfb146265d3a9731d951ee60";
@implementation AppDelegate

//appKey:   1d5c9047d4f5e
//appSecret:    7afc85aacfb146265d3a9731d951ee60


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"59472f924ad1567181002000"];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSLog(@"didFinishLaunch");

    
//    //指纹解锁====== 判断用户是否登录，登录就使用指纹验证。（浏览器有）

//        self.touchWindow = [[TouchWindow alloc] initWithFrame:self.window.frame];
//        [self.touchWindow show];
    
    
    _barVC = [YRHXTabbarController new];

    self.window.rootViewController = _barVC;
    [self.window makeKeyAndVisible];
    
    
    
    
    
    
    //    //shareSDK的账号 密码
    //    [SMSSDK registerApp:@"1d5c9047d4f5e" withSecret:MobAPPSrt];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    YRHXTabbarController *tabBarVc = [[YRHXTabbarController alloc] init];
    
    self.window.rootViewController = tabBarVc;
    
    [self.window makeKeyAndVisible];



    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}











- (void)enterForeground
{
//    NSLog(@"YES");
}



- (void)applicationWillResignActive:(UIApplication *)application {

//     NSLog(@"willResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

//    NSLog(@"didEnterBackground");
}

//step-2
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [self.touchWindow show];
    

}
    
    
    
    


- (void)applicationDidBecomeActive:(UIApplication *)application {
//    NSLog(@"didBecomeActive");
    
    
    NSString *touchIDExist = [[NSUserDefaults standardUserDefaults]objectForKey:@"TouchID"];
    NSString *touchISOn = [[NSUserDefaults standardUserDefaults]objectForKey:@"touchIDISon"];
    NSLog(@"touchIDExist---%@---touchISOn---%@",touchIDExist,touchISOn);
    if ([touchIDExist isEqualToString:@"1"] && [touchISOn isEqualToString:@"NO"])
    {
        YLSTouchidView *yls = [[YLSTouchidView alloc]init];
        [yls show];

    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"touchIDISon"];
    });
 
}

- (void)applicationWillTerminate:(UIApplication *)application {

}





- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];

}








@end
