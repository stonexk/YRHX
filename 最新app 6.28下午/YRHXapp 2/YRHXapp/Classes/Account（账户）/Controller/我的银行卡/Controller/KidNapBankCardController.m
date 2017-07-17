//
//  KidNapBankCardController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/9.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "KidNapBankCardController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "UILabel+CZAddition.h"
#import "ZYKeyboardUtil.h"
#import <SMS_SDK/SMSSDK.h>


@interface KidNapBankCardController ()<UITextFieldDelegate>

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性
@property (strong, nonatomic) UITextField * messageTF;  //验证码TF

@property (strong, nonatomic) UILabel * phoneNumLabel; //用户手机号码
@end

@implementation KidNapBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = @"绑定银行卡";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    //添加手势 -->键盘
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    [self keyBoard];
    
    [self setupUI];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


//点击空白处  键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.view endEditing:YES];
}


- (void)keyBoard
{
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    
    [self configKeyBoardRespond];
    
    
}


- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] initWithKeyboardTopMargin:40];
    __weak KidNapBankCardController *weakSelf = self;

    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.messageTF,nil];
    }];

    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {

    }];
}



- (void)setupUI
{
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 17.5, [UIScreen mainScreen].bounds.size.width, 165)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
  
    UILabel * cardTypeLab = [UILabel cz_labelWithText:@"卡类型" fontSize:18 color:[UIColor blackColor]];
    [backView addSubview:cardTypeLab];
    [cardTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.top.equalTo(backView).offset(18);
        make.width.offset(90);
    }];
    
    
    UILabel * cardTypeLabel = [UILabel cz_labelWithText:@"中国建行" fontSize:18 color:[UIColor blackColor]];
    [backView addSubview:cardTypeLabel];
    [cardTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(100);
        make.centerY.equalTo(cardTypeLab);    }];
    

    
    UILabel * whiteLineLabel1 = [[UILabel alloc]init];
    whiteLineLabel1.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:whiteLineLabel1];
    [whiteLineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(cardTypeLab.mas_bottom).offset(18);
    }];
    
    
    
    UILabel * personLab = [UILabel cz_labelWithText:@"持卡人" fontSize:18 color:[UIColor blackColor]];
    [backView addSubview:personLab];
    [personLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.top.equalTo(whiteLineLabel1.mas_bottom).offset(18);
        make.width.offset(90);
    }];
    
    UILabel * personLabel = [UILabel cz_labelWithText:@"张三" fontSize:18 color:[UIColor blackColor]];
    [backView addSubview:personLabel];
    [personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(100);
        make.centerY.equalTo(personLab);
    }];
    
    
    UILabel * whiteLineLabel2 = [[UILabel alloc]init];
    whiteLineLabel2.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:whiteLineLabel2];
    [whiteLineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(personLab.mas_bottom).offset(18);
    }];
    
    
    
    UILabel * phoneNumLab = [UILabel cz_labelWithText:@"手机号" fontSize:18 color:[UIColor blackColor]];
    [backView addSubview:phoneNumLab];
    [phoneNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.top.equalTo(whiteLineLabel2.mas_bottom).offset(18);
        make.width.offset(90);
    }];
    
    _phoneNumLabel = [UILabel cz_labelWithText:@"1008001" fontSize:18 color:[UIColor blackColor]];
    [backView addSubview:_phoneNumLabel];
    [_phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(100);
        make.centerY.equalTo(phoneNumLab);
    }];

    

    
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(backView.mas_bottom).offset(17.5);
        make.height.offset(55);
    }];
    
    UILabel * messageLab = [UILabel cz_labelWithText:@"验证码" fontSize:18 color:[UIColor blackColor]];
    [bottomView addSubview:messageLab];
    [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(17.5);
        make.top.equalTo(bottomView).offset(18);
        make.width.offset(80);
    }];
    
    
    _messageTF = [[UITextField alloc]init];
    _messageTF.placeholder = @"请输入图形验证码";
    _messageTF.font = [UIFont systemFontOfSize:18];
    [bottomView addSubview:_messageTF];
    [_messageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(80);
        make.centerY.equalTo(messageLab);
        make.width.offset(screenBounds.size.width - 160);
    }];
    

    UIButton * btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"获取" forState:UIControlStateNormal];
    btn1.layer.cornerRadius=3;
    btn1.backgroundColor = [UIColor colorWithHexString:@"#1294f6"];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(messageLab);
        make.right.equalTo(bottomView.mas_right).offset(-15);
        make.width.offset(60);
        make.height.offset(25);
    }];
    
    [btn1 addTarget:self action:@selector(getMessageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    UIButton * sureBtn = [[UIButton alloc]init];
    [self.view addSubview:sureBtn];
    sureBtn.clipsToBounds = YES;
    sureBtn.layer.cornerRadius=10;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"#1294f6"];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(bottomView.mas_bottom).offset(18);
        make.right.equalTo(self.view).offset(-15);
        make.height.offset(47.5);
    }];
    
    //    监听方法
    [sureBtn addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)getMessageBtnClick
{
    //self.phoneNumLabel.text就是上面显示的用户手机号
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumLabel.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error){
                                     if (!error) {
                                         NSLog(@"获取验证码成功");
                                     } else {
                                         NSLog(@"错误信息：%@",error);
                                     }
                                 }];

    
}

- (void)sureButtonClick
{
    UIViewController * registerVc = [[UIViewController alloc]init];
    [self.navigationController pushViewController:registerVc animated:YES];

}




@end
