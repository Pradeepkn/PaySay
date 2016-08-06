//
//  OperatorsApi.m
//  PaySay
//
//  Created by Pradeep Narendra on 8/6/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import "OperatorsApi.h"
#import "AppConstants.h"
#import "Operators.h"

@implementation OperatorsApi

-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (NSString *)urlForAPIRequest{
    return [NSString stringWithFormat:@"%@/v2/utility/operators/?filter=1",[super baseURL]];
}

- (NSMutableDictionary *)requestParameters{
    return nil;
}

- (NSString *)requestType{
    return APIGet;//APIPost;
}

- (NSString *)apiAuthenticationAccessToken{
    return nil;
}

- (void)parseAPIResponse:(NSDictionary *)responseDictionary{
    self.operatorsObjects = [[NSMutableArray alloc] init];
    NSArray *operatorsArray = responseDictionary[@"Root"];
    for (NSDictionary *operatorEntryObject in operatorsArray) {
        Operators *operatorObject = [[Operators alloc] init];
        operatorObject.operatorCode = [NSString stringWithFormat:@"%@",operatorEntryObject[@"operator_code"]];
        operatorObject.operatorName = [NSString stringWithFormat:@"%@",operatorEntryObject[@"operator_name"]];
        [self.operatorsObjects addObject:operatorObject];
    }
}


@end
