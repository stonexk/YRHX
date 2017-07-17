//
//  YRHXTopUpController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/12.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXTopUpController.h"
#import "TopUpRecordController.h"
#import "TopUpNoRecordController.h"


@interface YRHXTopUpController ()


@property (weak, nonatomic) IBOutlet UITextField *topUpMoneyTF;   //充值金额TF

@property (weak, nonatomic) IBOutlet UIButton * nextStepBtn;    //立即充值按钮

@end

@implementation YRHXTopUpController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor darkGrayColor];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = @"充值";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [rightButton setTitle:@"充值记录" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightButton addTarget:self action:@selector(topUpRecord)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;

    _topUpMoneyTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    //添加手势 ---键盘
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



//监听方法
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];    
}

- (void)topUpRecord
{
    //根据接口返回来的数据 判断有没有新标。选择跳转哪个界面
//    if (<#condition#>) {
//        
//        TopUpRecordController * recordVC = [TopUpRecordController new];
//        [self.navigationController pushViewController:recordVC animated:YES];
//        
//    }

    TopUpNoRecordController * norecordVC = [[TopUpNoRecordController alloc]initWithNibName:@"TopUpNoRecordController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:norecordVC animated:YES];
    
}






//立即充值按钮
- (IBAction)topUpSoonBtnClick:(UIButton *)sender {
    if ([self.topUpMoneyTF.text isEqualToString:@""]) {
        [self cueMessage:@"请输入充值金额"];
    }
    
    //跳转到新的界面
}




- (void)cueMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end
