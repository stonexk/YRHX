//
//  VoucherFlowLayout.m
//  YRHXapp
//
//  Created by Apple on 2017/4/21.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "VoucherFlowLayout.h"

@implementation VoucherFlowLayout

// 准备布局"当collectionView即将要显示的时候会来调用此方法做布局前的准备,准备itemSize的大小及行列间距等等"
- (void)prepareLayout {
    [super prepareLayout];
    // 获取collectionView的尺寸
    CGSize collectionViewSize = self.collectionView.bounds.size;
    
    CGFloat itemW = collectionViewSize.width / 2;
    CGFloat itemH = collectionViewSize.height;
//    CGFloat itemH = collectionViewSize.height / 2;
    // 设置cell的大小
    self.itemSize = CGSizeMake(itemW, itemH);
    
    // 设置最小行列间距
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    // 水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置分页效果
    self.collectionView.pagingEnabled = YES;
    // 关闭弹簧效果
    self.collectionView.bounces = NO;
    // 隐藏水平和垂直滚动条
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}


@end
