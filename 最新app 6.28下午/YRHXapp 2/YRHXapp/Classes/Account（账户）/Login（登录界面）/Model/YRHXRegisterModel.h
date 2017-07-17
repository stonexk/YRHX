//
//  YRHXRegisterModel.h
//  YRHXapp
//
//  Created by Apple on 2017/5/11.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRHXRegisterModel : NSObject


+ (void)loadRegisterWithUserMobile:(NSString *)userMobile withLoginPasswd:(NSString *)loginPasswd withUserName:(NSString *)userName withUCheckCode:(NSString *)uCheckCode withFMobile:(NSString *)fMobile success:(void (^)(NSDictionary * registerDict))successBlock failed:(void (^)(NSError * error))failedBlock;


@end
