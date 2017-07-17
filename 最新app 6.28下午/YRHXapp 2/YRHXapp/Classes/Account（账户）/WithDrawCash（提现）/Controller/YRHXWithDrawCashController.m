//
//  YRHXWithDrawCashController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/15.
//  Copyright © 2017年 zw. All rights reserved.
//   4234111

#import "YRHXWithDrawCashController.h"
#import "QFDatePickerView.h"
#import "STTextHudTool.h"
#import "UITableViewController+ZZStaticCellHiddenShow.h"
#import "UIColor+ColorChange.h"
#import "WithdrawCashRecordController.h"
#import "WithoutDrawCashRecordController.h"

@interface YRHXWithDrawCashController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *tixianMoneyTF;  //提现金额TF
@property (weak, nonatomic) IBOutlet UITextField *payTypeTF;    //提现手续费方式

@property (weak, nonatomic) IBOutlet UITableViewCell *cell_yuan;   //元

@property (nonatomic, strong) NSArray *roleArr;
@property (nonatomic, strong) UIView *BGView;
@property (nonatomic, assign) NSInteger textContentId;
@property (nonatomic, copy) NSString *textContent;


@property (weak, nonatomic) IBOutlet UILabel *leftChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel * rightChangeLabel;



@end

@implementation YRHXWithDrawCashController

- (NSArray *)roleArr{
    if (!_roleArr) {
        _roleArr = [[NSArray alloc] initWithObjects:@"不使用优惠",@"使用免费提现次数",@"使用积分抵扣", nil];
    }
    return _roleArr;
}

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
 
    self.payTypeTF.delegate = self;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    self.navigationItem.title = @"提现";

    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,60,30)];
    [rightButton setTitle:@"提现记录" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightButton addTarget:self action:@selector(searchprogram)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    self.tableView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.tableView addGestureRecognizer:singleTap];
    _tixianMoneyTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    self.tableView.tableFooterView = [UIView new];
}

//点击空白处  键盘回收
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    [self.view endEditing:YES];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchprogram
{
    //根据接口返回来的数据 判断有没有新标。选择跳转哪个界面
    //    if (<#condition#>) {
    //
    //        WithoutDrawCashRecordController * withoutVC = [[WithoutDrawCashRecordController alloc]initWithNibName:@"WithoutDrawCashRecordController" bundle:[NSBundle mainBundle]];
    //    [self.navigationController pushViewController:withoutVC animated:YES];
    //    }

    WithdrawCashRecordController * cashVC = [WithdrawCashRecordController new];
    [self.navigationController pushViewController:cashVC animated:YES];
}



//按钮的监听方法
- (IBAction)nextStepBtnClick:(UIButton *)sender
{
    if ([self.tixianMoneyTF.text isEqualToString:@""]) {
        [self cueMessage:@"请输入提现金额"];
    }
    
    //跳转到新的界面

}

- (void)cueMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}


//组间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}





//pickerView=======================================================
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.payTypeTF) {
        textField.inputView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==self.payTypeTF) {
        [self setupBackView];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField==self.payTypeTF) {
        
        textField.text=self.textContent;
    }
    return YES;
}


-(void)setupBackView{
    self.textContentId=0;
    self.textContent=self.roleArr[0];
    
    
    self.BGView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.BGView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView:)];
    [self.BGView addGestureRecognizer:tapGesture];
    [self.view addSubview:self.BGView];
    
    UIView* chooseView=[[UIView alloc]initWithFrame:CGRectMake(0,self.view.bounds.size.height/2 + 50, self.view.bounds.size.width, self.view.bounds.size.height/2 - 50)];
    chooseView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.BGView addSubview:chooseView];
    
    UIView* topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height/2)];
    [topView setBackgroundColor:[UIColor clearColor]];
    
    
    UIView* toolView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [toolView setBackgroundColor:[UIColor colorWithHexString:@"#f5f5f5"]];
    [chooseView addSubview:toolView];
    
    UIButton* cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,10, 40, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(calcelButtton:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:cancelBtn];
    
    UIButton* sureBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-40, 10, 40, 30)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureButtton:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:sureBtn];
    
    UIPickerView* pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(toolView.frame),chooseView.frame.size.width,chooseView.frame.size.height-50 )];
    [chooseView addSubview:pickerView];
  
    pickerView.delegate=self;
    pickerView.dataSource=self;
    
}


-(void)closeView: (UITextField*)textField{
    
    [self.payTypeTF resignFirstResponder];
    [self.BGView removeFromSuperview];
}

-(void)calcelButtton: (UIButton*)btn{
    [self.payTypeTF resignFirstResponder];
    [self.BGView removeFromSuperview];
}

-(void)sureButtton: (UIButton*)btn{
    
    [self.payTypeTF resignFirstResponder];
    [self.BGView removeFromSuperview];
    
}

// 返回选择器有几列.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// 返回每组有几行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.roleArr.count;
}


#pragma mark - 代理
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.roleArr[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger selectedIndex = [pickerView selectedRowInComponent:0];
    self.textContent=self.roleArr[selectedIndex];
    self.textContentId=(int)selectedIndex+1;
    
    if (row == 0) {
        self.rightChangeLabel.text = @"需要-元";
        self.leftChangeLabel.text = nil;
    }
    if (row == 1) {
        self.rightChangeLabel.text = @"免费提现次数剩余-次";
        self.leftChangeLabel.text = nil;
    }
    if (row == 2) {
        self.rightChangeLabel.text = @"可用-积分";
        self.leftChangeLabel.text = @"需要200积分";
    }
}



@end
