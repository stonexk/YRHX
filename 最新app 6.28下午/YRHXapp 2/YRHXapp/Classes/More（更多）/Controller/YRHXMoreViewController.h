//
//  YRHXMoreViewController.h
//  YRHX
//
//  Created by 詹稳 on 17/4/18.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRHXMoreViewController : UITableViewController

typedef enum : NSUInteger {
    ZFBHomeTopViewBtnTypeScan = 100,
    ZFBHomeTopViewBtnTypePay,
    ZFBHomeTopViewBtnTypeCard,
    ZFBHomeTopViewBtnTypeXiu
} ZFBHomeTopViewBtnType;

@end
