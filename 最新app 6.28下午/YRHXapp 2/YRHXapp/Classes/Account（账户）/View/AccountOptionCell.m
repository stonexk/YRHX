//
//  AccountOptionCell.m
//  YRHXapp
//
//  Created by Apple on 2017/5/25.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "AccountOptionCell.h"
#import "AccountOptionModel.h"

@interface AccountOptionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation AccountOptionCell

-(void)setOptionModel:(AccountOptionModel *)optionModel
{
    
    _optionModel = optionModel;
    
    self.iconView.image = [UIImage imageNamed:optionModel.icon];
    self.nameLabel.text = optionModel.name;
    
    
}




@end
