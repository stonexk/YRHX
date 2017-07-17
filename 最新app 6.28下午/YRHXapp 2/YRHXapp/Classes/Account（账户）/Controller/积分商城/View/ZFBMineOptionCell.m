//
//  ZFBMineOptionCell.m
//  支付宝
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "ZFBMineOptionCell.h"
#import "ZFBMineOption.h"

@interface ZFBMineOptionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end
@implementation ZFBMineOptionCell


- (void)setMineOption:(ZFBMineOption *)mineOption {
    _mineOption = mineOption;
    
    self.iconView.image = [UIImage imageNamed:mineOption.icon];
    self.nameLabel.text = mineOption.name;
    self.messageLabel.text = mineOption.message;
    
    
    if ([mineOption.message isEqualToString:@"立即转入"]) {
        self.messageLabel.textColor = [UIColor blueColor];
    } else {
        self.messageLabel.textColor = [UIColor lightGrayColor];
    }
}
@end
