//
//  YRHXCircleView.m
//  YRHXapp
//
//  Created by 詹稳 on 17/4/20.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXCircleView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+ColorChange.h"



@interface YRHXCircleView()<CAAnimationDelegate>
{
      CAShapeLayer *arcLayer;
      UILabel *label;
      NSTimer *progressTimer;
}


@property (nonatomic,assign)CGFloat i;

@end


@implementation YRHXCircleView


-(id)initWithFrame:(CGRect)frame
 {
         self = [super initWithFrame:frame];
         if (self) {
                 self.backgroundColor = [UIColor clearColor];
             }
         return self;
     }

 -(void)drawRect:(CGRect)rect
 {
         _i=0;
         CGContextRef progressContext = UIGraphicsGetCurrentContext();
         CGContextSetLineWidth(progressContext, ProgressWidth);
//         CGContextSetRGBStrokeColor(progressContext, 209.0/255.0, 209.0/255.0, 209.0/255.0, 1);
    CGContextSetRGBStrokeColor(progressContext, 253.0/255.0, 227.0/255.0, 226.0/255.0, 1);
         CGFloat xCenter = rect.size.width * 0.5;
         CGFloat yCenter = rect.size.height * 0.5;
    
         //绘制环形进度条底框
         CGContextAddArc(progressContext, xCenter, yCenter, Radius, 0, 2 * M_PI, 0);
         CGContextDrawPath(progressContext, kCGPathStroke);
    
         //    //绘制环形进度环
         CGFloat to = self.progress * M_PI * 2; //改变弧形的方向 要和下面的clockWise对应
    
         // 进度数字字号,可自己根据自己需要，从视图大小去适配字体字号
//         int fontNum = ViewWidth/6;
    
         label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,Radius+30, ViewWidth/5)];
         label.center = CGPointMake(xCenter, yCenter);
         label.textAlignment = NSTextAlignmentCenter;
         label.font = [UIFont systemFontOfSize:12.0];
         label.text = @"0%";
         [self addSubview:label];

//     clockwise  改变进度条加载的方向
         UIBezierPath *path=[UIBezierPath bezierPath];
         [path addArcWithCenter:CGPointMake(xCenter,yCenter) radius:Radius startAngle:0 endAngle:to clockwise:YES];
         arcLayer=[CAShapeLayer layer];
         arcLayer.path=path.CGPath;//46,169,230
         arcLayer.fillColor = [UIColor clearColor].CGColor;

     if (self.progress == 0) {
         arcLayer.strokeColor = [UIColor colorWithHexString:@"#fddfde"].CGColor;
         label.text = @"即将开始";
         label.textAlignment = NSTextAlignmentCenter;
         label.numberOfLines = 0;
         label.textColor = [UIColor colorWithHexString:@"eb413d"];
         
     }
    else if (self.progress == 1) {
         arcLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        label.text = @"抢完了";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
    }
     
     else
     {
         arcLayer.strokeColor = [UIColor colorWithHexString:@"eb413d"].CGColor;
//同下================================
         NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(newThread) object:nil];
         
         [thread start];
     }
     
         arcLayer.lineWidth=ProgressWidth;
         arcLayer.backgroundColor = [UIColor redColor].CGColor;
     
         [self.layer addSublayer:arcLayer];
    
    
         dispatch_async(dispatch_get_global_queue(0, 0), ^{
                 [self drawLineAnimation:arcLayer];
             });
    
         if (self.progress > 1) {
                 NSLog(@"传入数值范围为 0-1");
                 self.progress = 1;
             }else if (self.progress < 0){
                     NSLog(@"传入数值范围为 0-1");
                     self.progress = 0;
                     return;
                 }
    
//         if (self.progress > 0) {
//                 NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(newThread) object:nil];
//
//             [thread start];
//             }
    
 }



 -(void)newThread
{
         @autoreleasepool {
                 progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timeLabel) userInfo:nil repeats:YES];
                 [[NSRunLoop currentRunLoop] run];
             }
     }



 //NSTimer不会精准调用
 -(void)timeLabel
 {
     _i += 0.01;
     
     label.text = [NSString stringWithFormat:@"%.0f%%",_i*100];
     label.textColor = [UIColor colorWithHexString:@"eb413d"];
     label.font = [UIFont systemFontOfSize:16];
     
     if (_i >= self.progress) {
         [progressTimer invalidate];
         progressTimer = nil;
         
     }
 }

//定义动画过程
 -(void)drawLineAnimation:(CALayer*)layer
 {
        CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//         bas.duration=self.progress;//动画时间
     bas.duration = 1.0;
     bas.delegate=self;
         bas.fromValue=[NSNumber numberWithInteger:0];
     bas.toValue=[NSNumber numberWithInteger:1];
      [layer addAnimation:bas forKey:@"key"];
 }




@end




