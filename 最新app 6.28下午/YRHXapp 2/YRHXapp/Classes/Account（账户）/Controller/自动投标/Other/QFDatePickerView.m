//
//  QFDatePickerView.m
//  dateDemo
//
//  Created by 情风 on 2017/1/12.
//  Copyright © 2017年 情风. All rights reserved.
//

#import "QFDatePickerView.h"
#import "AppDelegate.h"
#import "Masonry.h"

@interface QFDatePickerView () <UIPickerViewDataSource,UIPickerViewDelegate>{
    UIView *contentView;
    void(^backBlock)(NSString *);
    
    void(^zBlock)(NSString *);
    void(^wackBlock)(NSString *);
    NSString *restr1;
    NSString *restr2;
    
    NSMutableArray *yearArray;
    NSMutableArray *monthArray;
    NSInteger currentYear;
    NSInteger currentMonth;
    NSString *restr;
    
    NSString *selectedYear;
    NSString *selectecMonth;
}


@end

@implementation QFDatePickerView

#pragma mark - initDatePickerView

- (instancetype)initDatePackerWithResponse:(void (^)(NSString *))block with:(void (^)(NSString *))ZWblock
{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
    }
    [self setViewInterface];
    if (block) {

        zBlock = block;
    }
    if (ZWblock) {

        wackBlock = ZWblock;
    }
    return self;
}


#pragma mark - ConfigurationUI
- (void)setViewInterface {
    //获取当前时间 （时间格式支持自定义）
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy-MM"];//自定义时间格式
    NSString *currentDateStr = [formatter stringFromDate:[NSDate date]];
    //拆分年月成数组
    NSArray *dateArray = [currentDateStr componentsSeparatedByString:@"-"];
    if (dateArray.count == 2) {//年 月
        currentYear = [[dateArray firstObject]integerValue];
        currentMonth =  [dateArray[1] integerValue];
    }
    selectedYear = [NSString stringWithFormat:@"%ld",(long)currentYear];
    selectecMonth = [NSString stringWithFormat:@"%ld",(long)currentMonth];
    
    //初始化年数据源数组
    yearArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 24 ; i++) {
        NSString *yearStr = [NSString stringWithFormat:@"%ld",i];
        [yearArray addObject:yearStr];
    }
//    [yearArray addObject:@"至今"];
    
    //初始化月数据源数组
    monthArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 1 ; i <= 24; i++) {
        NSString *monthStr = [NSString stringWithFormat:@"%ld",i];
        [monthArray addObject:monthStr];
    }
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 300)];
    [self addSubview:contentView];
    //设置背景颜色为黑色，并有0.4的透明度
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    //添加白色view
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:whiteView];
    //添加确定和取消按钮
    for (int i = 0; i < 2; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 60) * i, 0, 60, 40)];
        [button setTitle:i == 0 ? @"取消" : @"确定" forState:UIControlStateNormal];
        if (i == 0) {
            [button setTitleColor:[UIColor colorWithRed:97.0 / 255.0 green:97.0 / 255.0 blue:97.0 / 255.0 alpha:1] forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        [whiteView addSubview:button];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10 + i;
    }
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.bounds), 260)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.backgroundColor = [UIColor colorWithRed:240.0/255 green:243.0/255 blue:250.0/255 alpha:1];
    
    //设置pickerView默认选中当前时间
    [pickerView selectRow:[selectedYear integerValue] - 1  inComponent:0 animated:YES];
    [pickerView selectRow:[selectecMonth integerValue] -1   inComponent:1 animated:YES];
    
    [contentView addSubview:pickerView];
    
    
    UILabel * label = [[UILabel alloc]init];
    [pickerView addSubview:label];
    label.text = @"至";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(pickerView);
        make.centerY.equalTo(pickerView);
    }];
    
}

#pragma mark - Actions
- (void)buttonTapped:(UIButton *)sender {
    if (sender.tag == 10) {
        [self dismiss];
    } else {
  
        if ([selectecMonth isEqualToString:@""]) {//至今的情况下 不需要中间-
            restr1 = [NSString stringWithFormat:@"%@",selectedYear];
            zBlock(restr1);
            restr2 = [NSString stringWithFormat:@"%@",selectecMonth];
            wackBlock(restr2);
        } else {
            restr1 = [NSString stringWithFormat:@"%@",selectedYear];
            zBlock(restr1);
            restr2 = [NSString stringWithFormat:@"%@",selectecMonth];
            wackBlock(restr2);
        }
        
//        restr1 = [restr stringByReplacingOccurrencesOfString:@"月" withString:@""];
//        restr2 = [restr stringByReplacingOccurrencesOfString:@"月" withString:@""];
//        zBlock(restr1);
//        wackBlock(restr2);
        [self dismiss];
        
    }
}

#pragma mark - pickerView出现
- (void)show {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app.window addSubview:self];
    [UIView animateWithDuration:0.4 animations:^{
        contentView.center = CGPointMake(self.frame.size.width/2, contentView.center.y - contentView.frame.size.height);
    }];
}
#pragma mark - pickerView消失
- (void)dismiss{
    
    [UIView animateWithDuration:0.4 animations:^{
        contentView.center = CGPointMake(self.frame.size.width/2, contentView.center.y + contentView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDataSource UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return yearArray.count;
    }
    else {
        return monthArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return yearArray[row];
    } else {
        return monthArray[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        selectedYear = yearArray[row];
//    }
//        if (row == yearArray.count ) {//至今的情况下,月份清空
//            [monthArray removeAllObjects];
//            selectecMonth = @"";
//        } else {//非至今的情况下,显示月份
//            monthArray = [[NSMutableArray alloc]init];
//            for (NSInteger i = 1 ; i <= 24; i++) {
//                NSString *monthStr = [NSString stringWithFormat:@"%ld月",i];
//                [monthArray addObject:monthStr];
//            }
//            selectecMonth = [NSString stringWithFormat:@"%ld",(long)currentMonth];
//        }
//        [pickerView reloadComponent:1];
//        
    } else {
        selectecMonth = monthArray[row];
    }
}

@end
