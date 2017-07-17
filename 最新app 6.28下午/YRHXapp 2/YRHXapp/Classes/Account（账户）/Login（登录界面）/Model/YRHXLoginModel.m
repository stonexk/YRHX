//
//  YRHXLoginModel.m
//  YRHXapp
//
//  Created by Apple on 2017/5/10.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXLoginModel.h"
#import "YRHXNetWorkTool.h"

@implementation YRHXLoginModel

//登录接口
+ (void)loadLogInWithMobile:(NSString *)moblie withPwd:(NSString *)pwd success:(void (^)(NSDictionary *dict))successBlock failed:(void (^)(NSError *error))failedBlock
{
    NSLog(@"moblie=%@  pwd=%@",moblie,pwd);
    
    NSDictionary * parameters = @{
                                  @"loginName":moblie,
                                  @"loginPwd":pwd
                                  };

    NSString * url = @"http://192.168.2.188:8080/mobileLogin?";
    
    [[YRHXNetWorkTool shared] requestMethod:GET urlString:url parameters:parameters                                                                                                                             success:^(id responseObject) {
        
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
