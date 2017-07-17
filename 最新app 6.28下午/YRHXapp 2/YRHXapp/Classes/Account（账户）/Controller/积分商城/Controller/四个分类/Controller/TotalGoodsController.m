//
//  TotalGoodsController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/12.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "TotalGoodsController.h"
#import "YRHXFlowLayout.h"
#import "NSArray+CZAddition.h"
#import "ZFBMineOptionCell.h"
#import "GoodsExchangeController.h"

@interface TotalGoodsController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    // 记录滚动的偏移量
    CGFloat contentOffsetY;
    CGFloat oldContentOffsetY;
    CGFloat newContentOffsetY;
}

@property (strong, nonatomic) UICollectionView * collectionView;
@property (nonatomic, strong) NSArray *mineOptionsData;

@end

static NSString *ID = @"cell";
@implementation TotalGoodsController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    YRHXFlowLayout * flowLayout = [[YRHXFlowLayout alloc] init];
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, KscreenWidth, KscreenHeight-132) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    UINib *optionCellNib = [UINib nibWithNibName:@"ZFBMineOptionCell" bundle:nil];
    [self.collectionView registerNib:optionCellNib forCellWithReuseIdentifier:ID];
    
    self.mineOptionsData = [self loadMineOptionsData];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}



//数据源方法==================================================
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize collectionViewSize = self.collectionView.bounds.size;
    CGFloat itemW = (collectionViewSize.width  - 10) *0.5;
    CGFloat itemH = itemW;
    return CGSizeMake(itemW,itemH);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mineOptionsData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    ZFBMineOptionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.mineOption = self.mineOptionsData[indexPath.item];
    
    return cell;
    
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



//加载Plist
- (NSArray *)loadMineOptionsData {
    return [NSArray cz_objectListWithPlistName:@"MineOption.plist" clsName:@"ZFBMineOption"];
}




@end
