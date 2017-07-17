//
//  YRHXIntegralCollectionController.m
//  YRHXapp
//
//  Created by Apple on 2017/6/1.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "YRHXIntegralCollectionController.h"
#import "YRHXIntegralCollectionCell.h"
#import "YRHXFlowLayout.h"
#import "ZFBMineOptionCell.h"
#import "NSArray+CZAddition.h"

@interface YRHXIntegralCollectionController ()

@property(nonatomic,weak)UICollectionViewFlowLayout *layout;

//@property(nonatomic,strong)NSMutableDictionary * numLabelCache;
@property (nonatomic, strong) NSArray *mineOptionsData;

@end

@implementation YRHXIntegralCollectionController

//static NSString * const reuseIdentifier = @"Cell";
static NSString *MineOptionCellID = @"Mine_Option_Cell_ID";



-(instancetype)init
{
    YRHXFlowLayout *layout = [[YRHXFlowLayout alloc]init];
 
    return [super initWithCollectionViewLayout:layout];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    UINib *optionCellNib = [UINib nibWithNibName:@"ZFBMineOptionCell" bundle:nil];
    [self.collectionView registerNib:optionCellNib forCellWithReuseIdentifier:MineOptionCellID];
    self.mineOptionsData = [self loadMineOptionsData];
    
    
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
   
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.mineOptionsData.count;
//      return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZFBMineOptionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MineOptionCellID forIndexPath:indexPath];
    
    cell.mineOption = self.mineOptionsData[indexPath.item];
    
    return cell;
    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//
//    return cell;
}

- (NSArray *)loadMineOptionsData {
    return [NSArray cz_objectListWithPlistName:@"MineOption.plist" clsName:@"ZFBMineOption"];
}

@end
