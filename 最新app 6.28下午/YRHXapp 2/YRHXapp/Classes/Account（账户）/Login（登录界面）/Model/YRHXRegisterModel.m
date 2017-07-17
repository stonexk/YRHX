//
//  YRHXRegisterModel.m
//  YRHXapp
//
//  Created by Apple on 2017/5/11.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXRegisterModel.h"
#import "YRHXNetWorkTool.h"

@implementation YRHXRegisterModel

+ (void)loadRegisterWithUserMobile:(NSString *)userMobile withLoginPasswd:(NSString *)loginPasswd withUserName:(NSString *)userName withUCheckCode:(NSString *)uCheckCode withFMobile:(NSString *)fMobile success:(void (^)(NSDictionary * registerDict))successBlock failed:(void (^)(NSError * error))failedBlock
{
    
    NSDictionary *parameters = @{
                                 @"userMobile":userMobile,
                                 @"loginPasswd":loginPasswd,
                                 @"userName":userName,
                                 @"uCheckCode":uCheckCode,
                                 @"fMobile":fMobile
                                 };

    NSString * url = @"http://192.168.2.188:8080/register4mobile?";
    
    [[YRHXNetWorkTool shared] requestMethod:GET urlString:url parameters:parameters success:^(id responseObject) {
        
        if (successBlock) {
            successBlock(responseObject);
            NSLog(@"请求成功  responseObjec t = %@",responseObject);
        }
        
    } failure:^(NSError *error) {
        
        failedBlock(error);
        
        NSLog(@"请求失败了");
        
    }];
   
}
    


@end
