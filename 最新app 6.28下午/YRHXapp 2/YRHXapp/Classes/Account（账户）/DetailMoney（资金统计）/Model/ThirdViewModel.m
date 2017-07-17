//
//  ThirdViewModel.m
//  YRHXapp
//
//  Created by Apple on 2017/4/26.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "ThirdViewModel.h"

@implementation ThirdViewModel

+ (instancetype)thirdViewModelWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}
@end
