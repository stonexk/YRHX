//
//  YRHXScoresMallController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/5.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXScoresMallController.h"
#import "Masonry.h"
#import "YRHXIntegralCollectionCell.h"
#import "ZFBMineOptionCell.h"
#import "YRHXFlowLayout.h"
#import "NSArray+CZAddition.h"
#import "YRHXFlowLayout.h"
#import "UILabel+CZAddition.h"
#import "UIColor+ColorChange.h"
#import "YRHXCircleView.h"
#import "GoodsExchangeController.h"
#import "integrationDetailController.h"
#import "ExchangeRecordController.h"
#import "ScrollImage.h"
#import "oneViewController.h"
#import "TotalGoodsController.h"
#import "InvestVoucherController.h"
#import "RealGoodsController.h"
#import "ElectronicCardController.h"

@interface YRHXScoresMallController ()<ScrollImageDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
//,UICollectionViewDelegate,UICollectionViewDataSource>
{
    // 记录滚动的偏移量
    CGFloat contentOffsetY;
    CGFloat oldContentOffsetY;
    CGFloat newContentOffsetY;
}


@property (strong, nonatomic) UIView *mainView;  //底层view
@property (strong, nonatomic) UIView *topView;  //可隐藏view
@property(nonatomic,weak)UIView * headView;  //轮播器view
@property(nonatomic,strong)YRHXCircleView * cycleView;  //轮播器
@property (strong, nonatomic) UIView *categaryView;  //分类view

@property(nonatomic,weak)UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) UICollectionView * collectionView;
@property(nonatomic,strong)UIButton * selectedBtn;
@property (nonatomic,weak) UIButton * firstBtn;
@property(nonatomic,weak)UIScrollView * contentView;
@property(nonatomic,weak)UIView * lineView;
@property (nonatomic, strong) NSArray *mineOptionsData;

@end

static NSString *ID = @"cell";

@implementation YRHXScoresMallController

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
    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.collectionView];
    self.navigationItem.title = @"积分商城";
 
    [self setupUI];
    [self creatSmallCategaryView];
    [self creatContentView];
    
    
    
    //添加拖拽收拾
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    //设置代理
    pan.delegate = self;
    
    [self.view addGestureRecognizer:pan];
    
    
    
    
    
    
    
    
    
//    
//    YRHXFlowLayout * flowLayout = [[YRHXFlowLayout alloc] init];
//    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    self.collectionView = collectionView;
//    [self.view addSubview:collectionView];
//    
//    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.categaryView.mas_bottom).offset(10);
//        make.height.equalTo(self.view.mas_height).offset(-52);
//        make.width.equalTo(self.view.mas_width);
//        make.left.offset(0);
//        
//    }];
//
////    注册机制 数据源
//    UINib *optionCellNib = [UINib nibWithNibName:@"ZFBMineOptionCell" bundle:nil];
//    [self.collectionView registerNib:optionCellNib forCellWithReuseIdentifier:ID];
//    self.mineOptionsData = [self loadMineOptionsData];
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)setupUI
{
    // 底层的View
    UIView * mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.bottom.width.equalTo(self.view);
    }];
    self.mainView = mainView;
    
    // topView(可隐藏)
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    topView.hidden = NO;
    [mainView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(mainView);
        make.top.offset(1);
        make.height.offset(205 * KscreenWidth / 375);
    }];
    self.topView = topView;
    
    
    UIButton * leftTitleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth/2,45 * KscreenWidth / 375)];
    [leftTitleBtn setBackgroundColor:[UIColor whiteColor]];
    [topView addSubview:leftTitleBtn];
    [leftTitleBtn addTarget:self action:@selector(leftTitleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * scoreTitle = [UILabel cz_labelWithText:@"积分" fontSize:14 color:[UIColor darkGrayColor]];
    [leftTitleBtn addSubview:scoreTitle];
    [scoreTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(leftTitleBtn);
    }];
    
    UILabel * scoreLabel = [UILabel cz_labelWithText:@"0000" fontSize:14 color:[UIColor colorWithHexString:@"eb413d"]];
    [leftTitleBtn addSubview:scoreLabel];
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scoreTitle.mas_right);
        make.centerY.equalTo(scoreTitle);
    }];
    
    UIImageView * scoreImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"积分"]];
    [leftTitleBtn addSubview:scoreImg];
    [scoreImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(23.5);
        make.right.equalTo(scoreTitle.mas_left);
        make.centerY.equalTo(scoreTitle);
    }];
    
    
    UIButton * rightTitleBtn = [[UIButton alloc]initWithFrame:CGRectMake(KscreenWidth/2, 0, KscreenWidth/2,45 * KscreenWidth / 375)];
    [rightTitleBtn setBackgroundColor:[UIColor whiteColor]];
    [topView addSubview:rightTitleBtn];
    [rightTitleBtn addTarget:self action:@selector(rightTitleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * exchangTitle = [UILabel cz_labelWithText:@"兑换记录" fontSize:14 color:[UIColor darkGrayColor]];
    [rightTitleBtn addSubview:exchangTitle];
    [exchangTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(rightTitleBtn);
    }];
    
    UIImageView * exchangImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"兑换记录"]];
    [rightTitleBtn addSubview:exchangImg];
    [exchangImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(23.5);
        make.right.equalTo(exchangTitle.mas_left);
        make.centerY.equalTo(exchangTitle);
    }];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [rightTitleBtn addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(rightTitleBtn).offset(0);
        make.width.offset(1);
    }];
    
