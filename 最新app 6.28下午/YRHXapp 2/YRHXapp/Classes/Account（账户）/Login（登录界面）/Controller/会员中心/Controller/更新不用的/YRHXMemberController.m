//
//  YRHXMemberController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/2.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXMemberController.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
#import "UIColor+ColorChange.h"
#import "YRHXForgetPWController.h"
#import "MemberModel.h"
#import "MemberViewCell.h"
#import "YRHXLoginPWController.h"
#import "YRHXPayPwController.h"

@interface YRHXMemberController ()

@property(nonatomic,strong)NSArray * memberArray;

@end

static NSString * memberCellID  = @"memberCellID";
static NSString * otherCellID  = @"otherCellID";
@implementation YRHXMemberController

//显示导航栏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.memberArray = [self loadingPlistData];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = [UIView new];
    
    //显示导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 清空阴影图片
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    // 取消半透明效果
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = @"会员中心";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    


    [self.tableView registerClass:[MemberViewCell class] forCellReuseIdentifier:memberCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:otherCellID];
}

- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 17.5;
}


    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!(indexPath.row == 3)) {
        return 57.5;
    }
    return 77.5;
}

//数据源方法================================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.memberArray.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!(indexPath.row == 3)) {
    
        MemberModel * Model = self.memberArray[indexPath.row];
        
        
        MemberViewCell * memberCell = [tableView dequeueReusableCellWithIdentifier:memberCellID forIndexPath:indexPath];
    
        memberCell.textLabel.text = Model.title;
        memberCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return memberCell;
    }
    
    else
    {
        UITableViewCell * otherCell = [tableView dequeueReusableCellWithIdentifier:otherCellID forIndexPath:indexPath];
        otherCell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //退出登录按钮
        UIButton * signOutBtn = [UIButton new];
        signOutBtn.layer.cornerRadius = 10;
        [signOutBtn setBackgroundColor: [UIColor colorWithHexString:@"#1294f6"]];
        [signOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [otherCell addSubview:signOutBtn];
        [signOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.left.offset(15);
            make.height.offset(47.5);
            make.top.offset(30);
        }];
        
        return otherCell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {

    }
    if (indexPath.row == 1) {
        YRHXLoginPWController * loginPWView = [[YRHXLoginPWController alloc]init];
        [self.navigationController pushViewController:loginPWView animated:YES];
    }
    if (indexPath.row == 2) {
        YRHXPayPwController * payPwView = [[YRHXPayPwController alloc]init];
        [self.navigationController pushViewController:payPwView animated:YES];
    }
    

    
}



//加载Plist文件
- (NSArray *)loadingPlistData
{
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"self.plist" withExtension:nil];
    NSArray * array = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray * arrM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (id dict in array) {
        MemberModel * model = [MemberModel MemberModelWithDict:dict];
        
        [arrM addObject:model];
    }
    return arrM.copy;
}



@end
