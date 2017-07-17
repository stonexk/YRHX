//
//  YRHXMemberCenterController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/26.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXMemberCenterController.h"


@interface YRHXMemberCenterController ()<WJTouchIDDelegate>

@property(nonatomic,strong) NSArray * memberArray;
@property(nonatomic,strong) UITableViewCell *cell;
@property(nonatomic,strong) MemberViewCell * memberCell;


@property (nonatomic, strong) WJTouchID *touchID;

@end

static NSString * picCellID  = @"picCellID";
static NSString * memberCellID  = @"memberCellID";

@implementation YRHXMemberCenterController

-(UISwitch *)touchIDSwitch
{
    if (!_touchIDSwitch)
    {
        self.touchIDSwitch = [[UISwitch alloc]init];
    }
    return _touchIDSwitch;
}


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
    
    self.navigationItem.title = @"会员中心";
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:picCellID];
    [self.tableView registerClass:[MemberViewCell class] forCellReuseIdentifier:memberCellID];
    
    
    
    
    
    
    
}

- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 140;
    }
    else if (indexPath.section == 3 && indexPath.row == 3){
        return 70;
    }
    return 45;
}

//数据源方法================================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0 ) {
        return 1;
    }
    else if (section == 1 || section == 2)
    {
        return 2;
    }
    else
    {
        return 4;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        //第一组
        _cell = [tableView dequeueReusableCellWithIdentifier:picCellID forIndexPath:indexPath];
        [self setupHeaderView];
        
        return _cell;
    }

    //剩下的几组
    
    _memberCell = [tableView dequeueReusableCellWithIdentifier:memberCellID forIndexPath:indexPath];
    _memberCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 1 && indexPath.row == 0 ) {
        NSString * notFinishStr = @"未完善";
        UILabel * notFinishLabel = [UILabel cz_labelWithText:notFinishStr fontSize:14 color:[UIColor colorWithRed:38/255.0 green:130/255.0 blue:251/255.0 alpha:1]];
        [_memberCell addSubview:notFinishLabel];
        [notFinishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_memberCell);
            make.right.offset(-35);
        }];
        
        UILabel * detailInfoTitle = [UILabel cz_labelWithText:@"详细资料" fontSize:14 color:[UIColor blackColor]];
        [_memberCell addSubview:detailInfoTitle];
        [detailInfoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(notFinishLabel);
            make.left.equalTo(_memberCell.mas_left).offset(15);
        }];
    }
    
    if (indexPath.section == 1 && indexPath.row == 1 ){
        NSString * phoneNumStr = @"17607121318";
        UILabel * phoneNumLabel = [UILabel cz_labelWithText:phoneNumStr fontSize:14 color:[UIColor darkGrayColor]];
        [_memberCell addSubview:phoneNumLabel];
        [phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_memberCell);
            make.right.offset(-35);
        }];

        UILabel * phoneNumTitle = [UILabel cz_labelWithText:@"注册手机号" fontSize:14 color:[UIColor blackColor]];
        [_memberCell addSubview:phoneNumTitle];
        [phoneNumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(phoneNumLabel);
            make.left.equalTo(_memberCell.mas_left).offset(15);
        }];
    }
        
      if (indexPath.section == 2 && indexPath.row == 0 ){
          NSString * identificationStr = @"未认证";
          UILabel * identificationLabel = [UILabel cz_labelWithText:identificationStr fontSize:14 color:[UIColor darkGrayColor]];
          [_memberCell addSubview:identificationLabel];
          [identificationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerY.equalTo(_memberCell);
              make.right.offset(-35);
          }];

          UILabel * identificationTitle = [UILabel cz_labelWithText:@"实名认证" fontSize:14 color:[UIColor blackColor]];
          [_memberCell addSubview:identificationTitle];
          [identificationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerY.equalTo(identificationLabel);
              make.left.equalTo(_memberCell.mas_left).offset(15);
          }];
      }
        
    if (indexPath.section == 2 && indexPath.row == 1 ){
        NSString * bindingStr = @"未绑定";
        UILabel * bindingLabel = [UILabel cz_labelWithText:bindingStr fontSize:14 color:[UIColor darkGrayColor]];
        [_memberCell addSubview:bindingLabel];
        [bindingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_memberCell);
            make.right.offset(-35);
        }];
        
        UILabel * bindingTitle = [UILabel cz_labelWithText:@"我的银行卡" fontSize:14 color:[UIColor blackColor]];
        [_memberCell addSubview:bindingTitle];
        [bindingTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bindingLabel);
            make.left.equalTo(_memberCell.mas_left).offset(15);
        }];
    }
    
    if (indexPath.section == 3 && indexPath.row == 0 ){
        UILabel * loginPwdTitle = [UILabel cz_labelWithText:@"登录密码" fontSize:14 color:[UIColor blackColor]];
        [_memberCell addSubview:loginPwdTitle];
        [loginPwdTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_memberCell);
            make.left.equalTo(_memberCell.mas_left).offset(15);
        }];
    }
    
    if (indexPath.section == 3 && indexPath.row == 1 ){
        UILabel * payPwdTitle = [UILabel cz_labelWithText:@"支付密码" fontSize:14 color:[UIColor blackColor]];
        [_memberCell addSubview:payPwdTitle];
        [payPwdTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_memberCell);
            make.left.equalTo(_memberCell.mas_left).offset(15);
        }];
    }
    
    if (indexPath.section == 3 && indexPath.row == 2 ){
        UILabel * touchIDTitle = [UILabel cz_labelWithText:@"TouchID指纹密码" fontSize:14 color:[UIColor blackColor]];
        [_memberCell addSubview:touchIDTitle];
        [touchIDTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_memberCell);
            make.left.equalTo(_memberCell.mas_left).offset(15);
        }];
        
        self.touchIDSwitch = [[UISwitch alloc]init];
        [_memberCell addSubview:self.touchIDSwitch];
        [_touchIDSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_memberCell);
            make.right.offset(-35);
        }];
        
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"TouchID"] isEqualToString:@"1"])
        {
            self.touchIDSwitch.on = YES;
        }else
        {
            self.touchIDSwitch.on = NO;
        }
        [self.touchIDSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];

        
        

    }
    
    if (indexPath.section == 3 && indexPath.row == 3 ){
        _memberCell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _memberCell.accessoryType = UITableViewCellAccessoryNone;
            UIButton * btn = [[UIButton alloc]init];
            btn.clipsToBounds = YES;
            btn.layer.cornerRadius=20;
            [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_memberCell addSubview:btn];
            btn.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(15);
                make.right.offset(-15);
                make.height.offset(45);
                make.bottom.equalTo(_memberCell.mas_bottom).offset(0);
            }];
        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
        return _memberCell;
}



