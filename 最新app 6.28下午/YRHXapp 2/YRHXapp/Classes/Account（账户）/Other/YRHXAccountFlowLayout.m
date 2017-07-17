//
//  YRHXAccountFlowLayout.m
//  YRHXapp
//
//  Created by Apple on 2017/5/25.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXAccountFlowLayout.h"

@implementation YRHXAccountFlowLayout


- (void)prepareLayout {
    [super prepareLayout];
    
    // 设置行列间距
    self.minimumLineSpacing = 2 / [UIScreen mainScreen].scale;
    self.minimumInteritemSpacing = 0;
    // 设置每一组的尾部间距
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}


@end
