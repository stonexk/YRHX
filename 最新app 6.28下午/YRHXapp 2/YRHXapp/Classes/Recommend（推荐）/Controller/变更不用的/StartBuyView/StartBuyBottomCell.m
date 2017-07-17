//
//  StartBuyBottomCell.m
//  YRHXapp
//
//  Created by Apple on 2017/4/20.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "StartBuyBottomCell.h"
#import "RecommendModel.h"

@interface StartBuyBottomCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation StartBuyBottomCell

- (void)setRecommendModel:(RecommendModel *)recommendModel
{
    _recommendModel = recommendModel;
    
    self.iconImage.image = [UIImage imageNamed:recommendModel.icon];
    self.titleLabel.text = recommendModel.title;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
