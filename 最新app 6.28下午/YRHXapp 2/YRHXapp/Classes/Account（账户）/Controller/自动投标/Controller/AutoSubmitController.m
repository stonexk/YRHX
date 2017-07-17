//
//  AutoSubmitController.m
//  YRHXapp
//
//  Created by 詹稳 on 17/6/7.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "AutoSubmitController.h"
#import "STTextHudTool.h"
#import "QFDatePickerView.h"
#import "UITableViewController+ZZStaticCellHiddenShow.h"
#import "UIColor+ColorChange.h"
#import "Masonry.h"
#import "DetailSubmitController.h"
#import "AutoRulesController.h"

typedef enum : NSUInteger {
    TFType1 = 100,
    TFType2
}TFType;

@interface AutoSubmitController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic ,assign) TFType TFType;

@property (weak, nonatomic) IBOutlet UISwitch *AutoSwitch;    //自动投标开关
@property (weak, nonatomic) IBOutlet UISwitch *switch0; //使用理财券开关
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (weak, nonatomic) IBOutlet UIStackView *bottomView;
@property (weak, nonatomic) IBOutlet UIStackView *upView;


@property (weak, nonatomic) IBOutlet UILabel *buxianLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn; //排队详情按钮
@property (weak, nonatomic) IBOutlet UILabel *minPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxPriceLabel;


@property (weak, nonatomic) IBOutlet UITextField *priorityModeTF;//优先方式TF
@property (weak, nonatomic) IBOutlet UITextField *payModeTF;//还款方式TF


@property (nonatomic ,strong) UIView * deliverView; //底部View
@property (nonatomic ,strong) UIView * BGView; //遮罩
@property (nonatomic ,strong) UILabel * label1;
@property (nonatomic ,strong) UILabel * label2;
@property (nonatomic ,strong) UIButton * button1;
@property (nonatomic ,strong) UIButton * button2;


@property (nonatomic, strong) NSArray *roleArr;
@property (nonatomic, strong) NSArray *roleArr2;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *bgView2;
@property (nonatomic, assign) NSInteger textContentId;
@property (nonatomic, copy) NSString *textContent;
@property (nonatomic, assign) NSInteger textContentId2;
@property (nonatomic, copy) NSString *textContent2;

@end

@implementation AutoSubmitController

- (NSArray *)roleArr{
    if (!_roleArr) {
        _roleArr = [[NSArray alloc] initWithObjects:@"不限",@"等额本息",@"先息后本", nil];
    }
    return _roleArr;
}

- (NSArray *)roleArr2{
    if (!_roleArr2) {
        _roleArr2 = [[NSArray alloc] initWithObjects:@"过期时间优先",@"金额优先", nil];
    }
    return _roleArr2;
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
    
    self.payModeTF.delegate = self;
    self.priorityModeTF.delegate = self;
   
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompactPrompt];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;

    self.title = @"自动投标";    
    UIButton* ruleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,80,30)];
    [ruleBtn setTitle:@"自动投标规则" forState:UIControlStateNormal];
    [ruleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    ruleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [ruleBtn addTarget:self action:@selector(ruleBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:ruleBtn];
    self.navigationItem.rightBarButtonItem= rightItem;
    

    // 取自动投标按钮的值
    self.AutoSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"isAutoSwitch"] ? YES : NO;
    // 隐藏/显示View
    [self hideView:!self.AutoSwitch.on];
    self.AutoSwitch.onTintColor = [UIColor colorWithHexString:@"#1294f6"];

    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
}
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

//右上角规则按钮
- (void)ruleBtnClick
{
//    AutoSubmitRuleController * rulesVC = [[AutoSubmitRuleController alloc]initWithNibName:@"AutoSubmitRuleController" bundle:[NSBundle mainBundle]];
//    [self.navigationController pushViewController:rulesVC animated:YES];
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"AutoRulesController" bundle:nil];
    AutoRulesController * topUpVC = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:topUpVC animated:YES];
}

// 隐藏显示View的方法
- (void)hideView:(BOOL)is {
    self.saveBtn.hidden = is;
    self.bottomView.hidden = is;
    self.upView.hidden = is;
}





// 点击自动投标按钮
- (IBAction)clickSwitch:(id)sender {
    // 强转为UISwitch
    UISwitch *switchBtn = (UISwitch *)sender;
    // 记录按钮状态
    [[NSUserDefaults standardUserDefaults] setBool:switchBtn.on forKey:@"isAutoSwitch"];
    // 隐藏/显示View
    [self hideView:!switchBtn.on];
}

//排队详情按钮
- (IBAction)lineDetail:(UIButton *)sender {
    DetailSubmitController * submitVC = [DetailSubmitController new];
    [self.navigationController pushViewController:submitVC animated:YES];
}



//自定义投标按钮
- (IBAction)customSubmitBtnClick:(UIButton *)sender {
    
    [self appearClick];
    NSLog(@"%@",_buxianLabel.text);
}


