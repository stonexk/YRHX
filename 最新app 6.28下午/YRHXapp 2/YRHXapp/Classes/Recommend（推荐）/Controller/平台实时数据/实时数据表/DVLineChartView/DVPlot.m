//
//  DVPlot.m
//  DVLineChart
//
//  Created by Fire on 15/10/17.
//  Copyright © 2015年 DuoLaiDian. All rights reserved.
//

#import "DVPlot.h"
#import "UIColor+ColorChange.h"

@implementation DVPlot
{
        CGPoint lastPoint;//最后一个坐标点
}


- (instancetype)init {
    
    if (self = [super init]) {
        self.lineColor = [UIColor blackColor];
        self.pointColor = [UIColor blackColor];
        self.pointSelectedColor = [UIColor lightGrayColor];
    }
    return self;
}






@end
