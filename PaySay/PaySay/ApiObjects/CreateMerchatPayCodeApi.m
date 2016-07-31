//
//  CreateMerchatPayCodeApi.m
//  PaySay
//
//  Created by Pradeep Narendra on 7/31/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "CreateMerchatPayCodeApi.h"

@implementation CreateMerchatPayCodeApi

-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (NSString *)urlForAPIRequest{
    return [NSString stringWithFormat:@"%@/merchant/pay/%@",[super baseURL], self.payCode];
}

- (NSMutableDictionary *)requestParameters{
    return [NSMutableDictionary dictionaryWithObjects:@[] forKeys:@[]];
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
