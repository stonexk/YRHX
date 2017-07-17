//
//  MoreModel.m
//  YRHXapp
//
//  Created by Apple on 2017/4/25.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "MoreModel.h"

@implementation MoreModel

+(instancetype)MoreModelWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc]init];
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
    
}

@end
