//
//  IAPHelper.h
//  iStarLive
//
//  Created by 李亚浩 on 2016/12/3.
//  Copyright © 2016年 lyh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OrderInfo.h"

typedef void(^RequestApiProductListFinsh)(int state);

typedef NS_ENUM(NSInteger,TopUpType){
    TopUpTypeApple = 100,//苹果内购
    TopUpTypeWeChat = 102,//微信充值
    TopUpTypeAli = 103//支付宝充值
};



@interface IAPHelper : NSObject
//内购

@property (nonatomic,strong,readonly) NSArray *productList;//苹果的产品列表
@property (nonatomic,strong,readonly) NSArray *productIDs;//苹果的产品ID

@property (nonatomic,strong,readonly) NSMutableArray *productListAPI;//后台的产品列表


+ (IAPHelper *)getInstance;

- (void)mamageHistoryOrder;//检测是否有没处理完的订单，处理历史订单
//- (void)requestForBuyProductWithProductIndex:(NSInteger)index;


- (void)addOrderWithOrderObj:(OrderInfo *)order;//添加订单

- (void)requestProduct;

- (void)requestApiProduct:(RequestApiProductListFinsh)finshBlock;



- (void)buyProductWithAppleProductId:(NSString *)productId andType:(TopUpType)type;

@end


