//
//  APIBase.m
//
//
//  Created by Subramanian on 11/10/14.
//  Copyright (c) 2014 Tarento Technologies Pvt Ltd. All rights reserved.
//

#import "APIBase.h"
#import "ApiKeys.h"

#define CLIENT_KEY @"CRDNwxmwHj688CuVjLEcq7ZudupVUIbke2Jflda7"
#define CLIENT_SECRET @"rbkopL6SLTPbmoEAViDglnwPQdVv4aC62UC6vxC16PiA4HIT5wY9nfgttRSiZgVEOZY7zfxfUk1tLNATq3i9Itbmuwb7sHK8gBC5epLxNqCIju6zYE6eS4MEFAbCZGjc"

@interface APIBase (Private)
@property(readwrite, nonatomic, strong)
NSMutableDictionary *parametersDictionary;
@property(readwrite, nonatomic, strong) NSString *requestType;
@end

@implementation APIBase

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (NSString *)baseURL {
    return (ShouldUseProductionUrl) ? APIProductionUrl : APIStaginUrl;
}

- (NSString *)urlForAPIRequest {
    return @"";
}

- (NSString *)localFileName {
    return @"";
}

- (NSString *)apiAuthenticationUsername {
    return @"";
}

- (NSString *)apiAuthenticationPassword {
    return @"";
}

- (NSString *)requestType {
    // Default Request Type
    return APIGet;
}

- (NSDictionary *)requestParameters {
    return nil;
}

- (NSDictionary *)customHTTPHeaders {
    // Give the auth_token, sessionId,  or any other parameters we should pass it in custom header..
    NSString *tokenKey;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AccessTokenKey"]) {
        tokenKey = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"AccessTokenKey"]];
    }

    if (tokenKey.length) {
        NSDictionary *dictionay = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"Bearer %@", tokenKey], @"Authorization",@"iOS",@"x-cheripo-device-os",[self getUniqueDeviceIdentifierAsString],@"x-cheripo-device-id",@"1" , @"x-cheripo-package-version",CLIENT_KEY,@"x-cheripo-client-id",[UIDevice currentDevice].model ,@"x-cheripo-device-hardware",@"Apple",@"x-cheripo-device-manufacturer",[UIDevice currentDevice].systemVersion,@"x-cheripo-device-version",nil];
        return dictionay;
    }else{
        NSDictionary *dictionay = [NSDictionary dictionaryWithObjectsAndKeys:@"iOS",@"x-cheripo-device-os",[self getUniqueDeviceIdentifierAsString],@"x-cheripo-device-id",@"1" , @"x-cheripo-package-version",CLIENT_KEY,@"x-cheripo-client-id",[UIDevice currentDevice].model ,@"x-cheripo-device-hardware",@"Apple",@"x-cheripo-device-manufacturer",[UIDevice currentDevice].systemVersion,@"x-cheripo-device-version",nil];
        return dictionay;
    }
    return nil;
}

-(NSString *)getUniqueDeviceIdentifierAsString
{
    NSString *strApplicationUUID  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return strApplicationUUID;
}

- (void)updateMultipartFormData:(id<AFMultipartFormData>)formData {
}

- (void)parseAPIResponse:(NSDictionary *)responseDictionary {
}

@end
