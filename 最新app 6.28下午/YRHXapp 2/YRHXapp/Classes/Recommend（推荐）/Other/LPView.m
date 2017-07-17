//
//  LPView.m
//  YRHXapp
//
//  Created by 詹稳 on 17/4/18.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "LPView.h"
#import "UIColor+ColorChange.h"

@interface LPView ()

@property (weak, nonatomic) UILabel *titleLabel;
@property(weak,nonatomic)UILabel * label;

@end


@implementation LPView



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit {
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    [self addSubview:label];
    label.backgroundColor = [UIColor whiteColor];
    _titleLabel = label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.label.text = title;
    self.titleLabel.text = title;
}


@end
