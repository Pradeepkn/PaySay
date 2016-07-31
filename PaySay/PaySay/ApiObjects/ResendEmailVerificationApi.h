//
//  ResendEmailVerificationApi.h
//  PaySay
//
//  Created by Pradeep Narendra on 7/31/16.
//  Copyright © 2016 Pradeep. All rights reserved.
//

#import <TTPLAPIManager/TTPLAPIManager.h>

@interface ResendEmailVerificationApi : APIBase

@property (nonatomic, strong) NSString *email;

@end
