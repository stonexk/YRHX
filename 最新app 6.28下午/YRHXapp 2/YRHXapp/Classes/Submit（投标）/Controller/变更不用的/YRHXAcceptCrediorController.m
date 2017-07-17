//
//  YRHXAcceptCrediorController.m
//  YRHXapp
//
//  Created by Apple on 2017/4/24.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXAcceptCrediorController.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
#import "MQVerCodeImageView.h"
#import "UIColor+ColorChange.h"
#import "ZYKeyboardUtil.h"
#import "WSAuthCode.h"

@interface YRHXAcceptCrediorController ()
//图形验证码
@property (nonatomic, strong) MQVerCodeImageView * codeImageView;

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性
@property (strong, nonatomic) UITextField * passWordTF;
@property (strong, nonatomic) UITextField * picImageTF;
//图形验证码
@property (strong, nonatomic)WSAuthCode * codeImage;
@end



@implementation YRHXAcceptCrediorController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    

    self.navigationItem.title = nil;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];

    //添加手势 ---键盘
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    [self keyBoard];
}


- (void)keyBoard
{
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    [self configKeyBoardRespond];
}


- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] initWithKeyboardTopMargin:40];
    __weak YRHXAcceptCrediorController *weakSelf = self;
    
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.passWordTF,weakSelf.picImageTF, nil];
    }];
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {

    }];
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.view endEditing:YES];
}


- (void)setupUI
{
    //整个白色的View  370
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    
    //剩余本金label
    UILabel * shengyuLabel = [UILabel cz_labelWithText:@"剩余本金" fontSize:14 color:[UIColor darkGrayColor]];
    [backView addSubview:shengyuLabel];
    [shengyuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(backView).offset(17.5);
    }];
    
    //钱数label
    UILabel * moneyLabel1 = [UILabel cz_labelWithText:@"3428.98" fontSize:21 color:[UIColor blackColor]];
    [backView addSubview:moneyLabel1];
    [moneyLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.top.equalTo(shengyuLabel.mas_bottom).offset(10);
    }];
    
    //元
    UILabel * yuanLabel1 = [UILabel cz_labelWithText:@"元" fontSize:14 color:[UIColor darkGrayColor]];
    [backView addSubview:yuanLabel1];
    [yuanLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyLabel1.mas_right).offset(0);
        make.centerY.equalTo(moneyLabel1);
    }];
    
    
    //剩余期限label
    UILabel * qixianLabel = [UILabel cz_labelWithText:@"剩余期限" fontSize:14 color:[UIColor darkGrayColor]];
    [backView addSubview:qixianLabel];
    [qixianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(screenBounds.size.width * 0.5);
        make.centerY.equalTo(shengyuLabel);
    }];
    
    
    UILabel * countLabel1 = [UILabel cz_labelWithText:@"00" fontSize:21 color:[UIColor blackColor]];
    [backView addSubview:countLabel1];
    [countLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(screenBounds.size.width * 0.5);
        make.centerY.equalTo(moneyLabel1);
    }];
    
    //个月label
    UILabel * monthLabel1 = [UILabel cz_labelWithText:@"个月" fontSize:14 color:[UIColor darkGrayColor]];
    [backView addSubview:monthLabel1];
    [monthLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countLabel1.mas_right).offset(0);
        make.centerY.equalTo(countLabel1);
    }];
    
    
    //承接价格label
    UILabel * chengjieLabel = [UILabel cz_labelWithText:@"承接价格" fontSize:14 color:[UIColor darkGrayColor]];
    [backView addSubview:chengjieLabel];
    [chengjieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.top.equalTo(moneyLabel1.mas_bottom).offset(20);
    }];
    
    UILabel * moneyLabel2 = [UILabel cz_labelWithText:@"2208.99" fontSize:21 color:[UIColor redColor]];
    [backView addSubview:moneyLabel2];
    [moneyLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.top.equalTo(chengjieLabel.mas_bottom).offset(10);
    }];

    //元
    UILabel * yuanLabel2 = [UILabel cz_labelWithText:@"元" fontSize:14 color:[UIColor darkGrayColor]];
    [backView addSubview:yuanLabel2];
    [yuanLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyLabel2.mas_right).offset(0);
        make.centerY.equalTo(moneyLabel2);
    }];
    
    
    //承接收益
    UILabel * shouyiLabel = [UILabel cz_labelWithText:@"承接收益" fontSize:14 color:[UIColor darkGrayColor]];
    [backView addSubview:shouyiLabel];
    [shouyiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(screenBounds.size.width * 0.5);
        make.centerY.equalTo(chengjieLabel);
    }];
    
    
    UILabel * countLabel2 = [UILabel cz_labelWithText:@"66.6" fontSize:21 color:[UIColor blackColor]];
    [backView addSubview:countLabel2];
    [countLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(screenBounds.size.width * 0.5);
        make.centerY.equalTo(moneyLabel2);
    }];
    
    //个月label
    UILabel * yuanLabel3 = [UILabel cz_labelWithText:@"元" fontSize:14 color:[UIColor darkGrayColor]];
    [backView addSubview:yuanLabel3];
    [yuanLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countLabel2.mas_right).offset(0);
        make.centerY.equalTo(countLabel2);
    }];
    

    //转让人label
    UILabel * personLabel1 = [UILabel cz_labelWithText:@"转让人" fontSize:14 color:[UIColor darkGrayColor]];
    [backView addSubview:personLabel1];
    [personLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.top.equalTo(moneyLabel2.mas_bottom).offset(20);
    }];
    
    UILabel * personLabel2 = [UILabel cz_labelWithText:@"XXXXX" fontSize:21 color:[UIColor blackColor]];
    [backView addSubview:personLabel2];
    [personLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.top.equalTo(personLabel1.mas_bottom).offset(10);
    }];
    

    //近期回款日label
    UILabel * huikuanLabel = [UILabel cz_labelWithText:@"近期回款日" fontSize:14 color:[UIColor darkGrayColor]];
    [backView addSubview:huikuanLabel];
    [huikuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(screenBounds.size.width * 0.5);
        make.centerY.equalTo(personLabel1);
    }];
    
    
    UILabel * timeLabel = [UILabel cz_labelWithText:@"XXXX-XX-XX" fontSize:21 color:[UIColor blackColor]];
    [backView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(screenBounds.size.width * 0.5);
        make.centerY.equalTo(personLabel2);
    }];
    
    //支付密码textfield
    _passWordTF = [[UITextField alloc]init];
    _passWordTF.placeholder = @"请输入支付密码";
    _passWordTF.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_passWordTF setBorderStyle:UITextBorderStyleRoundedRect];
    [backView addSubview:_passWordTF];
    [_passWordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.height.offset(52.5);
        make.right.equalTo(backView).offset(-17.5);
        make.top.equalTo(personLabel2.mas_bottom).offset(20);
    }];
    
    //图形码textfield
    _picImageTF = [[UITextField alloc]init];
    _picImageTF.placeholder = @"请输入图形码";
    _picImageTF.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_picImageTF setBorderStyle:UITextBorderStyleRoundedRect];
    [backView addSubview:_picImageTF];
    [_picImageTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(17.5);
        make.height.offset(52.5);
        make.width.offset(KscreenWidth - 120);   // afsbsbnmc
        make.top.equalTo(_passWordTF.mas_bottom).offset(10);
    }];

    //确认承接button
    UIButton * btn = [[UIButton alloc]init];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius=10;
    [btn setTitle:@"确认承接" forState:UIControlStateNormal];
    [backView addSubview:btn];
    btn.backgroundColor = [UIColor colorWithHexString:@"1294f6"];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(15);
        make.right.equalTo(backView).offset(-15);
        make.height.offset(47.5);
        make.top.equalTo(_picImageTF.mas_bottom).offset(20);
    }];
    
    
