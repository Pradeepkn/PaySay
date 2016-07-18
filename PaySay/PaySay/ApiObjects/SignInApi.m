//
//  SignInApi.m
//  PaySay
//
//  Created by Pradeep Narendra on 6/28/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "SignInApi.h"
#import "ApiKeys.h"
#import "AppConstants.h"

@implementation SignInApi

-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (NSString *)urlForAPIRequest{
    return [NSString stringWithFormat:@"%@/o/token",[super baseURL]];
}

- (NSMutableDictionary *)requestParameters{
    return [NSMutableDictionary dictionaryWithObjects:@[self.username,self.password, CLIENT_KEY, CLIENT_SECRET,kPasswordKey] forKeys:@[kUsernameKey,kPasswordKey,kClientIdKey,kClientSecretKey,kGrantTypeKey]];
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
