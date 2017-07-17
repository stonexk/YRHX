//
//  YRHXLoginModel.h
//  YRHXapp
//
//  Created by Apple on 2017/5/10.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRHXLoginModel : NSObject

+ (void)loadLogInWithMobile:(NSString *)moblie withPwd:(NSString *)pwd success:(void(^)(NSDictionary *dict))successBlock failed:(void(^)(NSError *error))failedBlock;

@end
