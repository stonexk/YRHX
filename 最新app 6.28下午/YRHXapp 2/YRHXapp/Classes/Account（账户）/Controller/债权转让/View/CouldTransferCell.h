//
//  CouldTransferCell.h
//  YRHXapp
//
//  Created by Apple on 2017/6/5.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CouldTransferCell;

@protocol CouldTransferCellDelegate <NSObject>

- (void)CouldTransferCellWith:(CouldTransferCell*)couldTransferCell andbutton:(UIButton*)button;

@end
@interface CouldTransferCell : UITableViewCell

@property (nonatomic,strong) id<CouldTransferCellDelegate> delegate;


@end
