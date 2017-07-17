//
//  PersonInfoController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/20.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "PersonInfoController.h"
#import "ZYKeyboardUtil.h"
#import "STTextHudTool.h"


@interface PersonInfoController ()

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *numIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;

@property (weak, nonatomic) IBOutlet UITextField *adreesTF;
@property (weak, nonatomic) IBOutlet UITextField *otherNameTF;
@property (weak, nonatomic) IBOutlet UITextField *relationTF;
@property (weak, nonatomic) IBOutlet UITextField *otherPhoneTF;



@end

@implementation PersonInfoController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
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
    
    self.navigationItem.title = @"个人资料";
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.tableView addGestureRecognizer:singleTap];
    [self keyBoard];
    
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
    __weak PersonInfoController *weakSelf = self;
    
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.adreesTF,weakSelf.otherNameTF,weakSelf.relationTF,weakSelf.otherPhoneTF,nil];
    }];
    
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
    }];
}

- (void)goBack {    
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




//保存按钮
- (IBAction)saveButtonClick:(UIButton *)sender
{

    if ([self.adreesTF.text isEqualToString:@""]) {
        [STTextHudTool showText:@"请填写您的住址"];
    }
    else if ([self.otherNameTF.text isEqualToString:@""]) {
        [STTextHudTool showText:@"请填写紧急联系人姓名"];
    }
    else if ([self.relationTF.text isEqualToString:@""]) {
        [STTextHudTool showText:@"请填写您与紧急联系人关系"];
    }
    else if ([self.otherPhoneTF.text isEqualToString:@""] || !(self.otherPhoneTF.text.length == 11)) {
        [STTextHudTool showText:@"请填写紧急联系人手机号码"];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
            
            /*要刷新一下数据，返回的界面要有东西*/
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }


    
}

@end
