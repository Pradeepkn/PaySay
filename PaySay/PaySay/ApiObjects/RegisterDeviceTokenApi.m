//
//  RegisterDeviceTokenApi.m
//  PaySay
//
//  Created by Pradeep Narendra on 7/7/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "RegisterDeviceTokenApi.h"
#import "AppConstants.h"

@implementation RegisterDeviceTokenApi

-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (NSString *)urlForAPIRequest{
    return [NSString stringWithFormat:@"%@/device/",[super baseURL]];
}

- (NSMutableDictionary *)requestParameters{
    return [NSMutableDictionary dictionaryWithObjects:@[self.registrationId,] forKeys:@[kRegistraionId]];
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
