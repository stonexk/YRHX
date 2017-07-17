//
//  ViewController.m
//  TouchIDDemo
//
//  Created by Ben on 16/3/11.
//  Copyright © 2016年 https://github.com/CoderBBen/YBTouchID.git. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    
    view.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:view];
    
}

@end
