//
//  HGHIAPManager.m
//  haiwaiSDK
//
//  Created by Lucas on 2019/4/2.
//  Copyright © 2019 Lucas. All rights reserved.
//

#import "HGHIAPManager.h"
#import <StoreKit/StoreKit.h>
#import "HGHHttprequest.h"
#import "HGHSDKConfig.h"
#import "HGHTools.h"
#import "ProgressHUD.h"
#import "HGHFunctionHttp.h"
#import "HGHAlertview.h"
#import "Tracking.h"
@implementation HGHIAPManager

+(instancetype)shareinstance
{
    static HGHIAPManager *iap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iap = [[HGHIAPManager alloc]init];
    });
    return iap;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
    }
    self.isPaying=NO;
    return self;
}

-(NSMutableArray *)resendOrderinfo
{
    if (!_resendOrderinfo) {
        _resendOrderinfo = [[NSMutableArray alloc]init];
    }
    return _resendOrderinfo;
}

-(void)requestIAPWithOrderInfo:(HGHOrderInfo *)orderinfo andOrderID:(NSString *)orderID
{
    
    if (self.isPaying==YES) {
        return;
    }
    self.isPaying=YES;
    [ProgressHUD show];
    NSString *productId = orderinfo.productID;
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"pandasUserID"];
    
    self.orderInfo = @{@"user_id":userID,
                       @"server_id":orderinfo.serverID,
                       @"app_id":[HGHSDKConfig currentAppID],
                       @"product_id":orderinfo.productID,
                       @"amount":orderinfo.money,
                       @"trade_no":orderinfo.cpOrderID,
                       @"subject":orderinfo.productName,
                       @"orderID":orderID
                       };
    
    if (productId.length > 0) {
        NSArray *array = @[productId];
        NSLog(@"array=%@",array);
//        [self getApplePayWithproductIDS:array];
//        [self getButtonRestore:array];
        [self getApplePayWithproductIDS:array];
        
        //发起请求
    } else {
        NSLog(@"商品ID为空");
    }
}


-(void)getApplePayWithproductIDS:(NSArray *)array
{
    if ( [SKPaymentQueue canMakePayments]) {
        //*****************************************
        NSArray *trans = [SKPaymentQueue defaultQueue].transactions;
        if (trans.count) {
            NSLog(@"trans.count=%lu",(unsigned long)trans.count);
            //                SKPaymentTransaction* transaction = [trans firstObject];
            for (SKPaymentTransaction *transaction in trans) {
                NSLog(@"state=%ld",(long)transaction.transactionState);
                if (transaction.transactionState == SKPaymentTransactionStatePurchased) {
                    NSLog(@"未完成的订单");
                    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                    return;
                }
            }
            
        }
        
        [ProgressHUD show];
        //*****************************************
        NSSet *set = [NSSet setWithArray:array];
        SKProductsRequest * appStoreRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        appStoreRequest.delegate = self;
        [appStoreRequest start];
        NSLog(@"允许应用内支付,请求的productID: %@",set);
    }else{
        NSLog(@"不允许应用内支付");
    }
}


#pragma mark -SKProductsRequestDelegate 获取appstroe产品信息
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    
    NSArray *gameProduct = response.products;
    if (gameProduct.count == 0) {
        NSLog(@"无法获取产品信息,购买失败");
        [ProgressHUD dismiss];
        self.isPaying=NO;
        return;
    }
    
    for (SKProduct *product in gameProduct) {
        NSLog(@"产品标题 %@ ", product.localizedTitle);
        NSLog(@"产品描述信息: %@ ", product.localizedDescription);
        NSLog(@"价格: %@" , product.price);
        NSLog(@"Product id: %@ ", product.productIdentifier);
        
        SKMutablePayment *Mpayment = [SKMutablePayment paymentWithProduct:product];
        int price = [product.price intValue];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",price] forKey:@"IAPMoney"];
        
        
        [[SKPaymentQueue defaultQueue] addPayment:Mpayment];  //请求已经生效
        //           [hud  hide:YES afterDelay:2.0];
        //        }
    }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSString *out_trans = transaction.transactionIdentifier;
    NSString * productIdentifier = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    NSData * transactionReceiptdata = [productIdentifier dataUsingEncoding:NSUTF8StringEncoding] ;
    
    NSString*transactionReceiptString=[transactionReceiptdata base64EncodedStringWithOptions:0];
    if ([transactionReceiptString length] > 0) {
        
        NSLog(@"凭证打印%@",transactionReceiptString);
        
        
        [self sendReceipt:transactionReceiptString andtransxxx:out_trans];
        
        
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
}

