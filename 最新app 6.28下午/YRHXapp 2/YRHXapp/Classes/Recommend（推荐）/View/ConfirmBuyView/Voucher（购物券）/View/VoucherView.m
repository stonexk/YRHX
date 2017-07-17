//
//  VoucherView.m
//  YRHXapp
//
//  Created by 詹稳 on 17/4/22.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "VoucherView.h"
#import "VoucherModel.h"
#import "Masonry.h"
#import "VoucherCell.h"
#import "VoucherFlowLayout.h"
#import "UIColor+ColorChange.h"

@interface VoucherView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

static NSString *ID = @"VoucherCellID";
@implementation VoucherView


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
    
    // 1.创建自定义流布局对象
     VoucherFlowLayout * flowLayout = [[VoucherFlowLayout alloc] init];
    // 2.创建collecitonView时一定要给它指定一个流布局对象
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:collectionView];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    // 3.给collectionView添加约束
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(160);
    }];
    
    // 4.设置数据源
    collectionView.dataSource = self;
    // 设置代理
    collectionView.delegate = self;
    
    // 5.加载数据
    
    
    // 6.用指定的class来注册cell
    [collectionView registerClass:[VoucherCell class] forCellWithReuseIdentifier:ID];
    
    
    self.collectionView = collectionView;
    
    // 7.添加分页指示器
    [self makePageControl];

    //添加优惠券文字 和张数的 view
    [self makeTop];
    
}

- (void)makeTop
{
    UILabel * youhuiLabel = [[UILabel alloc]init];
    youhuiLabel.text = @"优惠券";
    youhuiLabel.font = [UIFont systemFontOfSize:18.0];
    youhuiLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:youhuiLabel];
    
    [youhuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(17.5);
        make.width.offset(60);
    }];

    UILabel * countLabel = [[UILabel alloc]init];
    countLabel.text = @"6";
    countLabel.font = [UIFont systemFontOfSize:18.0];
    countLabel.textColor = [UIColor redColor];
    [self addSubview:countLabel];
    
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(youhuiLabel).offset(0);
        make.left.equalTo(youhuiLabel.mas_right).offset(8);
    }];
    
    UILabel * zhangLabel = [[UILabel alloc]init];
    zhangLabel.text = @"张";
    zhangLabel.font = [UIFont systemFontOfSize:18.0];
    zhangLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:zhangLabel];
    
    [zhangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(countLabel).offset(0);
        make.left.equalTo(countLabel.mas_right).offset(0);
    }];
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(17.5);
        make.right.offset(-17.5);
        make.top.equalTo(youhuiLabel.mas_bottom).offset(12);
        make.height.offset(1);
    }];
    
    
    
    
}






- (void)makePageControl {
 
    UIPageControl *pageControl = [[UIPageControl alloc] init];
#warning  不起作用。
    // 设置总页数
    pageControl.numberOfPages = 4;
//    pageControl.numberOfPages = (self.voucherData.count + 1) / 2;
    pageControl.currentPage = 0;
    // 设置当前页点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#1294f6"];
    // 设置其它而立的颜色
    pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#e2e2e2"];
    
    [self addSubview:pageControl];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.collectionView.mas_bottom).offset(-5);
    }];
    
    // 设置分页指示器能点击
    pageControl.enabled = YES;
    
    
    self.pageControl = pageControl;
}


// 只要在滚动都会调用此方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 只要新的一页出来过半就显示为下一页
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.499;
    self.pageControl.currentPage = page;
}



#pragma 数据源方法
// 返回每一组有多少个格子
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.voucherData.count;
//    return 6;
}

// 返回每一组的每一个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell
    VoucherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    // 2.传模型
    cell.voucherModel = self.voucherData[indexPath.item];
    
    // 3.返回cell
    return cell;
}




@end
