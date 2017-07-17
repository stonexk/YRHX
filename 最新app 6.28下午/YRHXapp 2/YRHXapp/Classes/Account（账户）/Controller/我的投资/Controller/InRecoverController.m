//
//  InRecoverController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/2.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "InRecoverController.h"
#import "InInvestCell.h"
#import "Masonry.h"
#import "DetailInRecoverController.h"
#import "NoRecoverController.h"

@interface InRecoverController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@end
static NSString * cellID = @"cellID";
@implementation InRecoverController

//懒加载
-(UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenBounds.size.width, KscreenHeight-109)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //if判断 有没有内容
    
    
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [UIView new];
    
    
    //导航栏文字 和 左边按钮
    self.navigationItem.title = nil;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back1)];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self setUpLastFooterView];
}
- (void)back1 {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//设置底部视图
- (void)setUpLastFooterView
{
    UIButton * LastFooterView =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 30)];
    [LastFooterView setTitle:@"全部加载完啦~" forState:UIControlStateNormal];
    [LastFooterView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    LastFooterView.titleLabel.font = [UIFont systemFontOfSize:10];
    LastFooterView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = LastFooterView;
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 115;
    }
    return 130;
}


#pragma 数据源方法===============
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell * topCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];

        UIImageView * picImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"回收中背景"]];
        picImg.contentMode = UIViewContentModeScaleAspectFit;
        [topCell addSubview:picImg];
        [picImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.height.offset(62);
        }];
  
        UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth * 0.5, 115)];
        [topCell addSubview:leftView];

        UILabel * willearnLabel2 = [[UILabel alloc]init];
        willearnLabel2.text = @"000.00";
        willearnLabel2.font = [UIFont systemFontOfSize:18];
        willearnLabel2.textColor = [UIColor blackColor];
        [leftView addSubview:willearnLabel2];
        [willearnLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(leftView);
        }];
        
        UILabel * willearnLabel1 = [[UILabel alloc]init];
        willearnLabel1.text = @"待赚利息总额";
        willearnLabel1.font = [UIFont systemFontOfSize:13];
        willearnLabel1.textColor = [UIColor darkGrayColor];
        [leftView addSubview:willearnLabel1];
        [willearnLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(leftView);
            make.bottom.equalTo(willearnLabel2.mas_top).offset(-5);
        }];
        

        UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(KscreenWidth * 0.5, 0, KscreenWidth * 0.5, 115)];
        
        UILabel * willgetLabel2 = [[UILabel alloc]init];
        willgetLabel2.text = @"000.00";
        willgetLabel2.font = [UIFont systemFontOfSize:18];
        willgetLabel2.textColor = [UIColor blackColor];
        [rightView addSubview:willgetLabel2];
        [willgetLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(rightView);
        }];
        
        
        [topCell addSubview:rightView];
        
        UILabel * willgetLabel1 = [[UILabel alloc]init];
        willgetLabel1.text = @"待收本金总额";
        willgetLabel1.font = [UIFont systemFontOfSize:13];
        willgetLabel1.textColor = [UIColor darkGrayColor];
        [rightView addSubview:willgetLabel1];
        [willgetLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(rightView);
            make.bottom.equalTo(willgetLabel2.mas_top).offset(-5);
        }];
        
        return topCell;
    }
    
    
    InInvestCell * InInvestcell = [[NSBundle mainBundle]loadNibNamed:@"InInvestCell" owner:nil options:nil].lastObject;
    
    return InInvestcell;
    
}

//选中某一行cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section != 0) {
        
        
        //根据后台传回来的接口判断 跳转哪个界面 有投资/无投资
        //    if (<#condition#>) {
        //            NoRecoverController * noRecoverVC = [[NoRecoverController alloc]initWithNibName:@"NoRecoverController" bundle:[NSBundle mainBundle]];
        //    [self.navigationController pushViewController:noRecoverVC animated:YES];
        //    }

        DetailInRecoverController * detailVC = [[DetailInRecoverController alloc]init];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
}


@end
