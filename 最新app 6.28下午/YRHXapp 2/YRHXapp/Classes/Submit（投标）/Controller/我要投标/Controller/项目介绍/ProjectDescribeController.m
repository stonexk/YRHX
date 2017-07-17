//
//  ProjectDescribeController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/23.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "ProjectDescribeController.h"
#import "UIColor+ColorChange.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"

@interface ProjectDescribeController ()

@property (nonatomic,strong) UILabel * label;
@property (nonatomic,strong)UILabel * checkLabel;
@property (nonatomic,assign)CGSize expectSize5;

@end

@implementation ProjectDescribeController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.tableView.frame = CGRectMake(0, -20, KscreenWidth, KscreenHeight - 49);
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView * interValView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 10)];
    interValView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    [self.tableView addSubview:interValView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    
    
//    self.tableView.userInteractionEnabled = NO;
    self.tableView.estimatedRowHeight = 700;
    // 自动计算行高
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
       self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupUI];
 
    
/*
    UILabel *label = [[UILabel alloc]init];
    NSString *string = @"其实，经年过往，每个人何尝不是在这场虚妄里跋涉？在真实的笑里哭着，在真实的哭里笑着，一笺烟雨，半帘幽梦，许多时候，我们不得不承认：生活，不是不寂寞，只是不想说。其实，经年过往，每个人何尝不是在这场虚妄里跋涉？在真实的笑里哭着，在真实的哭里笑着，";
    //    计算字符若显示的宽度与label一样宽时，它需要的高度
    CGRect r = [string boundingRectWithSize:CGSizeMake(300,10000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil];
    [self.tableView addSubview:label];
    label.frame = CGRectMake(15, 30, KscreenWidth-30, r.size.height);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.offset(KscreenWidth - 35);
        make.top.equalTo(redView1.mas_bottom).offset(0);
        make.height.offset(r.size.height);
    }];
    label.text = string;
    label.textColor = [UIColor darkGrayColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13];
    label.backgroundColor = [UIColor orangeColor];
*/
}


- (void)setupUI
{
    //第一条
    UILabel * redView1 = [[UILabel alloc]init];
    redView1.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    [self.tableView addSubview:redView1];
    [redView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(15);
        make.width.offset(5);
        make.left.offset(15);
        make.top.offset(35);
    }];

    UILabel * borrowerInfoTitle = [UILabel cz_labelWithText:@"借款人信息" fontSize:15 color:[UIColor blackColor]];
    [self.tableView addSubview:borrowerInfoTitle];
    [borrowerInfoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(redView1.mas_right).offset(7);
        make.centerY.equalTo(redView1);
    }];

    NSString * str1 = @"借款人婚姻状态未婚，现年 33 岁，户籍所在地为新疆乌鲁木齐市，现居住于乌鲁木齐市高新区,借款人现经营一家汽车服务有限公司.借款人名下有一套全款房产，位于乌鲁木齐市高新区，面积82.61平米,下户人员已核实,另借款人名下有一辆全款东风日产牌车，购买于2013年2月，购买价13.5万(评估价5.6万）,此标类型为车辆抵押标，还款方式为等额本息，实际借款期限为12个月。（抵押手续办理中，办理完成后补充抵押登记证明借款人婚姻状态未婚，现年 33 岁，户籍所在地为新疆乌鲁木齐市，现居住于乌鲁木齐市高新区,借款人现经营一家汽车服务有限公司.借款人名下有一套全款房产，位于乌鲁木齐市高新区，面积82.61平米,下户人员已核实,另借款人名下有一辆全款东风日产牌车，购买于2013年2月，购买价13.5万(评估价5.6万）,此标类型为车辆抵押标，还款方式为等额本息，实际借款期限为12个月。（抵押手续办理中，办理完成后补充抵押登记证明借款人婚姻状态未婚，现年 33 岁，户籍所在地为新疆乌鲁木齐市，现居住于乌鲁木齐市高新区,借款人现经营一家汽车服务有限公司.借款人名下有一套全款房产，位于乌鲁木齐市高新区，面积82.61平米,下户人员已核实,另借款人名下有一辆全款东风日产牌车，购买于2013年2月，购买价13.5万(评估价5.6万）,此标类型为车辆抵押标，还款方式为等额本息，实际借款期限为12个月。（抵押手续办理中，办理完成后补充抵押登记证明~~~~";
    UILabel * borrowerInfoLabel = [UILabel cz_labelWithText:str1 fontSize:13 color:[UIColor darkGrayColor]];
    borrowerInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize expectSize1 = [borrowerInfoLabel sizeThatFits:maximumLabelSize];
