//
//  YRHXFlowLayout.m
//  YRHXapp
//
//  Created by Apple on 2017/6/1.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXFlowLayout.h"

@implementation YRHXFlowLayout


-(void)prepareLayout
{
    [super prepareLayout];
    CGSize collectionViewSize = self.collectionView.bounds.size;
    
    
    CGFloat itemW = (collectionViewSize.width  - 10) *0.5;
    
    CGFloat itemH = itemW;
    
    self.itemSize = CGSizeMake(itemW, itemH);
    
    
    // 水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 关闭弹簧效果
    self.collectionView.bounces = NO;
    // 隐藏水平和垂直滚动条
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
}




@end
