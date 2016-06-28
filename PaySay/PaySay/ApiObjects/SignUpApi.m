//
//  SignUpApi.m
//  PaySay
//
//  Created by Pradeep Narendra on 6/28/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "SignUpApi.h"
#import "ApiKeys.h"
#import "AppConstants.h"

@implementation SignUpApi

-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (NSString *)urlForAPIRequest{
    return [NSString stringWithFormat:@"%@u/register/",[super baseURL]];
}

- (NSMutableDictionary *)requestParameters{
    return [NSMutableDictionary dictionaryWithObjects:@[self.phoneNumber, self.email, self.username,self.password] forKeys:@[kPhoneNumberKey,kEmailKey,kNameKey,kPasswordKey]];
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
