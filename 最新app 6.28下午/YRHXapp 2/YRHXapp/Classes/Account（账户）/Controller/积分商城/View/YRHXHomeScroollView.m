//
//  YRHXHomeScroollView.m
//  YRHXapp
//
//  Created by Apple on 2017/6/1.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXHomeScroollView.h"
#import "UILabel+CZAddition.h"
#import "UIColor+ColorChange.h"
#import "Masonry.h"
#import "YRHXCircleView.h"
#import "YRHXIntegralCollectionController.h"


@interface YRHXHomeScroollView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,weak)UIView * topView;
@property(nonatomic,weak)UIView * headView;
@property(nonatomic,strong)YRHXCircleView * cycleView;
@property(nonatomic,strong)NSMutableArray *iconsArrM;

@property (nonatomic,weak) UIView * categaryView;
@property(nonatomic,strong)UIButton * selectedBtn;
@property(nonatomic,weak)UIScrollView * contentView;
@property (nonatomic,weak) UIButton * firstBtn;
@property(nonatomic,weak)UIView * lineView;
@property(nonatomic,strong)YRHXIntegralCollectionController * homeVC;
@property(nonatomic,strong)UICollectionView *collectionView;


@end
@implementation YRHXHomeScroollView
//{
//    // 记录滚动的偏移量
//    CGFloat contentOffsetY;
//    CGFloat oldContentOffsetY;
//    CGFloat newContentOffsetY;
//}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    NSLog(@"++开始拖拽");
//    contentOffsetY = scrollView.contentOffset.y;
//}
//
//// 滚动时调用此方法
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    
//    newContentOffsetY = scrollView.contentOffset.y;
//    if (newContentOffsetY > oldContentOffsetY && oldContentOffsetY > contentOffsetY) { // 向上滚动
//        NSLog(@"向上滚动");
//    } else if (newContentOffsetY < oldContentOffsetY && oldContentOffsetY < contentOffsetY) {// 向下滚动
//        NSLog(@"向下滚动");
//    }
//    
//    if (scrollView.dragging) { // 拖拽
//        
//        if ((scrollView.contentOffset.y - contentOffsetY) > 5.0f && self.topView.hidden == NO) {  // 向上拖拽
//            NSLog(@"向上拖拽");
//            self.topView.hidden = YES;
//            
//            [self.categaryView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.topView.mas_bottom).offset(-160);
//            }];
//            
//            [UIView animateWithDuration:0.25 animations:^{
//                [self layoutIfNeeded];
//            }];
//            
//        }
//        else if ((contentOffsetY - scrollView.contentOffset.y) > 5.0f && self.topView.hidden == YES)
//        {   // 向下拖拽
//            NSLog(@"向下拖拽");
//            self.topView.hidden = NO;
//            
//            [self.categaryView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.topView.mas_bottom);
//            }];
//            
//        } else {
//            
//        }
//    }
//}
//
//// 完成拖拽(滚动停止时调用此方法，手指离开屏幕前)
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    oldContentOffsetY = scrollView.contentOffset.y;
//    // 滚动到头部时,显示topView
//    if (oldContentOffsetY < 1 && self.topView.hidden == YES) {
//        self.topView.hidden = NO;
//        [self.categaryView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.topView.mas_bottom);
//        }];
//    }
//    
//    NSLog(@"stop %lf", oldContentOffsetY);
//}








-(NSMutableArray *)iconsArrM
{
    if (_iconsArrM == nil) {
        _iconsArrM = [NSMutableArray array];
    }
    return _iconsArrM;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}


-(void)setupUI
{
    //    [self loadNetJsonData];

    
//    self.contentSize = CGSizeMake(0, self.bounds.size.width * 240 / 600 * 5 + self.bounds.size.height + 119);
    
    self.contentSize = CGSizeMake(0, self.bounds.size.width * 2 + 150);
    
    //设置顶部视图  包括轮播器
    [self setupTopView];
    //设置中间一栏视图
    [self creatSmallCategaryView];
    //设置collectionView
    [self setupCollectionView];
    
    self.delegate = self;
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
//    //设置代理
//    pan.delegate = self;
//    
//    [self addGestureRecognizer:pan];
    
}


- (void)setupTopView
{
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, KscreenWidth,205 * KscreenWidth / 375)];
    self.topView = topView;
    [self addSubview:topView];

    
    UIView * leftTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth/2,45 * KscreenWidth / 375)];
    leftTitleView.backgroundColor = [UIColor whiteColor];
    [topView addSubview:leftTitleView];
    
    UILabel * scoreTitle = [UILabel cz_labelWithText:@"积分" fontSize:14 color:[UIColor darkGrayColor]];
    [leftTitleView addSubview:scoreTitle];
    [scoreTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(leftTitleView);
    }];
    
    UILabel * scoreLabel = [UILabel cz_labelWithText:@"0000" fontSize:14 color:[UIColor colorWithHexString:@"eb413d"]];
    [leftTitleView addSubview:scoreLabel];
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scoreTitle.mas_right);
        make.centerY.equalTo(scoreTitle);
    }];
    
    UIImageView * scoreImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"积分"]];
    [leftTitleView addSubview:scoreImg];
    [scoreImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(23.5);
        make.right.equalTo(scoreTitle.mas_left);
        make.centerY.equalTo(scoreTitle);
    }];
    
    
    UIView * rightTitleView = [[UIView alloc]initWithFrame:CGRectMake(KscreenWidth/2, 0, KscreenWidth/2,45 * KscreenWidth / 375)];
    rightTitleView.backgroundColor = [UIColor whiteColor];
    [topView addSubview:rightTitleView];
    
    UILabel * exchangTitle = [UILabel cz_labelWithText:@"兑换记录" fontSize:14 color:[UIColor darkGrayColor]];
    [rightTitleView addSubview:exchangTitle];
    [exchangTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(rightTitleView);
    }];
    
    UIImageView * exchangImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"兑换记录"]];
    [rightTitleView addSubview:exchangImg];
    [exchangImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(23.5);
        make.right.equalTo(exchangTitle.mas_left);
        make.centerY.equalTo(exchangTitle);
    }];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [rightTitleView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(leftTitleView).offset(0);
        make.width.offset(1);
    }];
    
    
    //轮播器
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 55 * KscreenWidth / 375,KscreenWidth, 150 * KscreenWidth / 375)];
    [topView addSubview:headView];
    
    YRHXCircleView *cycleView = [[YRHXCircleView alloc] initWithFrame:headView.bounds];
    cycleView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:cycleView];

    
    
    [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.cycleView = cycleView;
    self.headView = headView;
}


