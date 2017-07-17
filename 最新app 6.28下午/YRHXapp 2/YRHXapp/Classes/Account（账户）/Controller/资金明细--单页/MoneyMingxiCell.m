//
//  MoneyMingxiCell.m
//  YRHXapp
//
//  Created by Apple on 2017/4/26.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "MoneyMingxiCell.h"

@interface MoneyMingxiCell ()

@property (weak, nonatomic) IBOutlet UILabel *showLabel;    //充值、提现label

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
@implementation MoneyMingxiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    /*在模型属性的set方法里面实现。设置，
     如果showLabel是“充值”，moneyLabel颜色为“红色”
     如果showLabel是“提现”，moneyLabel颜色为“黑色”
     */
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
