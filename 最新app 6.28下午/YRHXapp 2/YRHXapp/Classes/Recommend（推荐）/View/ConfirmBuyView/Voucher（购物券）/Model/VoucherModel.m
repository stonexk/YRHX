//
//  VoucherModel.m
//  YRHXapp
//
//  Created by 詹稳 on 17/4/22.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "VoucherModel.h"

@implementation VoucherModel

+ (instancetype)VoucherModelWithDict:(NSDictionary *)dict{
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}


@end