//日期期限范围
- (IBAction)timeRangeBtnClick:(UIButton *)sender
{
    QFDatePickerView * datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *s1) {
        self.leftLabel.text = s1;
        
    } with:^(NSString *s2) {
        self.rightLabel.text = s2;
    }];
    
    [datePickerView show];
    
}

//优先方式按钮
- (IBAction)priorityTypeBtnClick:(UIButton *)sender {
    NSLog(@"hahha ");
}



//单次最小投标金额按钮
- (IBAction)minPriceBtnClick:(UIButton *)sender {
    //弹框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入最小投标金额" preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加按钮
    __weak typeof(alert) weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"点击了确定按钮--%@-%@", [weakAlert.textFields.firstObject text], [weakAlert.textFields.lastObject text]);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    
    // 添加文本框
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.textColor = [UIColor redColor];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.text = @"";
        [textField addTarget:self action:@selector(minPriceDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }];
    
    [self presentViewController:alert animated:YES completion:nil];

}



//单次最大投标金额按钮
- (IBAction)maxPriceBtnClick:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入最大投标金额" preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加按钮
    __weak typeof(alert) weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"点击了确定按钮--%@-%@", [weakAlert.textFields.firstObject text], [weakAlert.textFields.lastObject text]);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    
    // 添加文本框
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.textColor = [UIColor redColor];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.text = @"";
        [textField addTarget:self action:@selector(maxPriceDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}


//还款方式按钮
- (IBAction)payTypeBtnClick:(UIButton *)sender {
    
}





//保存设置按钮
- (IBAction)saveBtnClick:(UIButton *)sender {
    
    if ([_minPriceLabel.text  integerValue]  < 50 || [_maxPriceLabel.text integerValue] < [_minPriceLabel.text integerValue] ) {
        [STTextHudTool showText:@"单次最小投标金额需为不小于50 且不大于单次最大投标金额的整数"];
    }
    else if ([self.leftLabel.text integerValue] > [self.rightLabel.text integerValue]) {
        [STTextHudTool showText:@"贷款期限起始日期不能大于结束日期"];
    }
    else
    {
        [STTextHudTool showText:@"保存成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}





- (void)minPriceDidChange:(UITextField *)textField
{
    self.minPriceLabel.text = textField.text;
    
    
}

- (void)maxPriceDidChange:(UITextField *)textField
{
    self.maxPriceLabel.text = textField.text;
    
}






//投标方式底部弹出的投标方式View==================================================================
- (void)appearClick {
    // ------全屏遮罩
    self.BGView                 = [[UIView alloc] init];
    self.BGView.frame           = [[UIScreen mainScreen] bounds];
    self.BGView.tag             = 100;
    self.BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.BGView.opaque = NO;
    
    //--UIWindow的优先级最高，Window包含了所有视图，在这之上添加视图，可以保证添加在最上面
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:self.BGView];
    
    // ------给全屏遮罩添加的点击事件
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitClick)];
    gesture.numberOfTapsRequired = 1;
    gesture.cancelsTouchesInView = NO;
    [self.BGView addGestureRecognizer:gesture];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
    }];
    

    // ------底部弹出的View
    self.deliverView = [[UIView alloc] init];
    self.deliverView.frame = CGRectMake(0, KscreenHeight - 165, KscreenWidth, 165);
    self.deliverView.backgroundColor = [UIColor whiteColor];
    [appWindow addSubview:self.deliverView];
    
    // ------View出现动画
    self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, KscreenHeight);
    [UIView animateWithDuration:0.4 animations:^{
        
        self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
        
    }];
    
    
    //添加白色view
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 50)];
    whiteView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.deliverView addSubview:whiteView];
    //添加确定和取消按钮
    for (int i = 0; i < 2; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((KscreenWidth - 60) * i, 0, 60, 50)];
        [button setTitle:i == 0 ? @"取消" : @"确定" forState:UIControlStateNormal];
        if (i == 0) {
            [button setTitleColor:[UIColor colorWithRed:97.0 / 255.0 green:97.0 / 255.0 blue:97.0 / 255.0 alpha:1] forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        [whiteView addSubview:button];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10 + i;
    }
    
    _button1 = [[UIButton alloc]initWithFrame:CGRectMake(60, 90,85, 35)];
//    [_button1 setBackgroundColor:[UIColor colorWithHexString:@"1294f6"]];
    [_button1 setBackgroundImage:[UIImage imageNamed:@"等级边框"] forState:UIControlStateNormal];
    _button1.clipsToBounds = YES;
    _button1.layer.cornerRadius = 18;
    [self.deliverView addSubview:_button1];
    
    _label1 = [[UILabel alloc]init];
    _label1.text = @"自定义投标";
    _label1.textColor = [UIColor colorWithHexString:@"1294f6"];
    _label1.font = [UIFont systemFontOfSize:14];
    _buxianLabel.text = _label1.text;
    
    [_button1 addSubview:_label1];
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_button1);
    }];
    
    [_button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
    
    
    _button2 = [[UIButton alloc]initWithFrame:CGRectMake(KscreenWidth - 145, 90, 85, 35)];
//    [_button2 setBackgroundColor:[UIColor colorWithHexString:@"1294f6"]];
    [_button2 setBackgroundImage:[UIImage imageNamed:@"等级边框"] forState:UIControlStateNormal];
    [self.deliverView addSubview:_button2];
    
    _label2 = [[UILabel alloc]init];
    _label2.text = @"智能投标";
    _label2.textColor = [UIColor colorWithHexString:@"1294f6"];
    _label2.font = [UIFont systemFontOfSize:14];
    _buxianLabel.text = _label2.text;
    [_button2 addSubview:_label2];
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_button2);
    }];
    
    [_button2 addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
}

