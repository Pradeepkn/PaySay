//
//  RehargePaymentApi.h
//  PaySay
//
//  Created by Pradeep Narendra on 8/19/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import <TTPLAPIManager/TTPLAPIManager.h>

@interface RechargePaymentApi : APIBase

@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *service;
@property (nonatomic, strong) NSString *rechargeNumber;
@property (nonatomic, strong) NSString *operatorCode;
@property (nonatomic, strong) NSNumber *useRewards;

@end
