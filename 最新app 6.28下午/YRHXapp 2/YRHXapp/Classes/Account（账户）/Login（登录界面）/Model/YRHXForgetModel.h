//
//  YRHXForgetModel.h
//  YRHXapp
//
//  Created by Apple on 2017/5/11.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRHXForgetModel : NSObject

+ (void)loadFrgetPWDWithUserMobile:(NSString *)userMobile withNewPwd:(NSString *)newPwd withSmsmsg:(NSString *)smsmsg  success:(void (^)(NSDictionary * registerDict))successBlock failed:(void (^)(NSError * error))failedBlock;

@end
