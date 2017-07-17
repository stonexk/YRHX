//
//  YRHXSendMessageModel.h
//  YRHXapp
//
//  Created by Apple on 2017/5/11.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRHXSendMessageModel : NSObject

//需要手机号发送验证码
+ (void)loadSendMessageWithNeedMobile:(NSString *)mobile  withType:(NSInteger)type success:(void(^)(NSString * sendMessageStr))successBlock failed:(void(^)(NSError *error))failedBlock;


//无需手机号
+ (void)loadSendMessageWithType:(NSInteger)type success:(void(^)(NSString * sendMessageStr))successBlock failed:(void(^)(NSError *error))failedBlock;



//+ (void)loadCodeImge:(double)v success:(void(^)(NSDictionary * dict))successBlock failed:(void(^)(NSError *error))failedBlock;
//


@end