//功能： View退出
- (void)exitClick {

    [UIView animateWithDuration:0.4 animations:^{
        
        self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, KscreenHeight);
        self.deliverView.alpha = 0.2;
        self.BGView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.BGView removeFromSuperview];
        [self.deliverView removeFromSuperview];
    }];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)buttonTapped:(UIButton *)sender {
    
    [self exitClick];

}

- (void)button1Click
{
    _label1.text = @"自定义投标";
    _buxianLabel.text = _label1.text;
}

- (void)button2Click
{
    _label2.text = @"智能投标";
    _buxianLabel.text = _label2.text;
}





//pickerView=======================================================
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.payModeTF ) {
        textField.inputView = [[UIView alloc] initWithFrame:CGRectZero];
        self.TFType = TFType1;
    }
    if (textField==self.priorityModeTF) {
        textField.inputView = [[UIView alloc] initWithFrame:CGRectZero];
        self.TFType = TFType2;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==self.payModeTF) {
        self.TFType = TFType1;
        [self setupBackView];
    }
    if (textField == self.priorityModeTF) {
        self.TFType = TFType2;
        [self setupBackView2];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (textField==self.payModeTF ) {
        textField.text=self.textContent;
    }
    if (textField==self.priorityModeTF) {
        textField.text=self.textContent2;

    }
    return YES;
}


-(void)setupBackView{

    self.textContentId=0;
    self.textContent=self.roleArr[0];

    
    self.bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.bgView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView:)];
    [self.bgView addGestureRecognizer:tapGesture];
    [self.view addSubview:self.bgView];
    
    UIView* chooseView=[[UIView alloc]initWithFrame:CGRectMake(0,self.view.bounds.size.height/2 + 50, self.view.bounds.size.width, self.view.bounds.size.height/2 - 50)];
    chooseView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.bgView addSubview:chooseView];
    
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



-(void)setupBackView2{

    self.textContentId2=0;
    self.textContent2=self.roleArr2[0];
    
    self.bgView2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.bgView2 setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView:)];
    [self.bgView2 addGestureRecognizer:tapGesture];
    [self.view addSubview:self.bgView2];
    
    UIView* chooseView=[[UIView alloc]initWithFrame:CGRectMake(0,self.view.bounds.size.height/2 + 50, self.view.bounds.size.width, self.view.bounds.size.height/2 - 50)];
    chooseView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.bgView2 addSubview:chooseView];
    
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
    
    [self.payModeTF resignFirstResponder];
    [self.priorityModeTF resignFirstResponder];
    [self.bgView removeFromSuperview];
    [self.bgView2 removeFromSuperview];
}

-(void)calcelButtton: (UIButton*)btn{
    [self.payModeTF resignFirstResponder];
    [self.priorityModeTF resignFirstResponder];
    [self.bgView removeFromSuperview];
    [self.bgView2 removeFromSuperview];
}

-(void)sureButtton: (UIButton*)btn{
    
    [self.payModeTF resignFirstResponder];
    [self.priorityModeTF resignFirstResponder];
    [self.bgView removeFromSuperview];
    [self.bgView2 removeFromSuperview];
}

// 返回选择器有几列.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// 返回每组有几行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    switch (_TFType) {
        case TFType1:
            return self.roleArr.count;
            break;
        case TFType2:
            return self.roleArr2.count;
            break;
        default:
            break;
    }

}


#pragma mark - 代理
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (_TFType) {
        case TFType1:
            return self.roleArr[row];
            break;
        case TFType2:
            return self.roleArr2[row];
            break;
        default:
            break;
    }

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (_TFType) {
        case TFType1:
        {
            NSInteger selectedIndex = [pickerView selectedRowInComponent:0];
            self.textContent=self.roleArr[selectedIndex];
            self.textContentId=(int)selectedIndex+1;
        }
            break;
        case TFType2:
        {
            NSInteger selectedIndex2 = [pickerView selectedRowInComponent:0];
            self.textContent2=self.roleArr2[selectedIndex2];
            self.textContentId2=(int)selectedIndex2+1;
        }
            break;
        default:
            break;
    }
}




@end