#pragma mark --这里验证票据
-(void)sendReceipt:(NSString*)receipt andtransxxx:(NSString *)out_trade_no
{
    
    //热云上报
    
    
    NSMutableDictionary *mutableDic =[[NSMutableDictionary alloc]initWithDictionary:self.orderInfo];
    [mutableDic setObject:receipt forKey:@"transaction"];
    [mutableDic setObject:out_trade_no forKey:@"platformOrderID"];
    
//    NSDictionary *dict = @{@"cpOrderID":receipt[@"sdkorderID"],
//                           @"transactionReceipt":receipt[@"transaction"],
//                           @"platformOrderID":receipt[@"platformOrderID"],
//                           @"money":receipt[@"money"]
    
    NSString *money = [NSString stringWithFormat:@"%@",self.orderInfo[@"money"]];
    NSString *orderID = self.orderInfo[@"orderID"];
    [mutableDic setObject:orderID forKey:@"sdkorderID"];
    [mutableDic setObject:money forKey:@"money"];
    
    
//    [Tracking setRyzf:orderID ryzfType:@"apple" hbType:@"CNY" hbAmount:[money floatValue]];
    
    [HGHFunctionHttp HGHSendRecieptWithReceiptInfo:mutableDic ifSuccess:^(id  _Nonnull response) {
        if ([response[@"ret"] integerValue]==0) {
            NSLog(@"response=%@",response);
            NSLog(@"发送票据成功");
        }else
        {
            [self.resendOrderinfo addObject:mutableDic];
            if (self.timer==nil) {
            [self createTimer];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [self.resendOrderinfo addObject:mutableDic];
        if (self.timer==nil) {
            [self createTimer];
        }
    }];
////    [HGHFlyer FlyersReportEvent:@"af_purchase" params:@{@"af_revenue":[NSString stringWithFormat:@"%lf",money],@"number":@"1"}];
//    [[HGHHttprequest shareinstance]sendReceptWithOrderInfo:mutableDic ifSuccess:^(id  _Nonnull response) {
//        NSLog(@"response=%@",response);
//        if ([response[@"code"] intValue] ==20000) {
//            NSLog(@"发送成功");
//        }else
//        {
//            [self.resendOrderinfo addObject:mutableDic];
//            if (self.timer==nil) {
//                [self createTimer];
//            }
//        }
//    } failure:^(NSError * _Nonnull error) {
//        NSLog(@"error=%@",error);
//        [self.resendOrderinfo addObject:mutableDic];
//        if (self.timer==nil) {
//            [self createTimer];
//        }
//    }];

    
}

-(void)createTimer
{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:9 target:self selector:@selector(resendRecipt) userInfo:nil repeats:YES];
    
    
}

-(void)resendRecipt
{
    NSLog(@"timer----------->");
    if (self.resendOrderinfo.count!=0) {
        [self verifyReceiptFromCompanyServerWhenLogin:self.resendOrderinfo[0]];
    }else
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}




// 交易失败,通知IAP进行UI刷新
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    if(transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"购买失败");
    } else {
        NSLog(@"支付请求取消");
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"UserCancel",@"result", nil];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}



#pragma mark - 购买商品
//- (void)buyProduct:(SKProduct *)product
//{
//    // 1.创建票据
//    SKPayment *payment = [SKPayment paymentWithProduct:product];
//
//    // 2.将票据加入到交易队列中
//    [[SKPaymentQueue defaultQueue] addPayment:payment];
//
//}

#pragma mark-SKPayment TransactionObserver支付结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    NSLog(@"购买结果");
//    NSLog(@"transactions=%@",transactions);
    for (SKPaymentTransaction *transaction in transactions) {
        NSLog(@"transaction=%@",transaction);
//        [self restoreTransaction:transaction];
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased: //交易完成
                [ProgressHUD dismiss];
                NSLog(@"交易完成transactionIdentifier= %@", transaction.transactionIdentifier);
                self.isPaying=NO;
                [self completeTransaction:transaction];
//                [self restoreTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                [ProgressHUD dismiss];
                NSLog(@"交易失败");
                self.isPaying=NO;
                [self failedTransaction:transaction];
//                [self restoreTransaction:transaction];
                NSLog(@"交易失败");
                break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                NSLog(@"已经购买的商品");
                [ProgressHUD dismiss];
                self.isPaying=NO;
                [self restoreTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing: //商品添加进列表
                NSLog(@"添加到商品列表");
                [ProgressHUD dismiss];
//                [self restoreTransaction:transaction];
                break;

            default:
                break;
        }
    }
}





- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    [ProgressHUD dismiss];
    self.isPaying=NO;
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    [ProgressHUD dismiss];
    self.isPaying=NO;
}

-(void)restoreTransaction: (SKPaymentTransaction *)transaction
{
    // 对于已经购买的产品,恢复其处理逻辑
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}



- (NSString *)getHttpSing:(NSMutableDictionary *)dic
{
    NSString *str = nil;
    NSMutableArray *parameters_array = [NSMutableArray arrayWithArray:[dic allKeys]];
    [parameters_array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
        //return [obj2 compare:obj1];//降序
    } ];
    for (int i = 0; i<parameters_array.count; i++) {
        NSString *key = [parameters_array objectAtIndex: i];
        NSString * value = [dic objectForKey:key];
        value = [self encodeString:value];
        if (i==0) {
            
            str = [NSString stringWithFormat:@"%@=%@",key,value] ;
            
        }else{
            
            str = [NSString stringWithFormat:@"%@&%@=%@",str,key,value];
        }
        
    }
    
    return str;
}

-(NSString*)encodeString:(NSString*)unencodedString{
    
    NSString *encodedString=nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 9.0f) {
        
        encodedString = (NSString *)
        CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (CFStringRef)unencodedString,
                                                                  NULL,
                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                  kCFStringEncodingUTF8));
    }
    
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"%20" withString:@"+"];
    return encodedString;
}



// 登录时二次验证
+ (void)verifyReceiptFromCompanyServerWhenAccident
{
    
}

// 断网漏单时二次验证
- (void)verifyReceiptFromCompanyServerWhenLogin:(NSMutableDictionary *)orderInfoDic
{
    [HGHFunctionHttp HGHSendRecieptWithReceiptInfo:orderInfoDic ifSuccess:^(id  _Nonnull response) {
        if ([response[@"ret"] integerValue]==0) {
            NSLog(@"二次 发送票据成功");
            [self.resendOrderinfo removeObjectAtIndex:0];
        }else
            {
            [self.resendOrderinfo addObject:orderInfoDic];
            if (self.timer==nil) {
                [self createTimer];
            }
            }
    } failure:^(NSError * _Nonnull error) {
        [self.resendOrderinfo addObject:orderInfoDic];
        if (self.timer==nil) {
            [self createTimer];
        }
    }];
    
    
}

@end
