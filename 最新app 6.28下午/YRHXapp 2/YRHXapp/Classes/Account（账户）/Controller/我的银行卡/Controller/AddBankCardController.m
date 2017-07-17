//
//  AddBankCardController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/9.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "AddBankCardController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "UILabel+CZAddition.h"
#import "MQVerCodeImageView.h"
#import "ZYKeyboardUtil.h"
#import "KidNapBankCardController.h"

@interface AddBankCardController ()<UITextFieldDelegate>

//图形验证码
@property (nonatomic, strong) MQVerCodeImageView * codeImage;
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性
@property (nonatomic, strong)  UITextField * bankCardNumberTF;
@property (nonatomic, strong) UITextField * yanzhengTF;


@end

@implementation AddBankCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = @"选择银行卡";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    //添加手势 ---》键盘
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
    __weak AddBankCardController *weakSelf = self;
    
    //全自动键盘弹出/收起处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
    
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.bankCardNumberTF,weakSelf.yanzhengTF,nil];
    }];
    
    //获取键盘信息
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
        NSLog(@"\n\n拿到键盘信息 和 ZYKeyboardUtil对象");
    }];
}



- (void)setupUI
{
    UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(17.5, 0, KscreenWidth, 50)];
    headLabel.text = @"请绑定持卡人本人的银行卡";
    headLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:headLabel];
    

    
    
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, KscreenWidth, 110)];
    midView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:midView];
 
    
    UILabel * nameLab = [UILabel cz_labelWithText:@"持卡人" fontSize:18 color:[UIColor blackColor]];
    [midView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(midView).offset(17.5);
        make.top.equalTo(midView).offset(18);
        make.width.offset(70);
    }];
    
    UILabel * nameLabel = [UILabel cz_labelWithText:@"CCC" fontSize:18 color:[UIColor blackColor]];
    [midView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(midView.mas_left).offset(110);
        make.centerY.equalTo(nameLab);
        make.right.equalTo(midView).offset(0);
    }];
    
    UILabel * whiteLineLabel1 = [[UILabel alloc]init];
    whiteLineLabel1.backgroundColor = [UIColor lightGrayColor];
    [midView addSubview:whiteLineLabel1];
    [whiteLineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(nameLab.mas_bottom).offset(15);
    }];

    
    UILabel * IDNumberLab = [UILabel cz_labelWithText:@"身份证号" fontSize:18 color:[UIColor blackColor]];
    [midView addSubview:IDNumberLab];
    [IDNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(midView).offset(17.5);
        make.top.equalTo(whiteLineLabel1.mas_bottom).offset(15);
        make.width.offset(100);
    }];
    
    UILabel * IDNumberLabel = [UILabel cz_labelWithText:@"000**" fontSize:18 color:[UIColor blackColor]];
    [midView addSubview:IDNumberLabel];
    [IDNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(midView.mas_left).offset(110);
        make.centerY.equalTo(IDNumberLab);
        make.right.equalTo(midView).offset(0);
    }];

    
    
    UIView * footView = [[UIView alloc]init];
    footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(midView.mas_bottom).offset(17.5);
        make.height.offset(110);
    }];
    
    UILabel * bankCardNumberLab = [UILabel cz_labelWithText:@"卡号" fontSize:18 color:[UIColor blackColor]];
    [footView addSubview:bankCardNumberLab];
    [bankCardNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(17.5);
        make.top.equalTo(footView).offset(18);
        make.width.offset(50);
    }];
    

    _bankCardNumberTF = [[UITextField alloc]init];
    _bankCardNumberTF.placeholder = @"银行卡号";
    _bankCardNumberTF.font = [UIFont systemFontOfSize:18];
    [footView addSubview:_bankCardNumberTF];
    [_bankCardNumberTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView.mas_left).offset(80);
        make.centerY.equalTo(bankCardNumberLab);
        make.right.offset(0);
    }];
    
    UILabel * whiteLineLabel3 = [[UILabel alloc]init];
    whiteLineLabel3.backgroundColor = [UIColor lightGrayColor];
    [footView addSubview:whiteLineLabel3];
    [whiteLineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(0);
        make.height.offset(1);
        make.top.equalTo(bankCardNumberLab.mas_bottom).offset(15);
    }];
    
    
    
    
    UILabel * codeLab = [UILabel cz_labelWithText:@"图形码" fontSize:18 color:[UIColor blackColor]];
    [footView addSubview:codeLab];
    [codeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(17.5);
        make.top.equalTo(whiteLineLabel3.mas_bottom).offset(15);
        make.width.offset(70);
    }];
    
    _yanzhengTF = [[UITextField alloc]init];
    _yanzhengTF.placeholder = @"请输入图形码";
    _yanzhengTF.font = [UIFont systemFontOfSize:18];
    [footView addSubview:_yanzhengTF];
    [_yanzhengTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView.mas_left).offset(80);
        make.centerY.equalTo(codeLab);
        make.width.offset(screenBounds.size.width - 160);
    }];
    
    
    //图形验证码View
    _codeImage = [[MQVerCodeImageView alloc] initWithFrame:CGRectMake(screenBounds.size.width - 85, 240, 80, 40)];
    [self.view addSubview:_codeImage];
    
    _codeImage.bolck = ^(NSString *imageCodeStr){//看情况是否需要
        NSLog(@"imageCodeStr = %@",imageCodeStr);
    };
    _codeImage.isRotation = NO;
    [_codeImage freshVerCode];
    
    //点击刷新
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [_codeImage addGestureRecognizer:tap];
    [self.view addSubview: _codeImage];
    
    
     //蓝色按钮
    UIButton * nextBtn = [[UIButton alloc]init];
    [self.view addSubview:nextBtn];
    nextBtn.clipsToBounds = YES;
    nextBtn.layer.cornerRadius=10;
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor colorWithHexString:@"#1294f6"];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(footView.mas_bottom).offset(18);
        make.right.equalTo(self.view).offset(-15);
        make.height.offset(47.5);
    }];
    
    //    监听方法
    [nextBtn addTarget:self action:@selector(remakeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)remakeButtonClick
{
    KidNapBankCardController * view = [[KidNapBankCardController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}



//图形验证码的点击方法
- (void)tapClick:(UITapGestureRecognizer*)tap
{
    [_codeImage freshVerCode];
}

@end
