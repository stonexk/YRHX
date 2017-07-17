//
//  HaveChoiceVoucherController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/24.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "HaveChoiceVoucherController.h"
#import "HaveChoiceVoucherCell.h"
#import "VoucherRulesController.h"


@interface HaveChoiceVoucherController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UILabel * testLabel;

@end

@implementation HaveChoiceVoucherController

//懒加载
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, KscreenHeight - 64)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(turn)];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];

    self.navigationItem.title = @"选择优惠券";
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];

    [rightButton setTitle:@"使用帮助" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    [rightButton addTarget:self action:@selector(newSelectionProjects)forControlEvents:UIControlEventTouchUpInside];
    
//这个testLabel是随便设置的
//   _testLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 100, 21)];
//    _testLabel.backgroundColor = [UIColor cyanColor];
//    _testLabel.text = @"测试传值得label";
//    [self.tableView addSubview:_testLabel];
    
}



//监听方法
- (void)turn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)newSelectionProjects
{
    VoucherRulesController * rulesVC = [[VoucherRulesController alloc]initWithNibName:@"VoucherRulesController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:rulesVC animated:YES];
}




//数据源方法==========================
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HaveChoiceVoucherCell * Havecell = [[NSBundle mainBundle]loadNibNamed:@"HaveChoiceVoucherCell" owner:nil options:nil].lastObject;
    
    
    return Havecell;
    
}

//选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    //测试传值  这个testLabel是随便设置的
//    if (_zwBlock) {
//        _zwBlock(self.testLabel.text);
//    }
    
    [self.navigationController popViewControllerAnimated:YES];
}




@end
