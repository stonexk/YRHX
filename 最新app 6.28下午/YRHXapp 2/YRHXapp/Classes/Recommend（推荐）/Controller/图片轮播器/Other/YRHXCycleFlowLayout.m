//
//  YRHXCycleFlowLayout.m
//  YRHXapp
//
//  Created by Apple on 2017/5/17.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXCycleFlowLayout.h"

@implementation YRHXCycleFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    // 让cell和collectionView一样大
    self.itemSize = self.collectionView.bounds.size;
    
    // 设置行列间距
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    // 水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 关闭弹簧效果
    self.collectionView.bounces = YES;
    
    // 隐藏水平或垂直滚动条
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 设置分页效果
    self.collectionView.pagingEnabled = YES;
}


@end
