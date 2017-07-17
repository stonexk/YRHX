//
//  MoreModel.h
//  YRHXapp
//
//  Created by Apple on 2017/4/25.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreModel : NSObject

@property(nonatomic,copy)NSString * pic;
@property(nonatomic,copy)NSString * title;
//还需要右边两个属性


+ (instancetype)MoreModelWithDict:(NSDictionary *)dict;




@end
