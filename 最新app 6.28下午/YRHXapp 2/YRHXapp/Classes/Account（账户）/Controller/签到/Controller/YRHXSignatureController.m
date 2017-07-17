//
//  YRHXSignatureController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/31.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXSignatureController.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
#import "UIColor+ColorChange.h"
#import "YRHXScoresMallController.h"
#import "FSCalendar.h"
#import "DIYCalendarCell.h"
#import "FSCalendarExtensions.h"
#import "SignatureRulesController.h"
#define mainColor [UIColor darkGrayColor]

@interface YRHXSignatureController ()<UITableViewDelegate,UITableViewDataSource,FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (weak, nonatomic) FSCalendar *calendar;

@property (weak, nonatomic) UILabel *eventLabel;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property(strong,nonatomic)NSMutableArray*dataArr;
//

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UITableViewCell * signCell;

@end
static NSString * cellID = @"cellID";
@implementation YRHXSignatureController

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

//懒加载
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, tableViewHeight + 75)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"每日签到";    
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [rightButton setTitle:@"签到规则" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightButton addTarget:self action:@selector(ruleBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;

    
    
    //注册机制
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    
    
    
    
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    //创建一个数组记录已经签过到的天
    _dataArr=[[NSMutableArray alloc]initWithObjects:@"2017-05-21",@"2017-05-22",@"2017-05-23",@"2017-05-12",@"2017-04-12",@"2017-03-12",@"2017-05-17",nil];
    for (int i=0; i<_dataArr.count; i++) {
        [self.calendar selectDate:[self.dateFormatter dateFromString:_dataArr[i]] scrollToDate:YES];
    }
    
    self.calendar.accessibilityIdentifier = @"calendar";
   
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)ruleBtnClick
{
    SignatureRulesController * rulesVC = [[SignatureRulesController alloc]initWithNibName:@"SignatureRulesController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:rulesVC animated:YES];
}





- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 350;
    }
    return 300;
}


//pragma 数据源方法===============
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _signCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    _signCell.backgroundColor = [UIColor whiteColor];
    
    
    if (indexPath.section == 0) {
        
        [self setupTopViewCell];
    }
    if (indexPath.section == 1) {
        
        [self setupCalendarViewCell];
    }
    
    return _signCell;
}



- (void)setupTopViewCell
{
    UIImageView * picView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景2"]];
    [_signCell addSubview:picView];
    [picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.offset(200);
    }];
    
    UIImageView * rectPic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"签到背景"]];
    [_signCell addSubview:rectPic];
    [rectPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_signCell);
        make.top.equalTo(_signCell.mas_top).offset(8);
        make.height.width.offset(115);
    }];
    
    UILabel * signLabel = [UILabel cz_labelWithText:@"已签到+0" fontSize:16 color:[UIColor colorWithHexString:@"eb413d"]];
    [rectPic addSubview:signLabel];
    signLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    signLabel.numberOfLines = 0;
    signLabel.textAlignment = NSTextAlignmentCenter;
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(rectPic);
        make.width.height.offset(55);
    }];
    
    UILabel * lianxuSignLabel = [UILabel cz_labelWithText:@"已连续签到0天" fontSize:12 color:[UIColor colorWithWhite:1 alpha:0.7]];
    [_signCell addSubview:lianxuSignLabel];
    [lianxuSignLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_signCell);
        make.top.equalTo(rectPic.mas_bottom).offset(5);
    }];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    [_signCell addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(1);
        make.bottom.equalTo(picView.mas_bottom).offset(-45);
    }];
    
    UILabel * useScoreTitle = [UILabel cz_labelWithText:@"我的可用积分" fontSize:14 color:[UIColor colorWithWhite:1 alpha:0.7]];
    [_signCell addSubview:useScoreTitle];
    [useScoreTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineLabel.mas_bottom).offset(13);
        make.left.offset(15);
    }];
    
    UILabel * useScoreLabel = [UILabel cz_labelWithText:@"0000" fontSize:14 color:[UIColor whiteColor]];
    [_signCell addSubview:useScoreLabel];
    [useScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(useScoreTitle.mas_right).offset(8);
        make.centerY.equalTo(useScoreTitle);
    }];
    
    UIButton * mallBtn = [[UIButton alloc]init];
    [_signCell addSubview:mallBtn];
    [mallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.width.offset(80);
        make.height.offset(40);
        make.centerY.equalTo(useScoreLabel);
    }];
    [mallBtn addTarget:self action:@selector(mallBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * mallTitle = [UILabel cz_labelWithText:@"积分商城" fontSize:14 color:[UIColor whiteColor]];
    [mallBtn addSubview:mallTitle];
    [mallTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mallBtn.mas_left).offset(0);
        make.centerY.equalTo(mallBtn);
    }];

    UIImageView * arrowImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"形状1"]];
    [mallBtn addSubview:arrowImg];
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(7);
        make.height.offset(11);
        make.right.offset(0);
        make.centerY.equalTo(mallBtn);
    }];
    
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor whiteColor];
    [_signCell addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(picView.mas_bottom).offset(0);
        make.height.offset(150);
    }];
    
    UILabel * extraRewardTitle = [UILabel cz_labelWithText:@"连续签到额外奖励" fontSize:14 color:[UIColor darkGrayColor]];
    [_signCell addSubview:extraRewardTitle];
    [extraRewardTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_signCell);
        make.top.equalTo(midView.mas_top).offset(15);
    }];
    
    UIImageView * rewardImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"奖励"]];
    rewardImg.contentMode = UIViewContentModeScaleAspectFit;
    [_signCell addSubview:rewardImg];
    [rewardImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(75);
        make.centerY.equalTo(midView).offset(10);
//        make.centerX.equalTo(midView);
//        make.width.offset(360);
        make.left.offset(0);
        make.right.offset(0);
    }];
}

