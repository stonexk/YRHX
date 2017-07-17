//
//  YRHXCycleViewCell.m
//  YRHXapp
//
//  Created by Apple on 2017/5/17.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXCycleViewCell.h"
#import "Masonry.h"

@interface YRHXCycleViewCell ()

@property (nonatomic, weak) UIImageView *imageView;


@end
@implementation YRHXCycleViewCell

- (void)awakeFromNib {
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

- (void)setupUI {
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    
    UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = [UIImage imageNamed:@"2"];
        [self.contentView addSubview:iconView];
        self.imageView = imageView;
        [iconView sizeToFit];
    
    CGFloat imageW = 375;
    CGFloat imageH = 180;
    CGFloat pictureRealW = KscreenWidth;
    CGFloat pictureRealH = imageH * pictureRealW / imageW;
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(pictureRealH);
    }];
 
    

    
}



- (void)setImageData:(UIImage *)imageData {
    _imageData = imageData;
    
    // 设置图片
    self.imageView.image = imageData;
}


@end
