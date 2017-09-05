//
//  IAPHelper.m
//  iStarLive
//
//  Created by 李亚浩 on 2016/12/3.
//  Copyright © 2016年 lyh. All rights reserved.
//

#import "IAPHelper.h"
#import <StoreKit/StoreKit.h>
//#import "DataBaseManger.h"
//#import "ProductModel.h"
#import "WXApi.h"
#import "WXApiObject.h"

#define PRODUCT_ENTRANCE_TICKET @"2017_1000"
#define PRODUCT_IDENTIFIER_2   @"2017_1001"
#define PRODUCT_IDENTIFIER_5   @"2017_1002"
#define PRODUCT_IDENTIFIER_10  @"2017_1003"
#define PRODUCT_IDENTIFIER_50  @"2017_1004"
#define PRODUCT_IDENTIFIER_60  @"2017_1007"
#define PRODUCT_IDENTIFIER_72  @"2017_1006"

@interface IAPHelper ()<SKProductsRequestDelegate,SKPaymentTransactionObserver,NSURLConnectionDelegate>{
    NSMutableArray *_orderList;
    NSMutableArray *_historyOrder;//历史订单
}

@end

@implementation IAPHelper

+ (IAPHelper *)getInstance{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[IAPHelper alloc] init];
    });
    return instance;
}
- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        if (_productList == nil) {
            _orderList = [NSMutableArray array];
            _productList = [NSArray array];
//            _historyOrder = [NSMutableArray arrayWithArray:[[DataBaseManger manger] getAllOrder]] ;
            _productListAPI = [NSMutableArray array];
            
            
            [self requestApiProduct:nil];
            
            [self requestProduct];
            
        }
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}
//- (void)mamageHistoryOrder{
//    if (_historyOrder.count != 0) {
//        for (OrderInfo *order in _historyOrder) {
//            [self userPaySuccessWithOrder:order];
//        }
//    }
//}


- (void)requestProduct{
    //请求产品了列表
    _productIDs = [NSArray arrayWithObjects:
                    PRODUCT_ENTRANCE_TICKET,
                    PRODUCT_IDENTIFIER_2,
                    PRODUCT_IDENTIFIER_5,
                    PRODUCT_IDENTIFIER_10,
                    PRODUCT_IDENTIFIER_50,
                    PRODUCT_IDENTIFIER_60,
                    PRODUCT_IDENTIFIER_72,
                    nil];
    if ([SKPaymentQueue canMakePayments]) {
        NSSet *IDSet = [NSSet setWithArray:_productIDs];
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:IDSet];
        productsRequest.delegate = self;
        [productsRequest start];
    } else {
        [NoticeView showWithMsg:NSLocalizedString(@"请打开付费权限", nil)];
    }
    
}

