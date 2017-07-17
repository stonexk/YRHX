//
//  YRHXSendMessageModel.m
//  YRHXapp
//
//  Created by Apple on 2017/5/11.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXSendMessageModel.h"
#import "YRHXNetWorkTool.h"

@implementation YRHXSendMessageModel

    //需要手机号  也要加上短信验证码
+ (void)loadSendMessageWithNeedMobile:(NSString *)mobile  withType:(NSInteger)type success:(void(^)(NSString * sendMessageStr))successBlock failed:(void(^)(NSError *error))failedBlock
{
    NSDictionary *parameters = @{
                                 @"mobile":mobile,
                                 @"type":[NSString stringWithFormat:@"%zd",type]
                                 };
    

    NSString * url = @"http://192.168.2.188:8080/sendMsgMobile?";
    
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


//无需手机号
+ (void)loadSendMessageWithType:(NSInteger)type success:(void(^)(NSString * sendMessageStr))successBlock failed:(void(^)(NSError *error))failedBlock
{
    NSDictionary *parameters = @{
                                 @"type":[NSString stringWithFormat:@"%zd",type]
                                 };

    
    NSString * url = @"http://192.168.2.188:8080/sendMsgMac?";
    
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



//
//+ (void)loadCodeImge:(double)v success:(void(^)(NSDictionary * dict))successBlock failed:(void(^)(NSError *error))failedBlock
//{
//    NSDictionary *parameters = @{
//                                 @"v":@0.555]
//                                 };
//    
//    NSString * url = @"http://192.168.2.188:8080/captcha4sys?";
//
//    [[YRHXNetWorkTool shared] requestMethod:GET urlString:url parameters:parameters success:^(id responseObject) {
//        
//        if (successBlock) {
//            successBlock(responseObject);
//            NSLog(@"图片验证码请求成功  responseObject = %@",responseObject);
//        }
//    
//    } failure:^(NSError *error) {
//        
//        failedBlock(error);
//        
//        NSLog(@"图片请求失败了");
//    }];
//  
//}



@end
