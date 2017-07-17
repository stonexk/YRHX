//
//  YRHXForgetModel.m
//  YRHXapp
//
//  Created by Apple on 2017/5/11.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXForgetModel.h"
#import "YRHXNetWorkTool.h"

@implementation YRHXForgetModel

+ (void)loadFrgetPWDWithUserMobile:(NSString *)userMobile withNewPwd:(NSString *)newPwd withSmsmsg:(NSString *)smsmsg  success:(void (^)(NSDictionary * registerDict))successBlock failed:(void (^)(NSError * error))failedBlock
{
    NSDictionary *parameters = @{
                                 @"userMobile":userMobile,
                                 @"newPwd":newPwd,
                                 @"smsmsg":smsmsg
                                 };

    NSString * url = @"http://192.168.2.188:8080/findPwd4user?";
    
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
