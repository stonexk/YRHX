
//
//  YRHXNetWorkTool.h
//  YRHXapp
//
//  Created by Apple on 2017/5/10.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"

// 请求方式枚举
typedef NS_ENUM(NSUInteger, NetworkMethod) {
    GET,
    POST
};

@interface YRHXNetWorkTool : AFHTTPSessionManager


//全局访问点
+ (instancetype) shared;

- (void)requestMethod:(NetworkMethod )method urlString:(NSString *)urlString parameters:(id) parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


// 登录接口
- (void)testLoginForUserName: (NSString *)userName password:(NSString *)password success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


@end
