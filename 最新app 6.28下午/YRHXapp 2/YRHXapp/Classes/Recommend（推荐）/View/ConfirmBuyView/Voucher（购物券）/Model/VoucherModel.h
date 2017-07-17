//
//  VoucherModel.h
//  YRHXapp
//
//  Created by 詹稳 on 17/4/22.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoucherModel : NSObject

// 图片名称
@property (nonatomic, copy) NSString *icon;

+ (instancetype)VoucherModelWithDict:(NSDictionary *)dict;


@end
