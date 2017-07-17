//
//  YRHXPlatformDataController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/7.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXPlatformDataController.h"
#import "DVLineChartView.h"
#import "UIView+Extension.h"
#import "UIColor+Hex.h"

@interface YRHXPlatformDataController ()<DVLineChartViewDelegate>


@end


@implementation YRHXPlatformDataController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor darkGrayColor];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"平台实时数据";
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = [UIView new];
    
    
    [self setupDayLineView];
    [self setupMonthLineView];
}


/* “按日“显示的图表 */
- (void)setupDayLineView
{
    
    DVLineChartView *ccc = [[DVLineChartView alloc] initWithFrame:CGRectMake(0, 210, KscreenWidth, 305)];
    [self.tableView addSubview:ccc];
    ccc.width = self.tableView.width;
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(KscreenWidth/2-15, 15, 50, 21)];
    titleLabel.text = @"按日";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor colorWithHexString:@"eb413d"];
    [ccc addSubview:titleLabel];
    
    UILabel * unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 15, 100, 21)];
    unitLabel.text = @"单位：(万元)";
    unitLabel.font = [UIFont systemFontOfSize:12];
    unitLabel.textColor = [UIColor darkGrayColor];
    [ccc addSubview:unitLabel];
    

    
    CGFloat yAxisViewWidth1 = 45 * KscreenWidth / 375;
    ccc.yAxisViewWidth = yAxisViewWidth1; //y轴距离左边屏幕的间距
    ccc.numberOfYAxisElements = 4;   //X轴上面的线的个数
    ccc.delegate = self;
    ccc.pointUserInteractionEnabled = YES;
    ccc.yAxisMaxValue = 1000;
    CGFloat pointGap1 = 42 * KscreenWidth / 375;
    ccc.pointGap = pointGap1;   //X轴每一列间距
    ccc.showSeparate = YES;
    ccc.separateColor = [UIColor groupTableViewBackgroundColor];//分割的横线颜色
    //    ccc.textColor = [UIColor colorWithHexString:@"9aafc1"];//数字颜色
    ccc.textColor = [UIColor darkGrayColor];//数字颜色
    ccc.backColor = [UIColor whiteColor];//整个背景颜色
  
   
    
//最近一周时间
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate * today = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    
    NSString *dateString = [dateFormatter stringFromDate:today];
    NSString *dateString1 = [dateFormatter stringFromDate:[today dateByAddingTimeInterval:-1 * secondsPerDay]];
    NSString *dateString2 = [dateFormatter stringFromDate:[today dateByAddingTimeInterval:-2 * secondsPerDay]];
    NSString *dateString3 = [dateFormatter stringFromDate:[today dateByAddingTimeInterval:-3 * secondsPerDay]];
    NSString *dateString4 = [dateFormatter stringFromDate:[today dateByAddingTimeInterval:-4 * secondsPerDay]];
    NSString *dateString5 = [dateFormatter stringFromDate:[today dateByAddingTimeInterval:-5 * secondsPerDay]];
    NSString *dateString6 = [dateFormatter stringFromDate:[today dateByAddingTimeInterval:-6 * secondsPerDay]];
    
    ccc.xAxisTitleArray = @[dateString6, dateString5, dateString4, dateString3, dateString2, dateString1,dateString];
   
    
    ccc.axisColor = [UIColor groupTableViewBackgroundColor]; //x坐标轴颜色
    DVPlot *plot = [[DVPlot alloc] init];
    plot.pointArray = @[@300.432, @550.4322, @700.4322, @50.4322, @370.4322, @890.4322, @760.4322];
    
    plot.lineColor = [UIColor  colorWithHexString:@"eb413d"]; //折线填充背景颜色
    plot.pointColor = [UIColor colorWithHexString:@"eb413d"]; //未点击时圆点颜色
    
    plot.chartViewFill = YES;
    plot.withPoint = YES;
    
    [ccc addPlot:plot];
    [ccc draw];
}