//- (void)requestApiProduct:(RequestApiProductListFinsh)finishBlock{
//    [DataService POST:API_LIVE_APPMONEYLIST params:nil process:^(NSProgress *process) {
//        
//    } finishBlock:^(NSURLSessionDataTask *operation, id result) {
//        NSDictionary *resultDic = result;
//        int code = [resultDic safeIntForkey:@"status"];
//        if (code == API_SUCCESS){
//            NSArray *dataArray = resultDic[@"data"];
//            for (NSDictionary *dic in dataArray) {
//                ProductModel *model = [[ProductModel alloc] init];
//                [model setWithDic:dic];
//                [_productListAPI addObject:model];
//            }
//        }
//        if (finishBlock) {
//            finishBlock(code);
//        }
//    } FailuerBlock:^(NSURLSessionDataTask *operation, NSError *error) {
//        if (finishBlock) {
//            finishBlock((int)error.code);
//        }
//    }];
//
//}
//
//- (void)addOrderWithOrderObj:(OrderInfo *)order{
//    if (_productList.count == 0) {
//        [self requestProduct];
//    }
//    
//    [_orderList addObject:order];
//    [self requestForBuyProductWithOrder:order];
//}
//- (void)requestForBuyProductWithOrder:(OrderInfo *)order{
//    if (_productList.count == 0) {
//        [NoticeView showWithMsg:NSLocalizedString(@"商品列表为空", nil)];
//        return;
//    }
//    SKProduct *product = nil;
//    for (SKProduct *pro in _productList) {
//        if ([pro.productIdentifier isEqualToString:order.proId]) {
//            product = pro;
//            break;
//        }
//    }
//    if (product) {
//        SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
//        payment.applicationUsername = order.orderID;
//        [[SKPaymentQueue defaultQueue] addPayment:payment];
//    }
//}
//
//- (void)buyProductWithAppleProductId:(NSString *)productId andType:(TopUpType)type{
//    if (_productListAPI.count == 0) {
//        __weak __typeof(self)weakself = self;
//        [self requestApiProduct:^(int state) {
//            __strong __typeof(weakself)strongSelf = weakself;
//            for (ProductModel *product in _productListAPI) {
//                if ([product.proId isEqualToString:productId]) {
//                    [strongSelf addPayOrderWithProduct:product withType:type];
//                    break;
//                }
//            }
//        }];
//    } else {
//        for (ProductModel *product in _productListAPI) {
//            if ([product.proId isEqualToString:productId]) {
//                [self addPayOrderWithProduct:product withType:type];
//                break;
//            }
//        }
//    }
//}
//
//- (void)addPayOrderWithProduct:(ProductModel *)model withType:(NSInteger)type{
//    
//    //添加订单
//    [WaitiingView showWithNoUserAction];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:[LoginManager manager].userInfo.guid forKey:@"guid"];
//    [params setObject:[LoginManager manager].userInfo.uidStr forKey:@"uid_str"];
//    [params setObject:@"1" forKey:@"dev_type"];
//    [params setObject:@"2" forKey:@"app_type"];
//    [params setObject:@(type) forKey:@"pay_channel_type"]; //100 apple; 102 Weixin;  103 Alipay;
//    [params setObject:@(model.pid) forKey:@"p_id"];
//    [params setObject:@(model.ID) forKey:@"id"];
//    [params setObject:@"1" forKey:@"channel_id"];//1 小夜猫 2 秘密恋爱  3 一号约会
//    
//    [DataService GET:API_LIVE_APPPAYORDERADD params:params process:^(NSProgress *process) {
//    } finishBlock:^(NSURLSessionDataTask *operation, id result) {
//        
//        [WaitiingView hideWithUserAction];
//        NSDictionary *resultDic = result;
//        int code = [resultDic safeIntForkey:@"status"];
//        if (code == API_SUCCESS) {
//            
//            switch (type) {//100苹果支付
//                case 100:
//                {
//                    OrderInfo *obj = [[OrderInfo alloc] init];
//                    obj.uidStr = [LoginManager manager].userInfo.uidStr;
//                    obj.guid = [LoginManager manager].userInfo.guid;
//                    obj.orderID = [resultDic[@"data"] objectForKey:@"payOrderNo"];
//                    obj.proId   = model.proId;
//                    obj.pid     = (int)model.pid;
//                    obj.ID      = (int)model.ID;
//                    [self addOrderWithOrderObj:obj];
//                }
//                    break;
//                case 102://102微信支付
//                {
//                    PayReq* req        = [[PayReq alloc] init];
//                    req.partnerId      = [resultDic[@"WxOrder"] safeObjectForKey:@"mch_id"];
//                    req.prepayId       = [resultDic[@"WxOrder"] safeObjectForKey:@"prepay_id"];
//                    req.nonceStr       = [resultDic[@"WxOrder"] safeObjectForKey:@"nonce_str"];
//                    req.timeStamp      = (uint32_t)[resultDic[@"data"] safeIntegerForKey:@"timestamp"];
//                    req.package        = [resultDic[@"data"] objectForKey:@"packaage"];
//                    req.sign           = [resultDic[@"data"] objectForKey:@"sign"];
//                    [WXApi sendReq:req];//微信支付
//                }
//                    break;
//                default:
//                    break;
//            }
//            
//        } else {
//            [WaitiingView hideWithUserAction];
//            [NoticeView showWithMsg:[NSString stringWithFormat:@"%@%d",NSLocalizedString(@"添加订单失败", nil),code]];
//        }
//    } FailuerBlock:^(NSURLSessionDataTask *operation, NSError *error) {
//        [WaitiingView hideWithUserAction];
//    }];
//}
//
//#pragma mark -SKProductsRequestDelegate
//- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
//    
//    NSArray *myProducts = response.products;
//    if (response.products.count == 0) {
//        [NoticeView showWithMsg:NSLocalizedString(@"无法获取产品信息列表", nil)];
//    } else {
//        _productList = [myProducts sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//            SKProduct *pro1 = (SKProduct *)obj1;
//            SKProduct *pro2 = (SKProduct *)obj2;
//            return pro1.price.integerValue < pro2.price.integerValue ? NSOrderedAscending : NSOrderedDescending;
//        }];;
//    }
//}
//- (void)requestDidFinish:(SKRequest *)request{
//}
//- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
//}
//
//
//
//#pragma mark-SKPaymentTransactionObserver
//- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions
//{
//    
//    for (SKPaymentTransaction *transaction  in transactions) {
//        switch (transaction.transactionState) {
//            case SKPaymentTransactionStatePurchased: {
//                [WaitiingView hideWithUserAction];
////                [self test:transaction];
////                NSLog(@"购买完成,向自己的服务器验证 ---- %@", transaction.payment.applicationUsername);
//                NSData *data = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] appStoreReceiptURL] path]];
//                NSString *receipt = [data base64EncodedStringWithOptions:0];
//                //添加订单
//                OrderInfo *currentOrder = nil;
//                for (OrderInfo *order in _historyOrder) {
//                    if ([order.orderID isEqualToString:transaction.payment.applicationUsername]) {
//                        currentOrder = order;
//                        break;
//                    }
//                }
//                if (currentOrder == nil) {
//                    for (OrderInfo *order in _orderList) {
//                        if ([order.orderID isEqualToString:transaction.payment.applicationUsername]) {
//                            order.receipt = receipt;
//                            currentOrder = order;
//                            [_historyOrder addObject:order];
//                            [[DataBaseManger manger] addAnOrder:order];
//                            break;
//                        }
//                    }
//                }
//                [self userPaySuccessWithOrder:currentOrder];
//                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//            }
//                break;
//            case SKPaymentTransactionStateFailed: {
//                [WaitiingView hideWithUserAction];
//                NSLog(@"交易失败");
//                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//            }
//                break;
//            case SKPaymentTransactionStateRestored: {
//                [WaitiingView hideWithUserAction];
//                NSLog(@"已经购买过该商品");
//                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//            }
//                break;
//            case SKPaymentTransactionStatePurchasing: {
//                NSLog(@"商品添加进列表");
//            }
//                break;
//            default: {
//                [WaitiingView hideWithUserAction];
//                NSLog(@"这是什么情况啊？");
//            }
//                break;
//        }
//    }
//}
//
////- (void)test:(SKPaymentTransaction *)transaction{
////    
////    NSData *receipt =  [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] appStoreReceiptURL] path]];; // Sent to the server by the device
////    
////    // Create the JSON object that describes the request
////    NSError *error;
////    NSDictionary *requestContents = @{
////                                      @"receipt-data": [receipt base64EncodedStringWithOptions:0]
////                                      };
////    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents
////                                                          options:0
////                                                            error:&error];
////    
////    if (!requestData) { /* ... Handle error ... */ }
////    
////    // Create a POST request with the receipt data.
////    NSURL *storeURL = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
////    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
////    [storeRequest setHTTPMethod:@"POST"];
////    [storeRequest setHTTPBody:requestData];
////    
////    // Make a connection to the iTunes Store on a background queue.
////    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
////    [NSURLConnection sendAsynchronousRequest:storeRequest queue:queue
////                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
////                               if (connectionError) {
////                                   /* ... Handle error ... */
////                               } else {
////                                   NSError *error;
////                                   NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
////                                   if (!jsonResponse) { /* ... Handle error ...*/ }
////                                   /* ... Send a response back to the device ... */
////                               }
////                               }];
////}
//
//- (void)userPaySuccessWithOrder:(OrderInfo *)order{
//    if (order == nil) {
//        return;
//    }
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:order.guid forKey:@"guid"];
//    [params setObject:order.uidStr forKey:@"uid_str"];
//    [params setObject:@"1" forKey:@"dev_type"];
//    [params setObject:@"3" forKey:@"app_type"];
//    [params setObject:@"100" forKey:@"pay_channel_type"];
//    [params setObject:order.orderID forKey:@"pay_order"];
//    [params setObject:order.receipt forKey:@"pay_result"];
//    [params setObject:@(order.pid) forKey:@"p_id"];
//    [params setObject:@(order.ID) forKey:@"id"];
//    [params setObject:@"1" forKey:@"channel_id"];//1 小夜猫 2 秘密恋爱  3 一号约会
//    
//    [DataService POST:API_LIVE_APPPAYORDERSUCCESS params:params process:^(NSProgress *process) {
//        
//    } finishBlock:^(NSURLSessionDataTask *operation, id result) {
//        NSDictionary *resultDic = result;
//        int code = [resultDic safeIntForkey:@"status"];
//        switch (code) {
//            case API_SUCCESS:{
//                if ([[LoginManager manager].userInfo.uidStr isEqualToString:[resultDic[@"data"] objectForKey:@"uidStr"]]) {
//                    [LoginManager manager].userInfo.userMoneys = [[resultDic[@"data"] objectForKey:@"userMoneys"] intValue];
//                    if ([order.proId isEqualToString:PRODUCT_ENTRANCE_TICKET]) {
//                        [LoginManager manager].userInfo.joinFlag = 1;
//                        [MobClick event:@"entranceApplePay"];
//                        [MobClick event:[NSString stringWithFormat:@"%dapple",order.pid]];
//                        
//                    }
//                    [[NSNotificationCenter defaultCenter] postNotificationName:USER_TOPUP_SUCCESS object:order.proId];
//                }
//                [_historyOrder removeObject:order];
//                [[DataBaseManger manger] deleateAnOrder:order.orderID];
//            }
//            case API_ORDER_RESULT_HASFINISH:{
//                [[DataBaseManger manger] deleateAnOrder:order.orderID];
//            }
//                break;
//            default:{
//                [NoticeView showWithMsg:[NSString stringWithFormat:@"%@%d",NSLocalizedString(@"充值失败", nil),code]];
//            }
//                break;
//        }
//    } FailuerBlock:^(NSURLSessionDataTask *operation, NSError *error) {
//        
//    }];
//    
//}
//
//
//

@end