//    轮播器
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 55 * KscreenWidth / 375,KscreenWidth, 150 * KscreenWidth / 375)];
    [topView addSubview:headView];
    
//    YRHXCircleView *cycleView = [[YRHXCircleView alloc] initWithFrame:headView.bounds];
//    cycleView.backgroundColor = [UIColor whiteColor];
//    [headView addSubview:cycleView];
//    
//    
//    
//    [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.offset(0);
//    }];
//    self.cycleView = cycleView;
//    self.headView = headView;
    
    
    //    轮播器

    NSArray *array1 = @[
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498194625358&di=4e0940e2a9e4b5585c239b4e2e370901&imgtype=0&src=http%3A%2F%2Fimg15.3lian.com%2F2015%2Ff2%2F101%2Fd%2F104.jpg",
                        
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498789469&di=948818da5cb3f42d2accedeb24089c7c&imgtype=jpg&er=1&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Ff703738da97739120371fe46f2198618367ae246.jpg",
                        
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498194965113&di=08788c25c8f38065ed034ac73aa9adb7&imgtype=0&src=http%3A%2F%2Fdimg02.c-ctrip.com%2Fimages%2Ftg%2F556%2F255%2F459%2F42058039ccac4d1d86425eaf620dd2cc_R_1024_10000.jpg",
                        
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498194810634&di=27631f537ec0b1ce92aa095bdad7563c&imgtype=0&src=http%3A%2F%2Fww1.sinaimg.cn%2Flarge%2F8f7947degw1eh2zzz1smzj20zk0nw45p.jpg",
                        
                        @"http://pic17.huitu.com/res/20140303/86378_20140303213126066200_1.jpg"
                        ];

    ScrollImage *scrl = [[ScrollImage alloc] initWithCurrentController:self
                                                             urlString:array1
                                                             viewFrame:CGRectMake(0, 55 * KscreenWidth / 375,KscreenWidth, 150 * KscreenWidth / 375)
                                                      placeholderImage:[UIImage imageNamed:@"占位图"]];

    scrl.delegate = self;
    scrl.timeInterval = 2.0;
    [headView addSubview:scrl.view];
    
    [scrl.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);

    }];
   self.headView = headView;
}

//代理 跳转界面
- (void)scrollImage:(ScrollImage *)scrollImage clickedAtIndex:(NSInteger)index
{
    NSLog(@"click:%ld",(long)index);
    oneViewController *vc = [[oneViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}





- (void)creatSmallCategaryView
{
    UIView * categaryView = [[UIView alloc]init];
    categaryView.backgroundColor = [UIColor whiteColor];
    [_mainView addSubview:categaryView];
    
    [categaryView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.offset(0);
//        make.width.offset(KscreenWidth);
        make.top.equalTo(self.topView.mas_bottom).offset(1);
        make.height.offset(45 * KscreenWidth / 375);
    }];
    self.categaryView = categaryView;
    
    NSArray * array = @[@"全部商品",@"投资券",@"实物商品",@"电子卡"];
    NSMutableArray * btnArrM = [NSMutableArray array];
    
    for (int i =0; i < array.count; i++) {
        
        UIButton * btn = [[UIButton alloc]init];
        
        [btn setTitle:array[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"eb413d"] forState:UIControlStateSelected];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
        btn.tag = i;
        //监听事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            [self btnClick:btn];
        }
        
        [categaryView addSubview:btn];
        [btnArrM addObject:btn];
    }
    
    
    [btnArrM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(categaryView);
    }];
    
    [btnArrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"eb413d"];
    [self.categaryView addSubview:lineView];
    
    UIButton * firstBtn = btnArrM[0];
    CGFloat pictureRealW = screenBounds.size.width / 4;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(firstBtn);
        make.width.offset(pictureRealW);
        make.height.offset(2);
    }];
    
    self.firstBtn = firstBtn;
    self.lineView = lineView;
}