- (void)setupHeaderView
{
    UIImageView * personPic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"头像"]];
    [_cell addSubview:personPic];
    [personPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_cell);
        make.top.offset(20);
        make.width.height.offset(50);
    }];
    
    NSString * nameStr = @"Caroline";
    UILabel * nameLabel = [UILabel cz_labelWithText:nameStr fontSize:14 color:[UIColor blackColor]];
    [_cell addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(personPic);
        make.top.equalTo(personPic.mas_bottom).offset(10);
    }];
    
    UILabel * integralTitle = [UILabel cz_labelWithText:@"活跃积分:" fontSize:12 color:[UIColor darkGrayColor]];
    [_cell addSubview:integralTitle];
    [integralTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personPic.mas_left).offset(15);
        make.top.equalTo(nameLabel.mas_bottom).offset(15);
    }];
    
     NSString * integralNumStr = @"0000";
    UILabel * integralNumLabel = [UILabel cz_labelWithText:integralNumStr fontSize:12 color:[UIColor darkGrayColor]];
    [_cell addSubview:integralNumLabel];
    [integralNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(integralTitle.mas_right).offset(0);
        make.centerY.equalTo(integralTitle);
    }];
    
    UIButton * levelBtn = [[UIButton alloc]init];
    levelBtn.userInteractionEnabled = NO;
    [levelBtn setBackgroundImage:[UIImage imageNamed:@"等级边框"] forState:UIControlStateNormal];
    [levelBtn setTitle:@"少尉o" forState:UIControlStateNormal];
    [levelBtn setTitleColor:[UIColor colorWithRed:38/255.0 green:130/255.0 blue:251/255.0 alpha:1] forState:UIControlStateNormal];
    levelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    levelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_cell addSubview:levelBtn];
    [levelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(integralTitle);
        make.right.equalTo(integralTitle.mas_left).offset(-15);
        make.height.offset(18);
        make.width.offset(40);
    }];
    
    UILabel * levelLabel = [UILabel cz_labelWithText:@"等级" fontSize:12 color:[UIColor darkGrayColor]];
    [_cell addSubview:levelLabel];
    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(levelBtn.mas_left);
        make.centerY.equalTo(levelBtn);
    }];
                                 
}


