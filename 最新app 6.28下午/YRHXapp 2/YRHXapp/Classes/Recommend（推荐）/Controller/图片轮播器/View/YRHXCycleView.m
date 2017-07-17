//
//  YRHXCycleView.m
//  YRHXapp
//
//  Created by Apple on 2017/5/17.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXCycleView.h"
#import "YRHXCycleViewCell.h"
#import "YRHXCycleFlowLayout.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
// 图片个数
#define ImageCount  2

// 组数
#define sectionCount 10
static NSString *cycleCellID = @"cycleCellID";

@interface YRHXCycleView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;

@end
@implementation YRHXCycleView

// 当一个控件准备销毁时,它会先从它的父控件身移除
- (void)removeFromSuperview {
    [super removeFromSuperview];
    // 定时器废掉之后再也走了,只能重新创建新的
    [self.timer invalidate];
}

- (void)dealloc {
    NSLog(@"图片轮播器view要走了");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    
    // 2.处理collectionView相关
    [self settingCollectionView];
    
    // 3.添加分页指示器
    [self settingPageControl];
    
    // 4.添加定时器
    [self addTimer];
}

#pragma mark - 添加分页指示器
- (void)settingPageControl {
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:0.5];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:pageControl];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(0);
    }];
    
    // 不让小点可以点
    pageControl.enabled = NO;
    self.pageControl = pageControl;
}

#pragma mark - 处理collecitonView相关
- (void)settingCollectionView {
    // 1.创建自定义布局对象
    YRHXCycleFlowLayout *flowLayout = [[YRHXCycleFlowLayout alloc] init];
    // 2.collecdtionView在创建时要给它传一个布局对象
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    [self addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(0);
    }];
    
    // 如果给colletionView加了约束之后滚动出现问题让它约束立即去计算frame
    [self layoutIfNeeded];
    
    // 3.设置数据源
    collectionView.dataSource = self;
    // 4.设置代理
    collectionView.delegate = self;
    
    
    // 5.注册广告图片cell
    [collectionView registerClass:[YRHXCycleViewCell class] forCellWithReuseIdentifier:cycleCellID];
    
    
    
    self.collectionView = collectionView;
}

#pragma mark - 添加定时器
- (void)addTimer {
    /** 下面这两行代码和 用scheduled开头的方法创建出来的定时器是同价
     NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
     
     //    [timer fire];
     [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
     
     */
    
    
    // 第一个:定时器间隔时间 秒
    // 第二个:给谁添加一个定时器
    // 第三个:每几秒target对象要调用的方法
    // 第四个:额外信息
    // 第五个:是否重复执行
    //    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    //
    //    // 更改定时器的运行模式为通用模式,就可以达到和更新UI同级
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
    
    // 此方法创建的定时器默认不会启动"因为它没有加入到运行循环"
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    // 把定时器添加到运行循环并指定运行模式,它就可以自动开始
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timer = timer;
    
}

// 定时器的方法每2秒调用一次此方法
- (void)nextPage {
    // 1.获取当前在第几页
    NSInteger page = self.pageControl.currentPage;
    
    NSIndexPath *scrollToPath = nil;
    
    // 2.如果滚动到最后一页了怎么办????
    // 继续向下一组的第0组cell滚动
    if (page == self.imageArray.count - 1) {
        scrollToPath = [NSIndexPath indexPathForItem:0 inSection:sectionCount / 2 + 1];
    } else {  // 3.不是最后一页就继续向下一页滚动
        scrollToPath = [NSIndexPath indexPathForItem:page + 1 inSection:sectionCount / 2];
    }
    
    
    [self.collectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}



#pragma mark - scrollView相关的代理方法
// 将要开始拖拽时把定时器先不走了
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 让定时器在遥远的4001年时再开始执行
    self.timer.fireDate = [NSDate distantFuture];
    
}

// 松开手之后再让停时器开始走
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 让定时器2秒之后继续执行
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2.0];
}

// 动画的方法去滚动,滚动完全停下来之后会调用一次此方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 只要它不在中间这一组就让它回到中间这一组,回到中间这一组的第几个cell???
    // 1.计算当前cell在collectionView中它是第几个格子
    NSInteger cellNum = scrollView.contentOffset.x / scrollView.bounds.size.width;
    // 2.计算当前cell是第几组的
    NSInteger section = cellNum / self.imageArray.count;
    
    // 3.计算当前cell的item
    NSInteger item = cellNum % self.imageArray.count;
    
    // 4.如果是中间这一组,什么也不做
    if (section == sectionCount / 2) {
        return;
    }
    
    // 5.创建索引
    NSIndexPath *scrollToPath = [NSIndexPath indexPathForItem:item inSection:sectionCount / 2];
    
    // 6.滚动到指定
    [self.collectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
}


// 手动拖拽滚动时,它完会停下来之后会调用一次此方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 只要它不在中间这一组就让它回到中间这一组,回到中间这一组的第几个cell???
    // 1.计算当前cell在collectionView中它是第几个格子
    NSInteger cellNum = scrollView.contentOffset.x / scrollView.bounds.size.width;
    // 2.计算当前cell是第几组的
    NSInteger section = cellNum / self.imageArray.count;
    
    // 3.计算当前cell的item
    NSInteger item = cellNum % self.imageArray.count;
    
    // 4.如果是中间这一组,什么也不做
    if (section == sectionCount / 2) {
        return;
    }
    
    // 5.创建索引
    NSIndexPath *scrollToPath = [NSIndexPath indexPathForItem:item inSection:sectionCount / 2];
    
    // 6.滚动到指定
    [self.collectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    
    
}

// 只要滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger cellNum = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.499;
    
    // 计算第几页
    NSInteger page = cellNum % self.imageArray.count;
    
    self.pageControl.currentPage = page;
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return sectionCount;
}

// 返回每一组有多少个格子
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 有多少个格子取决图片的个数
    NSLog(@"我有%zd个格子", self.imageArray.count);
    return self.imageArray.count;
}

// 返回每一组的每一格子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell
    YRHXCycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cycleCellID forIndexPath:indexPath];
    // 2.传数据
    cell.imageData = self.imageArray[indexPath.item];
    
//#warning  多写的
//    cell.model = self.modelArray[indexPath.item];
    // 3.返回cell
    return cell;

}

//
//#warning  多写的方法
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    AXFCycleCell *cell = (AXFCycleCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.delegate = self.homeViewController;
//    
//    if ([cell.delegate respondsToSelector:@selector(axfCycleCellWithModel:)])
//    {
//        [cell.delegate  axfCycleCellWithModel:cell];
//    }
//    
//    
//}
//
//




// 重写set方法接收数据
- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    
    
    // 有数据之后再设置总页数
    self.pageControl.numberOfPages = imageArray.count;
  
    
    // 6.创建索引
    NSIndexPath *scrollToPath = [NSIndexPath indexPathForItem:0 inSection:sectionCount / 2];
    // 7.默认就滚动到中间这组的第0个cell上面
    [self.collectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
}




@end
