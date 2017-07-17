//
//  VoucherCell.m
//  YRHXapp
//
//  Created by Apple on 2017/4/21.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "VoucherCell.h"
#import "Masonry.h"
#import "VoucherModel.h"
#import "UILabel+CZAddition.h"

@interface VoucherCell ()

@property (nonatomic, weak) UIImageView *iconView;

@end

@implementation VoucherCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupUI];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI
{

    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@"现金券背景"];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    [iconView sizeToFit];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(67.5);
        make.width.offset(picWidth);
        make.height.offset(80);
    }];
   
    self.iconView = iconView;
    
//优惠券图片上红色部分的label
    UILabel * priceLabel = [UILabel cz_labelWithText:@"55" fontSize:32 color:[UIColor whiteColor]];
    [iconView addSubview:priceLabel];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(8);
    }];
    
    UILabel * yuanLabel = [UILabel cz_labelWithText:@"元" fontSize:14 color:[UIColor whiteColor]];
    [iconView addSubview:yuanLabel];
    [yuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel.mas_right).offset(0);
        make.centerY.equalTo(priceLabel);
    }];
    
    UILabel * daoqiLabel = [UILabel cz_labelWithText:@"天后到期" fontSize:12 color:[UIColor whiteColor]];
    [iconView addSubview:daoqiLabel];
    [daoqiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(iconView.mas_right).offset(-5);
        make.centerY.equalTo(yuanLabel);
    }];
    
    UILabel * timeLabel = [UILabel cz_labelWithText:@"19" fontSize:12 color:[UIColor whiteColor]];
    [iconView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(daoqiLabel.mas_left).offset(0);
        make.centerY.equalTo(daoqiLabel);
    }];
    
 //优惠券图片上黄色部分的label
    UILabel * touziLabel = [UILabel cz_labelWithText:@"投资满" fontSize:12 color:[UIColor whiteColor]];
    [iconView addSubview:touziLabel];
    [touziLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(3);
        make.bottom.offset(-6);
    }];
    
    UILabel * moneyLabel = [UILabel cz_labelWithText:@"10800" fontSize:12 color:[UIColor whiteColor]];
    [iconView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(touziLabel.mas_right).offset(0);
        make.centerY.equalTo(touziLabel);
    }];
    
    UILabel * shiyongLabel = [UILabel cz_labelWithText:@"元使用" fontSize:12 color:[UIColor whiteColor]];
    [iconView addSubview:shiyongLabel];
    [shiyongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyLabel.mas_right).offset(0);
        make.centerY.equalTo(moneyLabel);
    }];
    
    
    UIButton * selectBtn = [[UIButton alloc]init];
    [selectBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
      [selectBtn setImage:[UIImage imageNamed:@"选中2"] forState:UIControlStateSelected];
    [iconView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(iconView.mas_right).offset(-3);
        make.centerY.equalTo(shiyongLabel);
        make.height.with.offset(18);
        
    }];
    iconView.userInteractionEnabled = YES;
   [selectBtn addTarget:self action:@selector(touristEvent:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touristEvent:(id)sender{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
}


- (void)setVoucherModel:(VoucherModel *)voucherModel
{
    _voucherModel = voucherModel;
    
    self.iconView.image = [UIImage imageNamed:voucherModel.icon];
}









@end
