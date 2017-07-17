//
//  HaveChoiceVoucherCell.m
//  YRHXapp
//
//  Created by Apple on 2017/5/24.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "HaveChoiceVoucherCell.h"

@interface HaveChoiceVoucherCell ()


@property (weak, nonatomic) IBOutlet UILabel *voucherMoneyLabel;   //优惠券金额

@end
@implementation HaveChoiceVoucherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