//    //监听事件
//    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    
//    //图形验证码View
//    _codeImageView = [[MQVerCodeImageView alloc] initWithFrame:CGRectMake(Kwidth * 2 + 27.5, 300, Kwidth, 45)];
//    [backView addSubview:_codeImageView];
//
//    _codeImageView.bolck = ^(NSString *imageCodeStr){//看情况是否需要
//        NSLog(@"imageCodeStr = %@",imageCodeStr);
//    };
//    _codeImageView.isRotation = NO;
//    [_codeImageView freshVerCode];
//    
//    //点击刷新
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
//    [_codeImageView addGestureRecognizer:tap];
//    [self.view addSubview: _codeImageView];

//    _codeImage = [[WSAuthCode alloc]initWithFrame:CGRectMake(Kwidth * 2 + 27.5, 300, Kwidth, 45)];
    _codeImage = [[WSAuthCode alloc]initWithFrame:CGRectMake(KscreenWidth-92.5, 303, 80, 40)];
    _codeImage.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_codeImage];
    
    
 
    UILabel * yuegbel = [UILabel cz_labelWithText:@"753842.99" fontSize:16 color:[UIColor blackColor]];
    [backView addSubview:yuegbel];
    [yuegbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(20);
        make.centerX.equalTo(backView);
        make.height.offset(35);
    }];
    
    //可用余额label
    UILabel * keyongbel = [UILabel cz_labelWithText:@"可用余额" fontSize:14 color:[UIColor darkGrayColor]];
    [backView addSubview:keyongbel];
    [keyongbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(yuegbel.mas_left).offset(-5);
        make.centerY.equalTo(yuegbel);
    }];
    

    UILabel * yuanLabel4 = [UILabel cz_labelWithText:@"元" fontSize:14 color:[UIColor darkGrayColor]];
    [backView addSubview:yuanLabel4];
    [yuanLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yuegbel.mas_right).offset(5);
        make.centerY.equalTo(yuegbel);
    }];
    

}
//验证码
- (void)reloadAction {
    [_codeImage reloadAuthCodeView];
}


- (void)yanzhengAction {
    
    BOOL isOk = [_codeImage startAuthWithString:_picImageTF.text];
   
    if (isOk) {
        [self cueMessage:@"匹配正确"];
        
    }else{
        [self cueMessage:@"验证码错误"];
        
        //这里面写验证失败之后的动作.
        [_codeImage reloadAuthCodeView];
    }
}


- (void)cueMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}


////图形验证码的点击方法
//- (void)tapClick:(UITapGestureRecognizer*)tap
//{
//    [_codeImageView freshVerCode];
//}



- (void)buttonClick:(UIButton *)button
{
    UIViewController * VC = [[UIViewController alloc]init];
    VC.view.backgroundColor = [UIColor orangeColor];
    
    [self.navigationController pushViewController:VC animated:YES];
}





- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}







@end