- (void)btnClick:(UIButton *)btn
{
    btn.selected = YES;
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    
    
    [self.contentView setContentOffset:CGPointMake(btn.tag * self.contentView.bounds.size.width, 0) animated:YES];

    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.firstBtn).offset(btn.tag * self.firstBtn.bounds.size.width);
    }];
}
//代理方法  contentView设置代理才能进方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //更新黄色横线的中心点X
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.firstBtn).offset(page * self.firstBtn.bounds.size.width);
    }];
    
}

//减速结束的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    UIButton * button = self.categaryView.subviews[page];
    button.selected = YES;
    
    self.selectedBtn.selected = NO;
    self.selectedBtn = button;
}








//3   添加内容视图view
- (void)creatContentView
{
    //创建滚动器view
    UIScrollView * contentView = [[UIScrollView alloc]init];
    
    contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    contentView.pagingEnabled = YES;   //设置分页效果
    
    contentView.showsVerticalScrollIndicator = NO;   //取消滚动条
    contentView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:contentView];    //添加到控制器
    //添加约束
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.categaryView.mas_bottom);
        
    }];
    
    TotalGoodsController * totalVc = [[TotalGoodsController alloc]init];
    InvestVoucherController * voucherVc = [[InvestVoucherController alloc]init];
    RealGoodsController * realVc = [[RealGoodsController alloc]init];
    ElectronicCardController * cardVc = [[ElectronicCardController alloc]init];
    
    //把控制器对应的view添加到contentView上
    [contentView addSubview:totalVc.view];
    [contentView addSubview:voucherVc.view];
    [contentView addSubview:realVc.view];
    [contentView addSubview:cardVc.view];
    
    //建立父子关系
    [self addChildViewController:totalVc];
    [self addChildViewController:voucherVc];
    [self addChildViewController:realVc];
    [self addChildViewController:cardVc];
    
    //告诉系统已建立父子关系
    [totalVc didMoveToParentViewController:self];
    [voucherVc didMoveToParentViewController:self];
    [realVc didMoveToParentViewController:self];
    [cardVc didMoveToParentViewController:self];
    
    
    [contentView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];  //布局
    
    [contentView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView);
        make.size.equalTo(contentView);
    }];
    
    
    self.contentView = contentView;
    contentView.delegate = self;
    
}



//选中item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    //商品兑换界面
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"GoodsExchangeController" bundle:nil];
    GoodsExchangeController * exchangeVC = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:exchangeVC animated:YES];
}

//监听方法
- (void)leftTitleBtnClick
{
    integrationDetailController * integrationVC = [[integrationDetailController alloc]init];
    [self.navigationController pushViewController:integrationVC animated:YES];
}

- (void)rightTitleBtnClick
{
    ExchangeRecordController * exchangeVC = [[ExchangeRecordController alloc]init];
    [self.navigationController pushViewController:exchangeVC animated:YES];
}






- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
{
    return YES;
}

- (void)pan:(UIPanGestureRecognizer*)panGesture {
    //获取偏移量
    CGPoint p = [panGesture translationInView:panGesture.view];
    //根据偏移量.获取头部视图的高度
    CGFloat headerHeight = self.topView.bounds.size.height + p.y;
    //置零
    [panGesture setTranslation:CGPointZero inView:self.view];
    //判断拖拽高度
//    || headerHeight < 64
    if(headerHeight > 205 * KscreenWidth / 375  ) {
        return;
    }
    //判断滑动方向
    if(ABS(p.x) > ABS(p.y)) {
        return;
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(headerHeight);
            }];
            

            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            break;
        default:
            break;
    }

}

//   <MASLayoutConstraint:0x1742a8a60 UIView:0x100745040.height

@end
