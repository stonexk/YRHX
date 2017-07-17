//
//  YRHXNetWorkTool.m
//  YRHXapp
//
//  Created by Apple on 2017/5/10.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXNetWorkTool.h"

@implementation YRHXNetWorkTool


+ (instancetype)shared{
    static YRHXNetWorkTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
        
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        instance.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return instance;
}

- (void)requestMethod:(NetworkMethod)method urlString:(NSString *)urlString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    if (method == GET) {
       
        [self GET:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id rueslt = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            success(rueslt);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            failure(error);
        }];
        
        
    }else {
        
        [self POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
            id rueslt = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            success(rueslt);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            failure(error);
        }];
        
       
        
    }
    
}



- (void)testLoginForUserName:(NSString *)userName password:(NSString *)password success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    NSString * urlString = @"";
    NSDictionary *dict = @{
                           @"":userName,
                           @"":password
                           };

    [self requestMethod:GET urlString:urlString parameters:dict success:success failure:failure];
    
}




@end
