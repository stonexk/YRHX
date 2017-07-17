//
//  RecommendModel.m
//  YRHXapp
//
//  Created by Apple on 2017/4/20.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel

+(instancetype)RecommendModelWithDict:(NSDictionary*)dict
{
    id obj = [[self alloc]init];
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}



@end
