//
//  MoreViewCell.m
//  YRHXapp
//
//  Created by Apple on 2017/4/25.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "MoreViewCell.h"
#import "MoreModel.h"

@interface MoreViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picImage;   //图片

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;  //文字


@end


@implementation MoreViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setMoreModel:(MoreModel *)moreModel
{
    _moreModel = moreModel;
    
    self.picImage.image = [UIImage imageNamed:moreModel.pic];
    self.titleLabel.text = moreModel.title;
    //还需要两个属性赋值
    
}

@end
