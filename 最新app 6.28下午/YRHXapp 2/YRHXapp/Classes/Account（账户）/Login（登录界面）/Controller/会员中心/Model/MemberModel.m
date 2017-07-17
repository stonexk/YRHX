//
//  MemberModel.m
//  YRHXapp
//
//  Created by Apple on 2017/5/2.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "MemberModel.h"

@implementation MemberModel

+ (instancetype)MemberModelWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc]init];
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}


@end
