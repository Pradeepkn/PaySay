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
    if ([self isAllDigits]) {
        return [NSString stringWithFormat:@"%@/v2/u/forgot/?%@=%@",[super baseURL], kPhoneNumberKey, self.userName];
    }
    return [NSString stringWithFormat:@"%@/v2/u/forgot/?%@=%@",[super baseURL], kEmailKey, self.userName];
}

- (BOOL) isAllDigits
{
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [self.userName rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound && self.userName.length > 0;
}

- (NSMutableDictionary *)requestParameters{
    return nil;//[NSMutableDictionary dictionaryWithObjects:@[self.userName] forKeys:@[kUsernameKey]];
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
