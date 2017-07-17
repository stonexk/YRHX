//
//  BorrowerInfomationController.m
//  YRHXapp
//
//  Created by Apple on 2017/5/23.
//  Copyright © 2017年 zw. All rights reserved.
//

#import "BorrowerInfomationController.h"
#import "YRHXCycleView.h"
#import "Masonry.h"
#import "ScrollImage.h"
#import "oneViewController.h"


@interface BorrowerInfomationController ()<ScrollImageDelegate>

@property (weak, nonatomic) IBOutlet UILabel *borrowerPicTitle;   //借款人图片资料
@property(nonatomic,strong)UIView * headView;

@end

@implementation BorrowerInfomationController



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //YRHXCycleView
//    UIView * borrowerPic = [[UIView alloc] init];
//    borrowerPic.backgroundColor = [UIColor darkGrayColor];
//    [self.view addSubview:borrowerPic];
//    
//    [borrowerPic mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(15);
//        make.right.offset(-15);
//        make.top.equalTo(self.borrowerPicTitle.mas_bottom).offset(10);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-15);
//    }];
//
    
//CGRectMake(15, 295,KscreenWidth-30, 140 * KscreenWidth / 375)

    //轮播器
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(15, 295,KscreenWidth-30, 140 * KscreenWidth / 375)];
    [self.view addSubview:headView];

    NSArray *array1 = @[
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498194625358&di=4e0940e2a9e4b5585c239b4e2e370901&imgtype=0&src=http%3A%2F%2Fimg15.3lian.com%2F2015%2Ff2%2F101%2Fd%2F104.jpg",
                        
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498789469&di=948818da5cb3f42d2accedeb24089c7c&imgtype=jpg&er=1&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Ff703738da97739120371fe46f2198618367ae246.jpg",
                        
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498194965113&di=08788c25c8f38065ed034ac73aa9adb7&imgtype=0&src=http%3A%2F%2Fdimg02.c-ctrip.com%2Fimages%2Ftg%2F556%2F255%2F459%2F42058039ccac4d1d86425eaf620dd2cc_R_1024_10000.jpg",
                        
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498194810634&di=27631f537ec0b1ce92aa095bdad7563c&imgtype=0&src=http%3A%2F%2Fww1.sinaimg.cn%2Flarge%2F8f7947degw1eh2zzz1smzj20zk0nw45p.jpg",
                        
                        @"http://pic17.huitu.com/res/20140303/86378_20140303213126066200_1.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498195235790&di=87d54dfa9c47d0c7da8eae7912ac8e85&imgtype=0&src=http%3A%2F%2Fstaticfile.tujia.com%2Fupload%2FTravelArticleContent%2Fday_150917%2F201509170734112869.jpg"
                        ];
    
    ScrollImage *sll = [[ScrollImage alloc] initWithCurrentController:self
                                                             urlString:array1
                                                             viewFrame:CGRectMake(15, 295,KscreenWidth-30, 140 * KscreenWidth / 375)
                                                      placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    sll.delegate = self;
    sll.timeInterval = 2.0;
    [headView addSubview:sll.view];
    
    [sll.view mas_updateConstraints:^(MASConstraintMaker *make) {
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
@end