//中间分栏视图
- (void)creatSmallCategaryView
{
    UIView * categaryView = [[UIView alloc]init];
//      WithFrame:CGRectMake(0, 206 * KscreenWidth / 375, KscreenWidth, 45 * KscreenWidth / 375)];
    categaryView.backgroundColor = [UIColor whiteColor];
    [self addSubview:categaryView];

    [categaryView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.offset(0);
        make.width.offset(KscreenWidth);
        make.top.equalTo(self.topView.mas_bottom).offset(1);
        make.height.offset(45 * KscreenWidth / 375);
    }];
    
    self.categaryView = categaryView;
    
    NSArray * array = @[@"最近投资",@"投标中",@"回收中",@"已回收"];
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
        make.height.offset(4);
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
}
//代理方法  contentView设置代理才能进方法
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat page = scrollView.contentOffset.x / scrollView.bounds.size.width;
//
//    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.firstBtn).offset(page * self.firstBtn.bounds.size.width);
//    }];
//  
//}
//减速结束的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;

    UIButton * button = self.categaryView.subviews[page];
    button.selected = YES;
    
    self.selectedBtn.selected = NO;
    self.selectedBtn = button;
}




- (void)setupCollectionView
{
    self.homeVC = [[YRHXIntegralCollectionController alloc]init];
    [self addSubview:self.homeVC.collectionView];
    
    [_homeVC.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categaryView.mas_bottom).offset(10);
        make.height.equalTo(self.mas_height).offset(-113);
        make.width.equalTo(self.mas_width);
        make.left.equalTo(self);
    }];
    
    self.collectionView = _homeVC.collectionView;
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
    [panGesture setTranslation:CGPointZero inView:self];

    //判断拖拽高度
    if(headerHeight > 206 || headerHeight < 64) {
        return;
    }
    //判断滑动方向
    if(ABS(p.x) > ABS(p.y)) {
        return;
        
//        CGFloat alpha = 1 - 1.0 / (206 - 64) * (headerHeight - 64);
//        //判断手势
//        switch (panGesture.state) {
//            case UIGestureRecognizerStateBegan:
//            case UIGestureRecognizerStateChanged:
//                [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
////                    make.height.offset(headerHeight);
//                    make.width.offset(KscreenWidth);
//                    make.top.offset(1);
//                    make.height.offset();
//                }];
//                self.contentSize = CGSizeMake(0, self.bounds.size.width * 2 + 150);
//                self.topView.alpha = alpha;
//                
//                [self.categaryView mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.top.offset(1);
//                    //                make.top.offset(headerHeight);
//                    make.left.right.offset(0);
//                    make.height.offset(45);
//                }];
//                break;
//            case UIGestureRecognizerStateEnded:
//            case UIGestureRecognizerStateCancelled:
//            case UIGestureRecognizerStateFailed:
//                break;
//            default:
//                break;
//        }

        
    }
    CGFloat alpha = 1 - 1.0 / (206 - 64) * (headerHeight - 64);
    //判断手势
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(headerHeight);
            }];
            self.contentSize = CGSizeMake(0, self.bounds.size.width * 2 + 150);
            self.topView.alpha = alpha;
            
            [self.categaryView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.offset(1);
//                make.top.offset(headerHeight);
                make.left.right.offset(0);
                make.height.offset(45);
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














//轮播器赋值
- (void)setCycleImageArr:(NSArray *)cycleImageArr
{
    _cycleImageArr = cycleImageArr;
    //    NSLog(@"%@",cycleImageArr);
    
//    NSMutableArray *arrM = [NSMutableArray array];
//    self.cycleView.homeViewController = self.homeViewController;
//    for (int i = 0; i < cycleImageArr.count; i++) {
//        
//        UIImageView *cycleImgView = [[UIImageView alloc]init];
//        
//        HomeModel *model = self.cycleImageArr[i];
//        //        NSLog(@"1111111111%@",model.img);
//        NSURL *url = [NSURL URLWithString:model.img];
//        [cycleImgView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            
//            [arrM addObject:cycleImgView.image];
//            if (arrM.count == cycleImageArr.count) {
//                self.cycleView.imageArray = arrM;
//                self.cycleView.modelArray = self.cycleImageArr;
//            }
//        }];
//    }

}



@end
