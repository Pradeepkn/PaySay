//
//  CreateMerchatPayCodeApi.m
//  PaySay
//
//  Created by Pradeep Narendra on 7/31/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "CreateMerchatPayCodeApi.h"
#import "AppConstants.h"

@implementation CreateMerchatPayCodeApi

-(instancetype)init{
    if(self = [super init]){
        self.basket = @{}.description;
    }
    return self;
}

- (NSString *)urlForAPIRequest{
    return [NSString stringWithFormat:@"%@/v2/u/merchant/pay/%@",[super baseURL], self.payCode];
}

- (NSMutableDictionary *)requestParameters{
//    return [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInteger:self.amount.integerValue], self.billNumber, self.email,[NSArray arrayWithObject:@{@"id": @1, @"count": @2 }], self.contact, [NSNumber numberWithBool:self.useRewards]] forKeys:@[kAmountKey, kBillNumberKey, kEmailKey, kBasketKey,kPhoneNumberKey, kUseRewardsKey]];
    return [NSMutableDictionary dictionaryWithObjects:@[[NSNumber numberWithInteger:self.amount.integerValue], self.email] forKeys:@[kAmountKey,  kEmailKey]];
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
