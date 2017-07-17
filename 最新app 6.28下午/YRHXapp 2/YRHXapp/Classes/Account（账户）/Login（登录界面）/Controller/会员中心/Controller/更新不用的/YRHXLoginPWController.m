//
//  YRHXLoginPWController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/2.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXLoginPWController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "ZYKeyboardUtil.h"

@interface YRHXLoginPWController ()

@property(nonatomic,strong)UITextField * pwTF;
@property(nonatomic,strong)UITextField * firstPwTF;
@property(nonatomic,strong)UITextField * secondPwTF;
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性

@end

@implementation YRHXLoginPWController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = @"登录密码";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    //添加手势 ---》键盘
    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finger:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    [self keyBoard];
    
    [self setupUI];
    
    
}

//点击空白处  键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}
-(void)finger:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.view endEditing:YES];
}
- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)keyBoard
{
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    
    [self configKeyBoardRespond];
}


- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] initWithKeyboardTopMargin:40];
    __weak YRHXLoginPWController *weakSelf = self;
    
    //全自动键盘弹出/收起处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
    
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.pwTF,weakSelf.pwTF,weakSelf.firstPwTF,weakSelf.secondPwTF, nil];
    }];
    
    //获取键盘信息
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
        NSLog(@"\n\n拿到键盘信息 和 ZYKeyboardUtil对象");
    }];
}






- (void)setupUI
{
    //第一行
    UIView * oneView = [UIView new];
    oneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:oneView];
    [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(17.5);
        make.height.offset(57.5);
    }];
    
    UIImageView * pwPic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"手机图标"]];
    [oneView addSubview:pwPic];
    [pwPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.width.height.offset(28.5);
        make.centerY.equalTo(oneView);
    }];
    
    _pwTF = [[UITextField alloc]init];
    _pwTF.placeholder = @"请输入原密码";
    [oneView addSubview:_pwTF];
    [_pwTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwPic.mas_right).offset(5);
        make.centerY.equalTo(pwPic);
        make.right.offset(0);
    }];
    
    
    //第二行
    UIView * twoView = [UIView new];
    twoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:twoView];
    [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(oneView.mas_bottom).offset(17.5);
        make.height.offset(58.5);
    }];
    
    UIImageView * firstPwPic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码"]];
    [twoView addSubview:firstPwPic];
    [firstPwPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.width.height.offset(28.5);
        make.centerY.equalTo(twoView);
    }];
    
    _firstPwTF = [[UITextField alloc]init];
    _firstPwTF.placeholder = @"请输入新密码";
    [twoView addSubview:_firstPwTF];
    [_firstPwTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(firstPwPic.mas_right).offset(5);
        make.centerY.equalTo(firstPwPic);
        make.right.offset(0);
    }];
    
    
    //线
    UILabel * lineLab = [[UILabel alloc]init];
    lineLab.backgroundColor = [UIColor lightGrayColor];
    [twoView addSubview:lineLab];
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(0);
        make.bottom.equalTo(twoView.mas_bottom).offset(0);
        make.height.offset(1);
    }];
    
    
    //第三行
    UIView * threeView = [UIView new];
    threeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:threeView];
    [threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(twoView.mas_bottom).offset(0);
        make.height.offset(57.5);
    }];
    
    UIImageView * secondPwPic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码"]];
    [threeView addSubview:secondPwPic];
    [secondPwPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.width.height.offset(28.5);
        make.centerY.equalTo(threeView);
    }];
    
    _secondPwTF = [[UITextField alloc]init];
    _secondPwTF.placeholder = @"再输一遍新密码";
    [threeView addSubview:_secondPwTF];
    [_secondPwTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(secondPwPic.mas_right).offset(5);
        make.centerY.equalTo(secondPwPic);
        make.right.offset(0);
    }];

    
    //底部按钮
    UIButton * remakePWBtn = [[UIButton alloc]init];
    remakePWBtn.layer.cornerRadius = 10;
    [remakePWBtn setBackgroundColor:[UIColor colorWithHexString:@"#1294f6"]];
    [remakePWBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [self.view addSubview:remakePWBtn];
    [remakePWBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(threeView.mas_bottom).offset(30);
        make.height.offset(47.5);
    }];
    
    
    
    
}



@end