/* “按月“显示的图表 */
- (void)setupMonthLineView
{
    DVLineChartView * ddd = [[DVLineChartView alloc] initWithFrame:CGRectMake(0, 525, KscreenWidth, 305)];
    [self.tableView addSubview:ddd];
    ddd.width = self.tableView.width;
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(KscreenWidth/2-15, 15, 50, 21)];
    titleLabel.text = @"按月";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor colorWithHexString:@"eb413d"];
    [ddd addSubview:titleLabel];
    
    UILabel * unitLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 15, 100, 21)];
    unitLabel.text = @"单位：(万元)";
    unitLabel.font = [UIFont systemFontOfSize:12];
    unitLabel.textColor = [UIColor darkGrayColor];
    [ddd addSubview:unitLabel];
    
    

    
    CGFloat yAxisViewWidth1 = 45 * KscreenWidth / 375;
    ddd.yAxisViewWidth = yAxisViewWidth1; //y轴距离左边屏幕的间距
    ddd.numberOfYAxisElements = 4;   //X轴上面的线的个数
    ddd.delegate = self;
    ddd.pointUserInteractionEnabled = YES;
    ddd.yAxisMaxValue = 5000;
    CGFloat pointGap1 = 42 * KscreenWidth / 375;
    ddd.pointGap = pointGap1;   //X轴每一列间距
    ddd.showSeparate = YES;
    ddd.separateColor = [UIColor groupTableViewBackgroundColor];//分割的横线颜色
    //    ccc.textColor = [UIColor colorWithHexString:@"9aafc1"];//数字颜色
    ddd.textColor = [UIColor darkGrayColor];//数字颜色
    ddd.backColor = [UIColor whiteColor];//整个背景颜色

  
    //得到当前的时间
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yy.MM"]; //年月 17.06  不写2017.06  不然写不下
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //    NSLog(@"---当前的时间的字符串 =%@",currentDateStr);
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
//最近7个月时间
    [adcomps setYear:0];
    [adcomps setMonth:-1];
    [adcomps setDay:0];
    NSDate *newdate1 = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforMonth1 = [dateFormatter stringFromDate:newdate1];
    
    [adcomps setYear:0];
    [adcomps setMonth:-2];
    [adcomps setDay:0];
    NSDate *newdate2 = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforMonth2 = [dateFormatter stringFromDate:newdate2];
    
    [adcomps setYear:0];
    [adcomps setMonth:-3];
    [adcomps setDay:0];
    NSDate *newdate3 = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforMonth3 = [dateFormatter stringFromDate:newdate3];
    
    [adcomps setYear:0];
    [adcomps setMonth:-4];
    [adcomps setDay:0];
    NSDate *newdate4 = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforMonth4 = [dateFormatter stringFromDate:newdate4];
    
    [adcomps setYear:0];
    [adcomps setMonth:-5];
    [adcomps setDay:0];
    NSDate *newdate5 = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforMonth5 = [dateFormatter stringFromDate:newdate5];
    
    [adcomps setYear:0];
    [adcomps setMonth:-6];
    [adcomps setDay:0];
    NSDate *newdate6 = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforMonth6 = [dateFormatter stringFromDate:newdate6];
    
    ddd.xAxisTitleArray = @[beforMonth6, beforMonth5, beforMonth4, beforMonth3, beforMonth2, beforMonth1,currentDateStr];
    
 
    ddd.axisColor = [UIColor groupTableViewBackgroundColor]; //x坐标轴颜色
    DVPlot *plot = [[DVPlot alloc] init];
    plot.pointArray = @[@1000.432, @2550.4322, @1700.4322, @3550.4322, @3724.4322, @2890.4322, @4760.4322];
    
    plot.lineColor = [UIColor  colorWithHexString:@"eb413d"]; //折线填充背景颜色
    plot.pointColor = [UIColor colorWithHexString:@"eb413d"]; //未点击时圆点颜色
    
    plot.chartViewFill = YES;
    plot.withPoint = YES;
    
    [ddd addPlot:plot];
    [ddd draw];
    
    

}









- (void)lineChartView:(DVLineChartView *)lineChartView DidClickPointAtIndex:(NSInteger)index {
    
    NSLog(@"%ld", index);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}




//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 1;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
//
//    
//    
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
