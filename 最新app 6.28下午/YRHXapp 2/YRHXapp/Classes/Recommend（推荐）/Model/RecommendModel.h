//
//  RecommendModel.h
//  YRHXapp
//
//  Created by Apple on 2017/4/20.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RecommendModel : NSObject


@property(nonatomic,copy)NSString * icon;
@property(nonatomic,copy)NSString * title;

+(instancetype)RecommendModelWithDict:(NSDictionary*)dict;


@end