//选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0 )
    {//详细资料界面
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"PersonInfoController" bundle:nil];
        PersonInfoController * withDrawVC = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:withDrawVC animated:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 0 )
    {//实名认证界面
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"RealNameController" bundle:nil];
        RealNameController * withDrawVC = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:withDrawVC animated:YES];
    }

    if (indexPath.section == 2 && indexPath.row == 1 )
    {//我的银行卡界面
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"BindingCardController" bundle:nil];
        BindingCardController * withDrawVC = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:withDrawVC animated:YES];
    }
    if (indexPath.section == 3 && indexPath.row == 1 )
    {//支付密码界面
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"PayPasswordController" bundle:nil];
        PayPasswordController * payVC = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:payVC animated:YES];
    }
    if (indexPath.section == 3 && indexPath.row == 2 )
    {//TouchID指纹密码
       
        
        
        
    }
   
  
}



- (void)btnClick
{
    //退出登录
    NSLog(@"退出登录");
    
   //存储 修改状态
    
    
    
    
    
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定退出" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        
     //存储 修改状态
        
    
        [self.navigationController popViewControllerAnimated:YES];
    }]];

    [self presentViewController:alert animated:YES completion:nil];
    
    //返回到登录界面
    YRHXAccountController * loginVC = [YRHXAccountController new];
    [self.navigationController popToViewController:loginVC animated:YES];
    
}








//touchID---------------------------------------------------------------------------------
-(void)changeSwitch:(id)sender
{
    NSLog(@"------changeSwitch-------");
    
    WJTouchID *touchid = [[WJTouchID alloc]init];
    [touchid startWJTouchIDWithMessage:WJNotice(@"Touch ID指纹密码", @"The Custom Message") fallbackTitle:WJNotice(@"", @"Fallback Title") delegate:self];
    self.touchID = touchid;
}
//TouchID验证成功
- (void) WJTouchIDAuthorizeSuccess {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    if (self.touchIDSwitch.on == YES)
    {
        [STTextHudTool showText:@"成功开启指纹解锁"];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TouchID"];
    }else{
         [STTextHudTool showText:@"指纹解锁关闭成功"];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TouchID"];
    }
}

//TouchID验证失败
- (void) WJTouchIDAuthorizeFailure {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    if (self.touchIDSwitch.on == YES){
        self.touchIDSwitch.on = NO;
        [STTextHudTool showText:@"指纹解锁开启失败"];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TouchID"];
    }else
    {
        self.touchIDSwitch.on = YES;
        [STTextHudTool showText:@"指纹解锁关闭失败"];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TouchID"];
    }
}

//取消TouchID验证 (用户点击了取消)
- (void) WJTouchIDAuthorizeErrorUserCancel {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    if (self.touchIDSwitch.on == YES){
        self.touchIDSwitch.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TouchID"];
        
        NSLog(@"jfhasd");
        
    }else
    {
        NSLog(@"------");
        self.touchIDSwitch.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TouchID"];
    }
}

//在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏
- (void) WJTouchIDAuthorizeErrorSystemCancel {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    if (self.touchIDSwitch.on == YES){
        self.touchIDSwitch.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TouchID"];
    }else
    {
        self.touchIDSwitch.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TouchID"];
    }
}

//多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
- (void) WJTouchIDAuthorizeLAErrorTouchIDLockout {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    [STTextHudTool showText:@"验证失败"];
}

//当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
- (void) WJTouchIDAuthorizeLAErrorAppCancel {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    if (self.touchIDSwitch.on == YES){
        self.touchIDSwitch.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TouchID"];
    }else
    {
        self.touchIDSwitch.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TouchID"];
    }
}

//当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
- (void) WJTouchIDAuthorizeLAErrorInvalidContext {
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"touchIDISon"];
    if (self.touchIDSwitch.on == YES){
        self.touchIDSwitch.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TouchID"];
    }else
    {
        self.touchIDSwitch.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TouchID"];
    }
}



@end
