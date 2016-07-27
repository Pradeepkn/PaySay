//
//  ForgotPasswordApi.m
//  PaySay
//
//  Created by Pradeep Narendra on 7/28/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "ForgotPasswordApi.h"
#import "AppConstants.h"

@implementation ForgotPasswordApi

-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (NSString *)urlForAPIRequest{
    return [NSString stringWithFormat:@"%@/u/forgot?%@=%@",[super baseURL], kUsernameKey, self.userName];
}

- (NSMutableDictionary *)requestParameters{
    return [NSMutableDictionary dictionaryWithObjects:@[self.userName] forKeys:@[kUsernameKey]];
}

- (NSString *)requestType{
    return APIGet;//APIPost;
}

- (NSString *)apiAuthenticationAccessToken{
    return nil;
}

- (void)parseAPIResponse:(NSDictionary *)responseDictionary{
}

@end
