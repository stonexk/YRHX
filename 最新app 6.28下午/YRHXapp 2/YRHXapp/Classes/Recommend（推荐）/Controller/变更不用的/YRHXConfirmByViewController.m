//
//  YRHXConfirmByViewController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/24.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXConfirmByViewController.h"
#import "ConfirmBuyTopCell.h"
#import "ConfirmBuyMidCell.h"
#import "ConfirmBuyBottomCell.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "VoucherView.h"
#import "VoucherModel.h"
#import "VoucherCell.h"
#import "oneViewController.h"

@interface YRHXConfirmByViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *topCellID = @"topCellID";
static NSString *midCellID = @"midCellID";
static NSString *bottomCellID = @"bottomCellID";
@implementation YRHXConfirmByViewController

-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, tableViewHeight)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    self.navigationItem.title = @"确认投资";
    
    
    [self.view addSubview:self.tableView];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:midCellID];
    
    
    //底部按钮VIew
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.offset(77.5);
    }];
    
    UIButton * btn = [[UIButton alloc]init];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius=10;
    [btn setTitle:@"立即投标" forState:UIControlStateNormal];
    [footView addSubview:btn];
    btn.backgroundColor = [UIColor colorWithHexString:@"1294f6"];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(15);
        make.bottom.right.equalTo(footView).offset(-15);
        make.height.offset(47.5);
    }];
    
    //监听事件
    [btn addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //添加手势 ---》键盘
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    
}

//点击空白处  键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.view endEditing:YES];
}






- (void)buttonClick1:(UIButton *)button
{
    oneViewController * VC = [[oneViewController alloc]init];
    
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)back {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma   数据源方法==============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    if (section == 0 || section == 1) {
    return 1;
    //    }
    //        return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    //    if (indexPath.section == 0) {
    //        StartBuyTopCell * topCell = [[NSBundle mainBundle]loadNibNamed:@"StartBuyTopCell" owner:nil options:nil].lastObject;
    //
    //
    //        return topCell;
    //    }
    //    else if (indexPath.section == 1){
    //        StartBuyMidCell * midCell = [[NSBundle mainBundle]loadNibNamed:@"StartBuyMidCell" owner:nil options:nil].lastObject;
    //
    //        return midCell;
    //    }
    //
    //    RecommendModel * recommendMode = self.dataArray[indexPath.row];
    //
    //    StartBuyBottomCell * bottomCell = [[NSBundle mainBundle]loadNibNamed:@"StartBuyBottomCell" owner:nil options:nil].lastObject;
    //
    //    bottomCell.imageView.image = [UIImage imageNamed:recommendMode.icon];
    //    [bottomCell.imageView sizeToFit];
    //    bottomCell.textLabel.text = recommendMode.title;
    //    bottomCell.textLabel.font = [UIFont systemFontOfSize:14];
    
    
    if (indexPath.section == 0) {
        ConfirmBuyTopCell * topCell = [[NSBundle mainBundle]loadNibNamed:@"ConfirmBuyTopCell" owner:nil options:nil].lastObject;
        
        return topCell;
    }
    else if (indexPath.section == 1) {
        //        ConfirmBuyMidCell * midCell = [[NSBundle mainBundle]loadNibNamed:@"ConfirmBuyMidCell" owner:nil options:nil].lastObject;
        //
        //        return midCell;
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:midCellID forIndexPath:indexPath];
        
        VoucherView * voucherView = [[VoucherView alloc] init];
        
        // 2.传递数据
        voucherView.voucherData = [self loadVoucherModelData];
        // 3.添加到父控件上
        [cell addSubview:voucherView];
        
        [voucherView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.left.offset(0);
        }];
        
        
        return cell;
        
        
    }
    
    ConfirmBuyBottomCell * bottomCell = [[NSBundle mainBundle]loadNibNamed:@"ConfirmBuyBottomCell" owner:nil options:nil].lastObject;
    
    
    return bottomCell;
}

//每组高度  165
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 175;
    }
    else if (indexPath.section == 1) {
        //第二组
        return 200;
    }
    
    return 90;
}

//组间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

//选中某一行  动画效果
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (NSArray *)loadVoucherModelData {
    
    /*
     优惠券不能用Plist 因为每个用户优惠券的张数不能确定。智能有接口之后，请求方法用获取到的模型来进行赋值。不能写死。
     （参考爱鲜蜂。）
     */
    
    
    NSArray *array = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"voucher.plist" withExtension:nil]];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [arrayM addObject:[VoucherModel VoucherModelWithDict:obj]];
    }];
    
    return arrayM.copy;
    
    
}

@end