- (void)mallBtnClick
{
    YRHXScoresMallController * mallVC = [[YRHXScoresMallController alloc]init];
    [self.navigationController pushViewController:mallVC animated:YES];
}

- (void)setupCalendarViewCell
{
    
 /*
    LPCalendarView *calendarView=[[LPCalendarView alloc] init];
    calendarView.frame=CGRectMake(15, 360, KscreenWidth-30, 330);
    calendarView.date=[NSDate date];
    [self.tableView addSubview:calendarView];
    
    
    //设置已经签到的天数日期
    NSMutableArray* _signArray = [[NSMutableArray alloc] init];
    [_signArray addObject:[NSNumber numberWithInt:1]];
    [_signArray addObject:[NSNumber numberWithInt:5]];
    [_signArray addObject:[NSNumber numberWithInt:9]];
    calendarView.signArray = _signArray;
    
    calendarView.date = [NSDate date];
    
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    //日期点击事件
    __weak typeof(LPCalendarView) *weakDemo = calendarView;
    calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        if ([comp day]==day) {
            NSLog(@"%li-%li-%li", year,month,day);
            //根据自己逻辑条件 设置今日已经签到的style 没有签到不需要写
            [weakDemo setStyle_Today_Signed:weakDemo.dayButton];
        }
    };
 */

    

    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(15, 360, KscreenWidth-30, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.appearance.weekdayTextColor=mainColor;
    calendar.appearance.headerTitleColor=mainColor;
    calendar.allowsMultipleSelection = YES;
    [self.tableView addSubview:calendar];
    self.calendar = calendar;
    
    
    
    calendar.calendarHeaderView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    calendar.calendarWeekdayView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    calendar.appearance.selectionColor =[UIColor clearColor];//选中颜色
    
    calendar.today = nil; // Hide the today circle
    
    [calendar registerClass:[DIYCalendarCell class] forCellReuseIdentifier:@"cell"];
//    
//    UIButton*qianbtn=[[UIButton alloc]initWithFrame:CGRectMake(100, 30, 200, 50)];
//    [qianbtn setTitle:@"点击签到" forState:UIControlStateNormal];
//    [qianbtn setTitleColor:mainColor forState:UIControlStateNormal];
//    [qianbtn addTarget:self action:@selector(clickQiandao) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:qianbtn];
//
  
}

//定制今天的日期还有好多有趣的API可以自己去看看
- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        
        return @"今";
    }
    return nil;
}





- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - FSCalendarDataSource
//设置最小日期
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter dateFromString:@"2016-07-08"];
}
//最大
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:0 toDate:[NSDate date] options:0];
}

//定制cell
- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    DIYCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:monthPosition];
    //定制图片
    //cell.circleImageView.image=[UIImage imageNamed:@"勾16"];
    return cell;
}

#pragma mark - FSCalendarDelegate
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    //当天不能点击
    if ([self.gregorian isDateInToday:date]) {
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    
    if ([_dataArr containsObject:[self.dateFormatter stringFromDate:date]]) {
        return;
    }
    
    if (![_dataArr containsObject:[self.dateFormatter stringFromDate:date]]) {
        //            [_dataArr addObject:[self.dateFormatter stringFromDate:date]];
        NSLog(@"%@",_dataArr);
        [calendar reloadData];
        
    }else{
        //重复的不加
    }
    
    
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
    
}

/**
 * Asks the delegate for day text color in selected state for the specific date.
 */
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date{
    return [UIColor blackColor];
    
}

//点击今日签到的方法
-(void)clickQiandao
{
    if (![_dataArr containsObject:[self.dateFormatter stringFromDate:[NSDate date]]]) {
        [_dataArr addObject:[self.dateFormatter stringFromDate:[NSDate date]]];
        
        NSLog(@"%@",_dataArr);
        
        for (int i=0; i<_dataArr.count; i++) {
            [self.calendar selectDate:[self.dateFormatter dateFromString:_dataArr[i]] scrollToDate:YES];
        }
        
        [_calendar reloadData];
    }
}

- (CGFloat)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderRadiusForDate:(nonnull NSDate *)date
{
    
    return 0.0;
}

- (UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date
{
    //点击签到按钮
    if ([self.gregorian isDateInToday:date]) {
        
        UIImage * img = [UIImage imageNamed:@"勾16"];
        
        return img;
    }
    
    else if ([_dataArr containsObject:[self.dateFormatter stringFromDate:date]]) {
        return [UIImage imageNamed:@"对勾"];
//        @"勾16"
    }
    else{
        return nil;
    }
    
}










//选中某一行cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}





@end
