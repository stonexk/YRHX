//
//  RealNameController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/21.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "RealNameController.h"
#import "ZYKeyboardUtil.h"
#import "STTextHudTool.h"
#import "Masonry.h"
#import "UILabel+CZAddition.h"
#import "UIColor+ColorChange.h"
//#import "RealNamePopController.h"

@interface RealNameController ()

@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;  //键盘自适应属性

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *numIDTF;

@property (nonatomic ,strong) UIView * deliverView; //底部View
@property (nonatomic ,strong) UIView * BGView; //遮罩



@end

@implementation RealNameController

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
    
    self.navigationItem.title = @"实名认证";
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
    __weak RealNameController *weakSelf = self;
    
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.nameTF,weakSelf.numIDTF,nil];
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



- (IBAction)saveButtonClick:(UIButton *)sender
{
    //保存数据   
//    NSLog(@"实名认证成功");
    
    
    [self appearClick];
}




//实名认证底部弹出的投标方式View==================================================================
- (void)appearClick {
    // ------全屏遮罩
    self.BGView                 = [[UIView alloc] init];
    self.BGView.frame           = [[UIScreen mainScreen] bounds];
    self.BGView.tag             = 100;
    self.BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.BGView.opaque = NO;

    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:self.BGView];
    
    //给全屏遮罩添加的点击事件
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitClick)];
    gesture.numberOfTapsRequired = 1;
    gesture.cancelsTouchesInView = NO;
    [self.BGView addGestureRecognizer:gesture];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
    
    
    //底部弹出的View
    self.deliverView = [[UIView alloc] init];
    self.deliverView.frame = CGRectMake((KscreenWidth-230)/2, 200, 230, 100);
    self.deliverView.layer.cornerRadius = 5;
    self.deliverView.backgroundColor = [UIColor whiteColor];
    [appWindow addSubview:self.deliverView];
    
    //View出现动画
    self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, KscreenHeight);
    [UIView animateWithDuration:0.4 animations:^{
        self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
    }];
    
    ////底部View上的控件
    UILabel * titleLab = [UILabel cz_labelWithText:@"您已通过实名认证" fontSize:16 color:[UIColor darkGrayColor]];
    [self.deliverView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.deliverView).offset(17);
        make.centerY.equalTo(self.deliverView).offset(-15);
    }];

    UIImageView * picImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"redTick"]];
    [self.deliverView addSubview:picImg];
    [picImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLab);
        make.right.equalTo(titleLab.mas_left).offset(-5);
        make.width.height.offset(23.5);
    }];
    
    UILabel * detailab = [UILabel cz_labelWithText:@"+20积分" fontSize:20 color:[UIColor colorWithHexString:@"eb413d"]];
    detailab.font = [UIFont fontWithName:@"Helvetica-Bold" size:21];
    [self.deliverView addSubview:detailab];
    [detailab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.deliverView);
        make.bottom.offset(-20);
    }];
}

////点击屏幕。
//- (void)buttonTapped:(UIButton *)sender
//{
//
//    [self exitClick];
//}



//view跳出返回上个界面
- (void)exitClick {
    
    [UIView animateWithDuration:0.4 animations:^{
        
        self.deliverView.transform = CGAffineTransformMakeTranslation(0.01, KscreenHeight);
        self.deliverView.alpha = 0.2;
        self.BGView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.BGView removeFromSuperview];
        [self.deliverView removeFromSuperview];
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}




@end
