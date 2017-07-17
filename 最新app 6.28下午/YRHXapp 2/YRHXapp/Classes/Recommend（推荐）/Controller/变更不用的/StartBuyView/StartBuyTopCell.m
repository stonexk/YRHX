//
//  StartBuyTopCell.m
//  YRHXapp
//
//  Created by Apple on 2017/4/19.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "StartBuyTopCell.h"
#import "UIColor+ColorChange.h"

@interface StartBuyTopCell ()

@property (weak, nonatomic) IBOutlet UILabel *proNumberLabel;     //进度的数字label
@property (weak, nonatomic) IBOutlet UIProgressView *progressRate;  //进度条


@end

@implementation StartBuyTopCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.progressRate.progressTintColor = [UIColor colorWithHexString:@"#1294f6"];
    self.progressRate.trackTintColor = [UIColor lightGrayColor];
    [self.progressRate setProgressViewStyle:UIProgressViewStyleDefault]; // 设置显示的样式
    
    //0.88
    [self.progressRate setProgress:[self.proNumberLabel.text floatValue] / 100 animated:YES];

    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
