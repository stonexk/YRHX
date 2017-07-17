//
//  YRHXStartBuyController.m
//  YRHXapp
//
//  Created by Apple on 2017/4/19.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXStartBuyController.h"
#import "RecommendModel.h"
#import "StartBuyTopCell.h"
#import "StartBuyMidCell.h"
#import "StartBuyBottomCell.h"
#import "Masonry.h"
#import "TouBiaoView.h"
#import "UIColor+ColorChange.h"
//#import "YRHXConfirmBuyController.h"


@interface YRHXStartBuyController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray * dataArray;
@property (nonatomic,weak) TouBiaoView * toubiaoView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)StartBuyTopCell * topCell;

@end

static NSString *topCellID = @"topCellID";
static NSString *midCellID = @"midCellID";
static NSString *bottomCellID = @"bottomCellID";


@implementation YRHXStartBuyController

StartBuyBottomCell * bottomCell;//底部cell


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
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.view addSubview:self.tableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    //显示导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 清空阴影图片
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    // 取消半透明效果
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    
    
    //导航栏文字 和 左边按钮
    self.navigationItem.title = nil;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
 
    self.dataArray =  [self loadingPlistData];
  
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    self.tableView.tableFooterView = [UIView new];
    
    //最底部视图
    //    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 64,  [UIScreen mainScreen].bounds.size.width, 70)];
    //    bottomView.backgroundColor = [UIColor whiteColor];
    //    [self.navigationController.view addSubview:bottomView];
    //    [self.navigationController.view bringSubviewToFront:bottomView];
    
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
    [btn setTitle:@"我要投标" forState:UIControlStateNormal];
    [footView addSubview:btn];
    btn.backgroundColor = [UIColor colorWithHexString:@"1294f6"];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(15);
        make.bottom.right.equalTo(footView).offset(-15);
        make.height.offset(47.5);
    }];
    
  
#pragma  在控制器设置模型属性。通过标的进度，判断界面能不能跳转#######################也可设置按钮不能跳转时背景色
    //监听事件
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
 
    

}

//- (void)buttonClick:(UIButton *)button
//{
//    YRHXConfirmBuyController * confirmBuyVC = [[YRHXConfirmBuyController alloc]init];
//    
//    [self.navigationController pushViewController:confirmBuyVC animated:YES];
//}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma   数据源方法==================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0 || section == 1) {
         return 1;
    }
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        _topCell = [[NSBundle mainBundle]loadNibNamed:@"StartBuyTopCell" owner:nil options:nil].lastObject;
        
        
        return _topCell;
    }
    else if (indexPath.section == 1){
        StartBuyMidCell * midCell = [[NSBundle mainBundle]loadNibNamed:@"StartBuyMidCell" owner:nil options:nil].lastObject;
        
        return midCell;
    }
    
    RecommendModel * recommendMode = self.dataArray[indexPath.row];
    
    bottomCell = [[NSBundle mainBundle]loadNibNamed:@"StartBuyBottomCell" owner:nil options:nil].lastObject;
    
    bottomCell.imageView.image = [UIImage imageNamed:recommendMode.icon];
    [bottomCell.imageView sizeToFit];
    bottomCell.textLabel.text = recommendMode.title;
    bottomCell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return bottomCell;
}

//每组高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }
    else if (indexPath.section == 1) {
        return 160;
    }
    
    return 44;
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



//加载Plist文件
- (NSArray *)loadingPlistData
{
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"buy.plist" withExtension:nil];
    NSArray * array = [NSArray arrayWithContentsOfURL:url];

    NSMutableArray * arrM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (id dict in array) {
        RecommendModel * model = [RecommendModel RecommendModelWithDict:dict];
        
        [arrM addObject:model];
    }
    return arrM.copy;
}


@end
