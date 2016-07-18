//
//  VerifyTokenApi.h
//  PaySay
//
//  Created by Pradeep Narendra on 7/7/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import <TTPLAPIManager/TTPLAPIManager.h>

@interface VerifyTokenApi : APIBase

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *grantType; // Should be same as password.

@end
