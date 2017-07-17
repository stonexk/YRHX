//
//  YRHXNewWelfareController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/15.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXNewWelfareController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "ProjectCell.h"
#import "YRHXCircleView.h"
#import "YRHXRegisterViewController.h"

@interface YRHXNewWelfareController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIButton * btn;

@end

static NSString * newCellID = @"newCellID";
@implementation YRHXNewWelfareController


//懒加载
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, tableViewHeight + 77)];
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
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor darkGrayColor];
    
    if ([self isUserLogin]) {
        [self.btn setHidden:YES];
    }
    else
    {
        [self.btn setHidden:NO];
    }
  
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = NO;  //去除cell间的分割线
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;    
    self.title = @"新手福利";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:newCellID];
    
    UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:@"注册领红包" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:252/255.0 green:98/255.0  blue:32/255.0  alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor colorWithRed:254/255.0 green:237/255.0 blue:53/255.0 alpha:1.0];
    self.btn = btn;
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view).offset(0);
        make.height.offset(45);
    }];
    [btn addTarget:self action:@selector(goThere) forControlEvents:UIControlEventTouchUpInside];
    
    
}
//判断用户登录状态  登录了不显示马上注册按钮
-(BOOL)isUserLogin
{
    NSString *userId =  [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_ID"];
    
    if (userId != nil && [userId intValue] > 0)
    {
        //已经登录
        return YES;
    }
    return NO;
    
}





- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)goThere
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"YRHXRegisterViewController" bundle:nil];
    YRHXRegisterViewController * view = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:view animated:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:newCellID forIndexPath:indexPath];
        UIImageView * img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"新手福利1"]];
        [cell addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.offset(0);
            make.height.offset(1111*KscreenWidth/375);
        }];
        
        return cell;
    }
    if (indexPath.row == 1) {
        
            CGFloat imageW = 375;
            CGFloat imageH = 65;
            CGFloat pictureRealW = KscreenWidth;
            CGFloat pictureRealH = imageH * pictureRealW / imageW;
        
            ProjectCell * projectcell = [[NSBundle mainBundle]loadNibNamed:@"ProjectCell" owner:nil options:nil].lastObject;
            projectcell.frame = CGRectMake(10, 0, KscreenWidth-20, 145);
            //添加进度条view
            YRHXCircleView *custom = [[YRHXCircleView alloc]initWithFrame:CGRectMake(screenBounds.size.width - 87.5, 65, pictureRealH, pictureRealH)];
        
            custom.progress = 0.88;
            // 点击YRHXCircleView进去看看
            [projectcell addSubview:custom];
        
            return projectcell;
    }

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:newCellID forIndexPath:indexPath];
    UIImageView * img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"新手福利2"]];
    [cell addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(302*KscreenWidth/375);
    }];
    
    return cell;
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 1111*KscreenWidth/375;
    }
    if (indexPath.row == 1) {
        return 145;
    }
    return 302*KscreenWidth/375;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
