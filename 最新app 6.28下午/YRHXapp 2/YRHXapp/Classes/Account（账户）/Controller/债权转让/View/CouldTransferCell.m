//
//  CouldTransferCell.m
//  YRHXapp
//
//  Created by Apple on 2017/6/5.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "CouldTransferCell.h"
#import "IssueCreditorTransferController.h"
#import "UIColor+ColorChange.h"

@interface CouldTransferCell ()

@property (weak, nonatomic) IBOutlet UIButton *transferBtn;

@end
@implementation CouldTransferCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

//选中按钮颜色不变
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [_transferBtn setBackgroundColor:[UIColor colorWithHexString:@"#eb413d"]];
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    [_transferBtn setBackgroundColor:[UIColor colorWithHexString:@"#eb413d"]];
}


- (IBAction)transferBtnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(CouldTransferCellWith:andbutton:)]) {
        
        [self.delegate CouldTransferCellWith:self andbutton:sender];
    }
}




@end
