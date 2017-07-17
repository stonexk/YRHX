//
//  IssueCreditorTransferController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/5.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "IssueCreditorTransferController.h"
#import "ZYKeyboardUtil.h"

@interface IssueCreditorTransferController ()

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性
@property (weak, nonatomic) IBOutlet UITextField *giveDiscountTF;   //让利金额区间TF
@property (weak, nonatomic) IBOutlet UITextField *payPasswordTF;   //支付密码TF



@end

@implementation IssueCreditorTransferController

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
    
    self.tableView.tableFooterView = [UIView new];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationItem.title = @"发布债权转让";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.tableView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.tableView addGestureRecognizer:singleTap];
  
    [self keyBoard];

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
    __weak IssueCreditorTransferController *weakSelf = self;

    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.giveDiscountTF,weakSelf.payPasswordTF, nil];
    }];

    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

//确认转让按钮
- (IBAction)IssueTransferButtonClick:(UIButton *)sender
{
    if ([self.giveDiscountTF.text isEqualToString:@""]) {
        [self cueMessage:@"请输入让利金额"];
    }
    else if ([self.payPasswordTF.text isEqualToString:@""]) {
        [self cueMessage:@"请输入支付密码"];
    }
    else
    {
        
    //跳转到新的界面
        
    }
}


- (void)cueMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
