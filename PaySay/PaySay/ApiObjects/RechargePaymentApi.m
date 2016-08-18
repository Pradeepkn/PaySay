//
//  RehargePaymentApi.m
//  PaySay
//
//  Created by Pradeep Narendra on 8/19/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "RechargePaymentApi.h"
#import "AppConstants.h"

@implementation RechargePaymentApi

-(instancetype)init{
    if(self = [super init]){
    }
    return self;
}

- (NSString *)urlForAPIRequest{
    return [NSString stringWithFormat:@"%@/v2/merchant/pay/rocketinpocket/",[super baseURL]];
}

- (NSMutableDictionary *)requestParameters{
    return [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithDouble:self.amount.doubleValue], self.email, self.service, self.rechargeNumber, self.operatorCode] forKeys:@[kAmountKey, kEmailKey,kService, kRechargeNumber, kOperatorCode]];
}

- (NSString *)requestType{
    return APIPost;
}

- (NSString *)apiAuthenticationAccessToken{
    return nil;
}

- (void)parseAPIResponse:(NSDictionary *)responseDictionary{
    
}

@end
