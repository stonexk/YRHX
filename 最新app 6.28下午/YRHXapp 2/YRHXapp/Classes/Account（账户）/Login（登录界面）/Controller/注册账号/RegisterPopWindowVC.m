//
//  RegisterPopWindowVC.m
//  YRHXapp
//
//  Created by Apple on 2017/5/19.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "RegisterPopWindowVC.h"

@interface RegisterPopWindowVC ()

@end

@implementation RegisterPopWindowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //千万别设置view的alpha 设置alpha 会导致view下的所有子视图都变透明
    self.view.backgroundColor = [UIColor clearColor];
    
    //取消按钮
    [self.dismissBtn addTarget:self action:@selector(dismissBtn:) forControlEvents:UIControlEventTouchUpInside];
    //设置按钮透明度
    self.dismissBtn.alpha = 0.5f;
    self.dismissBtn.backgroundColor = [UIColor blackColor];
}


//视图显示完 弹出弹窗
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //更改视图 底部约束
    self.viewBottomConstraint.constant = 0;
    
    //执行动画
    [UIView animateWithDuration:0.25 animations:^{
        
        //强制更新约束
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 按钮点击事件
//关闭弹窗按钮
- (void) dismissBtn:(UIButton *)btn{
    
    //更改视图 底部约束
    self.viewBottomConstraint.constant = -400;
    
    //执行动画
    [UIView animateWithDuration:0 animations:^{
        
        //强制更新约束
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
}

//底部隐藏按钮
- (IBAction)cancelBtn:(UIButton *)sender
{
    //更改视图 底部约束
    self.viewBottomConstraint.constant = -400;
    
    //执行动画
    [UIView animateWithDuration:0 animations:^{
        
        //强制更新约束
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
    
}





//- (IBAction)dismissBtnClick:(UIButton *)sender {
//    //更改视图 底部约束
//    self.viewBottomConstraint.constant = -400;
//    
//    //执行动画
//    [UIView animateWithDuration:0 animations:^{
//        
//        //强制更新约束
//        [self.view layoutIfNeeded];
//        
//    } completion:^(BOOL finished) {
//        [self dismissViewControllerAnimated:NO completion:nil];
//    }];
//
//    
//}



@end
