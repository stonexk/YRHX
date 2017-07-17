//
//  YRHXHomeScroollView.h
//  YRHXapp
//
//  Created by Apple on 2017/6/1.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRHXIntegralMallController.h"

typedef enum : NSUInteger {
    ZFBHomeTopViewBtnTypeScan = 100,
    ZFBHomeTopViewBtnTypePay,
    ZFBHomeTopViewBtnTypeCard,
    ZFBHomeTopViewBtnTypeXiu
} ZFBHomeTopViewBtnType;


@interface YRHXHomeScroollView : UIScrollView

@property(nonatomic,strong)NSArray * cycleImageArr; //轮播器
@property(nonatomic,weak)YRHXIntegralMallController * homeViewController;



@end
