//
//  YRHXWithDrawCashController.h
//  YRHXapp
//
//  Created by Apple on 2017/5/15.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pickViewDelegate <NSObject>
- (void) getTextStr:(NSString *)text;
@end


@interface YRHXWithDrawCashController : UITableViewController

@property (nonatomic, unsafe_unretained) id<pickViewDelegate> delegate;//声明代理

@end
