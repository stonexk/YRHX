//
//  YRHXCollectionModel.h
//  YRHXapp
//
//  Created by Apple on 2017/6/1.
//  Copyright © 2017年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRHXCollectionModel : NSObject

//
////图片
//@property(nonatomic,copy)NSString *img;
////名字
//@property(nonatomic,copy)NSString *name;
////重量
//@property(nonatomic,copy)NSString *specifics;
////合伙人价格
//@property(nonatomic,copy)NSString *partner_price;
////市场价格
//@property(nonatomic,copy)NSString *market_price;
////买一赠一
//@property(nonatomic,copy)NSString *pm_desc;
////所点商品个数
//@property(nonatomic,copy)NSString *count;
////减号重用属性
//@property(nonatomic,assign)BOOL isShow;
////产品ID
//@property(nonatomic,copy)NSString *product_id;
//
//@property(nonatomic,copy)NSString *store_nums;




+(instancetype)yrhxCollectionModelWithDic:(NSDictionary *)dic;


@end
