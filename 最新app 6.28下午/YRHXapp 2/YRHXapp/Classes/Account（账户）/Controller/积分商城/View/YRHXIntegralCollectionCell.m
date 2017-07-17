//
//  YRHXIntegralCollectionCell.m
//  YRHXapp
//
//  Created by Apple on 2017/6/1.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXIntegralCollectionCell.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
#import "UIColor+ColorChange.h"


@interface YRHXIntegralCollectionCell ()

//@property(nonatomic,strong)UIButton *reduceButton;
//
//@property(nonatomic,assign)NSInteger count;
//
//@property(nonatomic,strong)UIButton *addButton;
//
//@property(nonatomic,strong)UIImageView *imageView2;

@end

@implementation YRHXIntegralCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI
{
      self.backgroundColor = [UIColor whiteColor];

    UIImageView * imageV = [[UIImageView alloc] init];
    imageV.contentMode = UIViewContentModeScaleAspectFill;
//    self.imageView = imageV;
    [self.contentView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
        make.top.left.right.offset(0);
        make.height.offset(120);
    }];

    UILabel * diyongLable = [UILabel cz_labelWithText:@"000元现金抵用券" fontSize:13 color:[UIColor blackColor]];
//    self.nameLable = diyongLable;
    [self.contentView addSubview:diyongLable];
    [diyongLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV.mas_bottom).offset(5);
        make.centerX.equalTo(imageV);
    }];

    UILabel * needScoreLabel = [UILabel cz_labelWithText:@"000 积分" fontSize:12 color:[UIColor colorWithHexString:@"eb413d"]];
    //    self.nameLable = lable;
    needScoreLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:needScoreLabel];
    [needScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(diyongLable.mas_bottom).offset(5);
        make.width.offset((KscreenWidth-10)/4);
        make.left.offset(0);
    }];

    UILabel * restCountLabel = [UILabel cz_labelWithText:@"/剩余 000 个" fontSize:12 color:[UIColor darkGrayColor]];
    //    self.nameLable = lable;
    restCountLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:restCountLabel];
    [restCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset((KscreenWidth-10)/4);
        make.centerY.equalTo(needScoreLabel);
        make.right.offset(0);
    }];

    
    
}




//- (void)setModel:(YRHXCollectionModel *)model
//{    
//    _model = model;
//    
//
//    self.model.count = [NSString stringWithFormat:@"%zd",con];
//    
//    self.countLable.text = self.model.count;
//    
//    self.nameLable.text = model.name;
//    
//    self.partner_price.text = [NSString stringWithFormat:@"￥%@",model.partner_price];
//    self.specificsLab.text = model.specifics;
//    NSString * textStr = [NSString stringWithFormat:@"￥%@",model.market_price];
//    NSDictionary * attribtDic = @{
//                                  NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
//                                  };
//    NSMutableAttributedString * attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
//    self.market_price.attributedText = attribtStr;
//    
//
//
//}



@end
