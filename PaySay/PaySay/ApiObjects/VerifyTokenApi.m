//
//  VerifyTokenApi.m
//  PaySay
//
//  Created by Pradeep Narendra on 7/7/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "VerifyTokenApi.h"
#import "ApiKeys.h"
#import "AppConstants.h"

@implementation VerifyTokenApi

-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (NSString *)urlForAPIRequest{
    return [NSString stringWithFormat:@"%@/o/token/",[super baseURL]];
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
    NSString *access_Token = responseDictionary[@"access_token"]?:@"";
    NSString *token_Type = responseDictionary[@"token_type"]?:@"";
    NSString *accessTokenKey = [NSString stringWithFormat:@"%@%@", token_Type, access_Token];
    [[NSUserDefaults standardUserDefaults] setObject:accessTokenKey forKey:@"AccessTokenKey"];
}

@end
