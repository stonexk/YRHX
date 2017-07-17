//
//  YRHXCollectionModel.m
//  YRHXapp
//
//  Created by Apple on 2017/6/1.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXCollectionModel.h"

@implementation YRHXCollectionModel

+(instancetype)yrhxCollectionModelWithDic:(NSDictionary *)dic
{
    
    YRHXCollectionModel *model = [[YRHXCollectionModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dic];
    
    
    return model;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    
}


@end
