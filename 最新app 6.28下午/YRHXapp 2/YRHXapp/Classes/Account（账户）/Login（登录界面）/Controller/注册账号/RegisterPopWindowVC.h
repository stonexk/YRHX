//
//  RegisterPopWindowVC.h
//  YRHXapp
//
//  Created by Apple on 2017/5/19.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterPopWindowVC : UIViewController

//弹框底部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewBottomConstraint;

//隐藏按钮
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;


@end
