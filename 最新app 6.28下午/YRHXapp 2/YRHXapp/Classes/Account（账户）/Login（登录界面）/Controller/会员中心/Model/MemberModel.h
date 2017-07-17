//
//  MemberModel.h
//  YRHXapp
//
//  Created by Apple on 2017/5/2.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberModel : NSObject


@property(nonatomic,copy)NSString * title;
//还需要右边两个属性




+ (instancetype)MemberModelWithDict:(NSDictionary *)dict;



@end