//    borrowerInfoLabel.numberOfLines = 0;
    [self.tableView addSubview:borrowerInfoLabel];
    [borrowerInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
//         make.width.offset(KscreenWidth - 35);
        make.width.offset(expectSize1.width);
        make.top.equalTo(redView1.mas_bottom).offset(15);
        make.height.offset(expectSize1.height);
    }];
    

    
    //第二条
    UILabel * redView2 = [[UILabel alloc]init];
    redView2.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    [self.tableView addSubview:redView2];
    [redView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(15);
        make.width.offset(5);
        make.left.offset(15);
        make.top.equalTo(borrowerInfoLabel.mas_bottom).offset(15);
    }];
    
    UILabel * sourceTitle = [UILabel cz_labelWithText:@"借款用途及来源" fontSize:15 color:[UIColor blackColor]];
    [self.tableView addSubview:sourceTitle];
    [sourceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(redView2.mas_right).offset(7);
        make.centerY.equalTo(redView2);
    }];

    NSString * str2 = @"借款人现因资金周转，需借款3万元，借款人以其经营收入，作为还款来源~~~~";
    UILabel * sourceLabel = [UILabel cz_labelWithText:str2 fontSize:13 color:[UIColor darkGrayColor]];
    sourceLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize expectSize2 = [sourceLabel sizeThatFits:maximumLabelSize];
    [self.tableView addSubview:sourceLabel];
    [sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.offset(expectSize2.width);
        make.top.equalTo(redView2.mas_bottom).offset(15);
        make.height.offset(expectSize2.height);
    }];
    
    
    //第三条
    UILabel * redView3 = [[UILabel alloc]init];
    redView3.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    [self.tableView addSubview:redView3];
    [redView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(15);
        make.width.offset(5);
        make.left.offset(15);
        make.top.equalTo(sourceLabel.mas_bottom).offset(15);
    }];

    UILabel * carInfoTitle = [UILabel cz_labelWithText:@"车辆信息" fontSize:15 color:[UIColor blackColor]];
    [self.tableView addSubview:carInfoTitle];
    [carInfoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(redView3.mas_right).offset(7);
        make.centerY.equalTo(redView3);
    }];
    
    NSString * str3 = @"品牌：东风日产牌~~~~ ";
    UILabel * carInfoLabel = [UILabel cz_labelWithText:str3 fontSize:13 color:[UIColor darkGrayColor]];
    carInfoLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize expectSize3 = [carInfoLabel sizeThatFits:maximumLabelSize];
    [self.tableView addSubview:carInfoLabel];
    [carInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.offset(expectSize3.width);
        make.top.equalTo(redView3.mas_bottom).offset(15);
        make.height.offset(expectSize3.height);
    }];

    
    
    //第四条
    UILabel * redView4 = [[UILabel alloc]init];
    redView4.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    [self.tableView addSubview:redView4];
    [redView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(15);
        make.width.offset(5);
        make.left.offset(15);
        make.top.equalTo(carInfoLabel.mas_bottom).offset(15);
    }];
    
    UILabel * inspectTitle = [UILabel cz_labelWithText:@"外勤考察" fontSize:15 color:[UIColor blackColor]];
    [self.tableView addSubview:inspectTitle];
    [inspectTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(redView4.mas_right).offset(7);
        make.centerY.equalTo(redView4);
    }];

    NSString * str4 = @"外勤组同事对借款人房产、车辆及经营场所，进行了现场确认查看~~~~";
    UILabel * inspectLabel = [UILabel cz_labelWithText:str4 fontSize:13 color:[UIColor darkGrayColor]];
    inspectLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize expectSize4 = [inspectLabel sizeThatFits:maximumLabelSize];
    [self.tableView addSubview:inspectLabel];
    [inspectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.offset(expectSize4.width);
        make.top.equalTo(redView4.mas_bottom).offset(15);
        make.height.offset(expectSize4.height);
    }];

    
    //第五条
    UILabel * redView5 = [[UILabel alloc]init];
    redView5.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    [self.tableView addSubview:redView5];
    [redView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(15);
        make.width.offset(5);
        make.left.offset(15);
        make.top.equalTo(inspectLabel.mas_bottom).offset(15);
    }];
    
    UILabel * checkTitle = [UILabel cz_labelWithText:@"风控审核" fontSize:15 color:[UIColor blackColor]];
    [self.tableView addSubview:checkTitle];
    [checkTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(redView5.mas_right).offset(7);
        make.centerY.equalTo(redView5);
    }];

    NSString * str5 = @"风控对借款人提供的资料，及外勤组同事考核结果进行综合审核分析，给予抵押额度3万~~~~";
     _checkLabel = [UILabel cz_labelWithText:str5 fontSize:13 color:[UIColor darkGrayColor]];
    _checkLabel.lineBreakMode = NSLineBreakByTruncatingTail;
   _expectSize5 = [_checkLabel sizeThatFits:maximumLabelSize];
    [self.tableView addSubview:_checkLabel];
    [_checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.offset(_expectSize5.width);
        make.top.equalTo(redView5.mas_bottom).offset(15);
        make.height.offset(_expectSize5.height );  //当做底部间距
    }];

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 800;
    return _expectSize5.height + _checkLabel.frame.origin.y +30 ;//_checkLabel刚进来没有值
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
